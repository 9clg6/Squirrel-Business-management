import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/entities/request.entity.dart';
import 'package:squirrel/domain/service/logger.service.dart';
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
    LoggerService.instance.i('[RequestService] 🔌 Initializing');
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
    LoggerService.instance
        .i('[RequestService] 📚 Request added: ${request.name}');
  }

  /// Toggle request
  ///
  void toggleRequest() {
    state = state.copyWith(isRequestShow: !state.isRequestShow);
    LoggerService.instance
        .i('[RequestService] 📚 Toggle request: ${state.isRequestShow}');
  }
}
