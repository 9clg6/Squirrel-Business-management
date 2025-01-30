import 'package:init/ui/screen/history/history.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history.view_model.g.dart';

///
/// [HistoryViewModel]
///
@riverpod
class HistoryViewModel extends _$HistoryViewModel {
  ///
  /// Constructor
  ///
  factory HistoryViewModel() {
    return HistoryViewModel._();
  }

  ///
  /// Private constructor
  ///
  HistoryViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  HistoryScreenState build() => HistoryScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
