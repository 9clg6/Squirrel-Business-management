import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/ui/screen/request/request.view_state.dart';

part 'request.view_model.g.dart';

/// [RequestViewModel]
@riverpod
class RequestViewModel extends _$RequestViewModel {
  /// Build
  ///
  @override
  RequestViewState build() => RequestViewState.initial();
}
