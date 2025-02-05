import 'dart:convert';

///
/// [SerializableMixin]
///
mixin SerializableMixin {
  /// convert to json
  Map<String, dynamic> toJson();

  /// serialize data
  String serialize() {
    return jsonEncode(toJson());
  }
}
