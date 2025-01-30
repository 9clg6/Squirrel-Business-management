import 'package:init/ui/screen/stats/stats.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stats.view_model.g.dart';

///
/// [StatsViewModel]
///
@riverpod
class StatsViewModel extends _$StatsViewModel {
  ///
  /// Constructor
  ///
  factory StatsViewModel() {
    return StatsViewModel._();
  }

  ///
  /// Private constructor
  ///
  StatsViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  StatsScreenState build() => StatsScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
