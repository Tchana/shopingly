import 'package:cloud_firestore/cloud_firestore.dart';

String readString(Map<String, dynamic> m, String key, [String fallback = '']) {
  final v = m[key];
  return v == null ? fallback : v.toString();
}

double readDouble(Map<String, dynamic> m, String key, [double fallback = 0]) {
  final v = m[key];
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v) ?? fallback;
  return fallback;
}

int readInt(Map<String, dynamic> m, String key, [int fallback = 0]) {
  final v = m[key];
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

bool readBool(Map<String, dynamic> m, String key, [bool fallback = false]) {
  final v = m[key];
  return v is bool ? v : fallback;
}

List<String> readStringList(Map<String, dynamic> m, String key) {
  final v = m[key];
  return v is List ? v.map((e) => e.toString()).toList() : <String>[];
}

DateTime? readDate(Map<String, dynamic> m, String key) {
  final v = m[key];
  if (v is Timestamp) return v.toDate();
  if (v is DateTime) return v;
  if (v is int) return DateTime.fromMillisecondsSinceEpoch(v);
  if (v is String) return DateTime.tryParse(v);
  return null;
}

/// Rounds to 2 decimals so money never accumulates floating point noise.
double roundMoney(double v) => (v * 100).roundToDouble() / 100;
