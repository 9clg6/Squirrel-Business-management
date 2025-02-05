import 'dart:convert';

import 'package:init/domain/entities/order.entity.dart';

class OrderCodec extends Codec<Order, String> {
  @override
  Converter<String, Order> get decoder => _OrderDecoder();

  @override
  Converter<Order, String> get encoder => _OrderEncoder();
}

class _OrderDecoder extends Converter<String, Order> {
  @override
  Order convert(String input) {
    return Order.fromJson(jsonDecode(input));
  }
}

class _OrderEncoder extends Converter<Order, String> {
  @override
  String convert(Order input) {
    return jsonEncode(input.toJson());
  }
} 