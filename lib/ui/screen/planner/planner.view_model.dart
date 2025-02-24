import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/ui/screen/planner/planner.view_state.dart';

part 'planner.view_model.g.dart';

///
/// [PlannerViewModel]
///
@riverpod
class PlannerViewModel extends _$PlannerViewModel {
  ///
  /// Constructor
  ///
  factory PlannerViewModel() {
    return PlannerViewModel._();
  }

  ///
  /// Private constructor
  ///
  PlannerViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  PlannerScreenState build() => PlannerScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
