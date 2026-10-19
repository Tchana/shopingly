"""Checks the Firestore security rules against the local Firebase emulators.

Run the emulators first:   firebase emulators:start --only auth,firestore,storage --project shopingly-9cd84
Then run this script:      python tool/check_rules.py

It creates throwaway users and documents in the *emulator only* (never in the real project)
and prints one line per rule check. Exit code 1 if any check fails.
"""
import json
import sys
import time
import urllib.error
import urllib.request

PROJECT = "shopingly-9cd84"
AUTH = "http://127.0.0.1:9099/identitytoolkit.googleapis.com/v1"
FS = f"http://127.0.0.1:8080/v1/projects/{PROJECT}/databases/(default)/documents"
RUN = str(int(time.time()))


def http(method, url, body=None, token=None):
    data = json.dumps(body).encode() if body is not None else None
    req = urllib.request.Request(url, data=data, method=method)
    req.add_header("Content-Type", "application/json")
    if token:
        req.add_header("Authorization", f"Bearer {token}")
    try:
        with urllib.request.urlopen(req, timeout=15) as resp:
            raw = resp.read()
            return resp.status, (json.loads(raw) if raw else {})
    except urllib.error.HTTPError as e:
        raw = e.read()
        try:
            return e.code, json.loads(raw)
        except Exception:
            return e.code, {}


def fs_value(v):
    if isinstance(v, bool):
        return {"booleanValue": v}
    if isinstance(v, int):
        return {"integerValue": str(v)}
    if isinstance(v, float):
        return {"doubleValue": v}
    if isinstance(v, str):
        return {"stringValue": v}
    if isinstance(v, list):
        return {"arrayValue": {"values": [fs_value(x) for x in v]}}
    if isinstance(v, dict):
        return {"mapValue": {"fields": {k: fs_value(x) for k, x in v.items()}}}
    raise TypeError(v)


def fields(d):
    return {"fields": {k: fs_value(v) for k, v in d.items()}}


def write(path, data, token=None, mask=None):
    url = f"{FS}/{path}"
    if mask:
        url += "?" + "&".join(f"updateMask.fieldPaths={m}" for m in mask)
    return http("PATCH", url, fields(data), token)[0]


def read(path, token=None):
    return http("GET", f"{FS}/{path}", token=token)[0]


def query(parent, collection, where=None, group=False, token=None):
    q = {"from": [{"collectionId": collection, **({"allDescendants": True} if group else {})}]}
    if where:
        field, value = where
        q["where"] = {"fieldFilter": {"field": {"fieldPath": field}, "op": "EQUAL", "value": fs_value(value)}}
    url = f"{FS}/{parent}:runQuery" if parent else f"{FS}:runQuery"
    status, body = http("POST", url, {"structuredQuery": q}, token)
    return status


def delete(path, token=None):
    return http("DELETE", f"{FS}/{path}", token=token)[0]


def sign_up(email):
    status, body = http("POST", f"{AUTH}/accounts:signUp?key=fake", {"email": email, "password": "Passw0rd!x", "returnSecureToken": True})
    return body["localId"], body["idToken"]


results = []


def check(name, actual, expected):
    ok = actual == expected
    results.append(ok)
    print(f"{'PASS' if ok else 'FAIL'}  {name}  (got {actual}, expected {expected})")


def allowed(code):
    """A request the rules accepted: success, or 'not found' for reads of documents that do not exist."""
    return 200 if code in (200, 404) else code


admin_uid, admin = sign_up(f"admin{RUN}@example.com")
a_uid, a = sign_up(f"a{RUN}@example.com")
b_uid, b = sign_up(f"b{RUN}@example.com")
OWNER = "owner"  # the emulator's rules-bypass token

write(f"Admins/{admin_uid}", {"createdBy": "check_rules"}, OWNER)

print("\n-- Admins collection")
check("admin can read own Admins doc", allowed(read(f"Admins/{admin_uid}", admin)), 200)
check("customer reading own (missing) Admins doc is allowed", allowed(read(f"Admins/{a_uid}", a)), 200)
check("customer cannot read someone else's Admins doc", read(f"Admins/{admin_uid}", a), 403)
check("admin cannot write Admins from a client", write(f"Admins/{a_uid}", {"x": "y"}, admin), 403)
check("customer cannot make themselves admin", write(f"Admins/{a_uid}", {"x": "y"}, a), 403)

