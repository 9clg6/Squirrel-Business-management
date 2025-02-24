import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/state/request.state.dart';

/// [RequestService]
class RequestService extends StateNotifier<RequestState> {
  /// Request
  RequestState get requestState => state;

  /// Constructor
  ///
  RequestService() : super(RequestState.initial());

  /// Add request
  ///
  void addRequest(Request request) {
    state = state.copyWith(requests: [
      ...state.requests,
      request,
    ]);
    log('Request added: ${request.name}');
  }

  /// Toggle request
  ///
  void toggleRequest() {
    state = state.copyWith(isRequestShow: !state.isRequestShow);
  }
}
