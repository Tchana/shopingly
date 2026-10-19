# Shopingly

A shopping app for customers (Flutter, Android/iOS/web) and a back office for the store's staff (Flutter web), both on one Firebase project.

| Folder | What it is |
|---|---|
| `lib/` | The customer mobile app. Browse, search, wishlist, cart, coupons, checkout, orders, reviews, profile. |
| `../shopingly_backoffice/` (next to this folder) | The staff web app. Dashboard, orders, products, categories, brands, banners, coupons, customers, reviews, settings. |
| `packages/shopingly_core/` | Shared Dart package: Firestore collection names, models, pricing and coupon rules. The back office repo carries an identical copy; keep them in sync (see below). |
| `firestore.rules`, `storage.rules`, `firestore.indexes.json` | Security rules and indexes. |
| `tool/check_rules.py` | Regression test for the security rules (runs against the emulators). |

## How the data flows

```
 customer app ──reads catalog, writes orders/reviews──▶  Firestore  ◀──manages everything── back office
                                                          Storage  ◀──product images────────┘
```

- Products, categories, brands, banners, coupons and the store settings (tax, shipping, currency) are edited in the back office and show up in the app.
- Orders placed in the app appear in the back office immediately. Moving an order from *pending* to *processing* takes the items out of stock in one transaction; cancelling puts them back. Cash-on-delivery orders are marked paid when delivered.
- Reviews are written by customers; staff can reply or remove them. The reply appears under the review in the app.
- The cart and wishlist are kept on the customer's device (per signed-in user).

## First-time setup

`lib/firebase_options.dart` and `android/app/google-services.json` are not committed. Generate them once per checkout (needs the Firebase CLI and access to the project):

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=shopingly-9cd84 --platforms=android,ios,web
```

The back office needs the same `lib/firebase_options.dart`; copy it from here into `../shopingly_backoffice/lib/`.

## Run it locally (no real Firebase data touched)

You need Flutter, Node (for the Firebase CLI) and Java 21+ (for the Firestore emulator).

```bash
# 1. Start the local Firebase emulators
firebase emulators:start --only auth,firestore,storage --project shopingly-9cd84

# 2. Create a staff account (emulator only) and make it an admin
python - <<'EOF'
import json, urllib.request
def call(url, body, method='POST', token=None):
    req = urllib.request.Request(url, json.dumps(body).encode(), method=method,
        headers={'Content-Type': 'application/json', **({'Authorization': 'Bearer ' + token} if token else {})})
    return json.loads(urllib.request.urlopen(req).read())
uid = call('http://127.0.0.1:9099/identitytoolkit.googleapis.com/v1/accounts:signUp?key=fake',
           {'email': 'admin@shopingly.test', 'password': 'Admin@12345', 'returnSecureToken': True})['localId']
call(f'http://127.0.0.1:8080/v1/projects/shopingly-9cd84/databases/(default)/documents/Admins/{uid}',
     {'fields': {'note': {'stringValue': 'local admin'}}}, 'PATCH', 'owner')
EOF

# 3. Back office on http://127.0.0.1:8766  (sign in, then Settings -> Load demo catalog)
cd ../shopingly_backoffice && flutter run -d web-server --web-port=8766 --dart-define=USE_FIREBASE_EMULATOR=true

# 4. Customer app on an Android phone (forward the emulator ports first)
adb reverse tcp:9099 tcp:9099 && adb reverse tcp:8080 tcp:8080
flutter run --dart-define=USE_FIREBASE_EMULATOR=true
```

Without `--dart-define=USE_FIREBASE_EMULATOR=true` both apps talk to the real project.

## Keeping the shared package in sync

The back office is a separate repo with its own copy of `packages/shopingly_core`. After changing the package here, copy it over and check:

```bash
cp -r packages/shopingly_core/lib packages/shopingly_core/test packages/shopingly_core/pubspec.yaml ../shopingly_backoffice/packages/shopingly_core/
python ../shopingly_backoffice/tool/check_core_in_sync.py
```

## Tests

```bash
cd packages/shopingly_core && flutter test      # pricing, coupons, models, order rules
python tool/check_rules.py                       # 62 security-rule checks (emulators must be running)
flutter analyze                                  # run here, in packages/shopingly_core/ and in ../shopingly_backoffice/
```

## Going live checklist

1. **Deploy the rules and indexes** (nothing works for customers or staff until the rules are in place):
   ```bash
   firebase deploy --only firestore:rules,firestore:indexes,storage
   ```
2. **Create the first admin.** In the Firebase console open Firestore, create the collection `Admins`, and add a document whose **ID is the staff member's user ID** (find it in Authentication). Any content works. Staff must first have an Email/Password account (create it in Authentication). Admin documents can only be created from the console; the app can never grant admin rights.
3. **Enable Firebase Storage** (Build, Storage) if you want to upload product images from the back office. Without it you can still paste image URLs.
4. **Publish the back office** (optional): `cd ../shopingly_backoffice && flutter build web --release`, then `firebase deploy --only hosting`. Add the hosting domain to Authentication, Settings, Authorized domains if it is not there already.
5. **Load the catalog**: sign in to the back office, open Settings, press *Load demo catalog* for sample data, or add your own products.
6. Run the customer app without the emulator flag (Android: `flutter run`, or build a release APK).

## Things to know

- **Prices and stock are enforced by the app, not the server.** The app re-checks every line against live data before placing an order, but a determined user with a modified client could still submit odd totals. If you take online payments, add a Cloud Function (needs the Blaze plan) that recomputes the total from the products and coupon.
- **Payment** is cash on delivery or mobile money confirmed by staff. There is no card gateway.
- **Search** runs on the device over the loaded catalog, which suits a few thousand products. Beyond that, move to a search service.
- Only Android, iOS and web are registered with Firebase. Desktop targets are not configured.
- Social sign-in buttons on the login screen are still decorative.
