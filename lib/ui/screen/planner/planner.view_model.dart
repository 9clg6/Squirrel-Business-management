import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/ui/screen/planner/planner.view_state.dart';

part 'planner.view_model.g.dart';

/// [PlannerViewModel]
@riverpod
class PlannerViewModel extends _$PlannerViewModel {

  /// Build
  ///
  @override
  PlannerScreenState build() => PlannerScreenState.initial();
}
