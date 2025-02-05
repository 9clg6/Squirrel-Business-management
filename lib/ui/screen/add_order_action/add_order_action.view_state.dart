import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'add_order_action.view_state.g.dart';
    
/// [AddOrderActionViewState]
///
@CopyWith()
class AddOrderActionViewState extends ViewStateAbs {
  /// Selected date
  final DateTime? selectedDate;

  /// Constructor
  ///
  AddOrderActionViewState({this.selectedDate});

  /// Initial state
  ///
  factory AddOrderActionViewState.initial() => AddOrderActionViewState();

  @override
  List<Object?> get props => [
        selectedDate,
      ];
}
