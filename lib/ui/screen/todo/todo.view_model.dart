import 'package:init/ui/screen/todo/todo.view_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo.view_model.g.dart';

///
/// [TodoViewModel]
///
@riverpod
class TodoViewModel extends _$TodoViewModel {
  ///
  /// Constructor
  ///
  factory TodoViewModel() {
    return TodoViewModel._();
  }

  ///
  /// Private constructor
  ///
  TodoViewModel._() {
    init();
  }

  ///
  /// Build
  ///
  @override
  TodoScreenState build() => TodoScreenState.initial();

  ///
  /// Init
  ///
  Future<void> init() async {}
}
