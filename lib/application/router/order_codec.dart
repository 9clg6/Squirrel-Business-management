import 'dart:convert';

import 'package:squirrel/domain/entities/order.entity.dart';

/// {@category Application}
/// {@subCategory Router}
///
/// Codec for the order entity.
class OrderCodec extends Codec<Order, String> {
  /// @override
  /// @return [Converter<String, Order>] decoder
  @override
  Converter<String, Order> get decoder => _OrderDecoder();

  /// @override
  /// @return [Converter<Order, String>] encoder
  @override
  Converter<Order, String> get encoder => _OrderEncoder();
}

/// {@category Application}
/// {@subCategory Router}
///
/// Decoder for the order entity.
class _OrderDecoder extends Converter<String, Order> {
  /// @param [input] input
  /// @return [Order] order
  /// 
  @override
  Order convert(String input) {
    return Order.fromJson(jsonDecode(input));
  }
}

/// {@category Application}
/// {@subCategory Router}
///
/// Encoder for the order entity.
class _OrderEncoder extends Converter<Order, String> {
  /// @param [input] input
  /// @return [String] string
  /// 
  @override
  String convert(Order input) {
    return jsonEncode(input.toJson());
  }
} 