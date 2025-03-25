import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'auth.view_state.g.dart';

/// [AuthScreenState]
@CopyWith()
class AuthScreenState extends ViewStateAbs {
  /// Constructor
  /// @param [loading] loading
  ///
  AuthScreenState({
    required this.loading,
  });

  /// Initial
  ///
  AuthScreenState.initial({bool l = true}) : loading = l;

  /// Loading
  final bool loading;

  /// Props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