print("\n-- Catalog")
product = {"title": "Rule test", "price": 10.0, "stock": 5, "isActive": True, "categoryIds": ["c1"]}
check("admin can create a product", write(f"Products/p{RUN}", product, admin), 200)
check("customer cannot create a product", write(f"Products/x{RUN}", product, a), 403)
check("customer cannot edit a product", write(f"Products/p{RUN}", {"price": 1.0}, a, mask=["price"]), 403)
check("anonymous can read a visible product", read(f"Products/p{RUN}"), 200)
write(f"Products/hidden{RUN}", {**product, "isActive": False}, admin)
check("anonymous cannot read a hidden product", read(f"Products/hidden{RUN}"), 403)
check("admin can read a hidden product", read(f"Products/hidden{RUN}", admin), 200)
check("anonymous visible-only query is allowed", query(None, "Products", ("isActive", True)), 200)
check("anonymous unfiltered product query is rejected", query(None, "Products"), 403)
write(f"Categories/c{RUN}", {"name": "Cat"}, admin)
check("anonymous can read categories", read(f"Categories/c{RUN}"), 200)
check("customer cannot write categories", write(f"Categories/c{RUN}", {"name": "Hacked"}, a), 403)
write(f"Settings/store", {"taxPercent": 10.0}, admin)
check("anyone can read store settings", read("Settings/store"), 200)
check("customer cannot change store settings", write("Settings/store", {"taxPercent": 0.0}, a), 403)

print("\n-- Customers' own data")
write(f"Users/{a_uid}", {"firstName": "A"}, a)
check("customer can create own profile", read(f"Users/{a_uid}", a), 200)
check("customer cannot read another profile", read(f"Users/{a_uid}", b), 403)
check("admin can read a customer profile", read(f"Users/{a_uid}", admin), 200)
check("customer cannot create someone else's profile", write(f"Users/{b_uid}", {"firstName": "x"}, a), 403)
write(f"Users/{a_uid}/Addresses/home", {"street": "1 Main"}, a)
check("customer can read own address", read(f"Users/{a_uid}/Addresses/home", a), 200)
check("customer cannot read another's address", read(f"Users/{a_uid}/Addresses/home", b), 403)
check("admin can read a customer's address", read(f"Users/{a_uid}/Addresses/home", admin), 200)
check("admin cannot write a customer's address", write(f"Users/{a_uid}/Addresses/home", {"street": "x"}, admin), 403)

print("\n-- Orders")
order = {
    "userId": a_uid, "status": "pending", "paymentStatus": "unpaid", "paymentMethod": "cashOnDelivery",
    "items": [{"productId": f"p{RUN}", "title": "Rule test", "price": 10.0, "quantity": 1}],
    "total": 10.0, "subtotal": 10.0,
}
check("customer can place an order", write(f"Orders/o{RUN}", order, a), 200)
check("customer cannot place an order for someone else", write(f"Orders/bad1{RUN}", {**order, "userId": b_uid}, a), 403)
check("customer cannot place an already-processing order", write(f"Orders/bad2{RUN}", {**order, "status": "processing"}, a), 403)
check("customer cannot place an already-paid order", write(f"Orders/bad3{RUN}", {**order, "paymentStatus": "paid"}, a), 403)
check("customer cannot place an empty order", write(f"Orders/bad4{RUN}", {**order, "items": []}, a), 403)
check("owner can read own order", read(f"Orders/o{RUN}", a), 200)
check("another customer cannot read the order", read(f"Orders/o{RUN}", b), 403)
check("admin can read any order", read(f"Orders/o{RUN}", admin), 200)
check("customer's own-orders query is allowed", query(None, "Orders", ("userId", a_uid), token=a), 200)
check("customer cannot query everyone's orders", query(None, "Orders", token=a), 403)
check("customer cannot mark their order paid", write(f"Orders/o{RUN}", {"paymentStatus": "paid"}, a, mask=["paymentStatus"]), 403)
check("customer cannot move their order to shipped", write(f"Orders/o{RUN}", {"status": "shipped"}, a, mask=["status"]), 403)
check("customer cannot change the total", write(f"Orders/o{RUN}", {"total": 0.0}, a, mask=["total"]), 403)
check("customer can cancel a pending order", write(f"Orders/o{RUN}", {"status": "cancelled"}, a, mask=["status"]), 200)
check("customer cannot reopen a cancelled order", write(f"Orders/o{RUN}", {"status": "pending"}, a, mask=["status"]), 403)
write(f"Orders/p2{RUN}", order, a)
check("admin can change order status", write(f"Orders/p2{RUN}", {"status": "processing"}, admin, mask=["status"]), 200)
check("customer cannot cancel once processing", write(f"Orders/p2{RUN}", {"status": "cancelled"}, a, mask=["status"]), 403)
check("nobody can delete orders", delete(f"Orders/p2{RUN}", admin), 403)

