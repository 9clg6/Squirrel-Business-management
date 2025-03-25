import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/state/request.state.dart';

part 'request_service.g.dart';

/// [RequestService]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[],
)
class RequestService extends _$RequestService {
  /// Build
  ///
  @override
  RequestState build() {
    log('🔌 Initializing RequestService');
    return RequestState.initial();
  }

  /// Add request
  /// @param [request] request to add
  ///
  void addRequest(Request request) {
    state = state.copyWith(
      requests: <Request>[
        ...state.requests,
        request,
      ],
    );
    log('Request added: ${request.name}');
  }

  /// Toggle request
  ///
  void toggleRequest() {
    state = state.copyWith(isRequestShow: !state.isRequestShow);
  }
}
