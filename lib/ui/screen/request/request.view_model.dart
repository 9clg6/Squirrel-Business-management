import 'package:init/ui/screen/request/request.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request.view_model.g.dart';

/// [RequestViewModel]
@riverpod
class RequestViewModel extends _$RequestViewModel {
  @override
  RequestViewState build() => RequestViewState.initial();
}
