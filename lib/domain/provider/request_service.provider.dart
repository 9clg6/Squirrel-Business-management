// ignore_for_file: avoid_public_notifier_properties
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/request_service.dart';
import 'package:init/domain/state/request.state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_service.provider.g.dart';

@Riverpod(keepAlive: true)
class RequestServiceNotifier extends _$RequestServiceNotifier {
  late final RequestService _service;

  @override
  RequestState build() {
    _service = injector.get<RequestService>();
    return _service.requestState;
  }

  void toggleRequest() {
    state = state.copyWith(
      isRequestShow: !state.isRequestShow,
    );
  }
}
