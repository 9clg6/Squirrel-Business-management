import 'dart:convert';

/// [SerializableMixin]
mixin SerializableMixin {
  /// convert to json
  /// @return [Map<String, dynamic>] json
  ///
  Map<String, dynamic> toJson();

  /// serialize data
  /// @return [String] serialized data
  ///
  String serialize() {
    return jsonEncode(toJson());
  }
}
