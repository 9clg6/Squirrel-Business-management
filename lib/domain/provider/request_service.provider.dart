// ignore_for_file: avoid_public_notifier_properties
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/request_service.dart';
import 'package:squirrel/domain/state/request.state.dart';

part 'request_service.provider.g.dart';

/// [RequestServiceNotifier]
@Riverpod(keepAlive: true)
class RequestServiceNotifier extends _$RequestServiceNotifier {
  /// Service
  late final RequestService service;

  /// Build
  /// 
  @override
  RequestState build() {
    service = injector.get<RequestService>();

    service.addListener(
      (s) {
        state = RequestState.initial().copyWith(
          isRequestShow: s.isRequestShow,
          requests: s.requests,
        );
      },
    );

    return service.requestState;
  }
}