print("\n-- Reviews")
review = {"productId": f"p{RUN}", "userId": a_uid, "userName": "A", "rating": 4.0, "comment": "Nice", "createdAt": "2026-01-01T00:00:00Z"}
check("customer can review a product", write(f"Products/p{RUN}/Reviews/{a_uid}", review, a), 200)
check("customer cannot review as someone else", write(f"Products/p{RUN}/Reviews/{b_uid}", {**review, "userId": a_uid}, a), 403)
check("customer cannot post a rating above 5", write(f"Products/p{RUN}/Reviews/{b_uid}", {**review, "userId": b_uid, "rating": 6.0}, b), 403)
check("customer cannot add extra fields to a review", write(f"Products/p{RUN}/Reviews/{b_uid}", {**review, "userId": b_uid, "storeReply": "hi"}, b), 403)
check("anyone can read reviews", read(f"Products/p{RUN}/Reviews/{a_uid}"), 200)
check("customer can edit own comment", write(f"Products/p{RUN}/Reviews/{a_uid}", {"comment": "Edited"}, a, mask=["comment"]), 200)
check("customer cannot write the store reply", write(f"Products/p{RUN}/Reviews/{a_uid}", {"storeReply": "me"}, a, mask=["storeReply"]), 403)
check("another customer cannot edit the review", write(f"Products/p{RUN}/Reviews/{a_uid}", {"comment": "x"}, b, mask=["comment"]), 403)
check("admin can reply to a review", write(f"Products/p{RUN}/Reviews/{a_uid}", {"storeReply": "Thanks!"}, admin, mask=["storeReply"]), 200)
check("admin can list every review (collection group)", query(None, "Reviews", group=True, token=admin), 200)
check("customer cannot list every review", query(None, "Reviews", group=True, token=a), 403)
check("another customer cannot delete the review", delete(f"Products/p{RUN}/Reviews/{a_uid}", b), 403)
check("owner can delete own review", delete(f"Products/p{RUN}/Reviews/{a_uid}", a), 200)

print("\n-- Coupons")
write(f"Coupons/SECRET{RUN}", {"code": f"SECRET{RUN}", "isPublic": False, "isActive": True, "value": 50.0}, admin)
write(f"Coupons/PUBLIC{RUN}", {"code": f"PUBLIC{RUN}", "isPublic": True, "isActive": True, "value": 5.0}, admin)
check("signed-in customer can look up a code", read(f"Coupons/SECRET{RUN}", a), 200)
check("anonymous cannot look up a code", read(f"Coupons/SECRET{RUN}"), 403)
check("customer cannot list all coupons", query(None, "Coupons", token=a), 403)
check("customer can list public coupons", query(None, "Coupons", ("isPublic", True), token=a), 200)
check("admin can list all coupons", query(None, "Coupons", token=admin), 200)
check("customer cannot create coupons", write(f"Coupons/FREE{RUN}", {"value": 100.0}, a), 403)

passed = sum(results)
print(f"\n{passed}/{len(results)} checks passed")
sys.exit(0 if passed == len(results) else 1)
