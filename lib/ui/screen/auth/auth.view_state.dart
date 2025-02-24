import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'auth.view_state.g.dart';

@CopyWith()
class AuthState extends ViewStateAbs {
  final bool loading;

  AuthState({required this.loading});

  AuthState.initial() : loading = true;

  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
