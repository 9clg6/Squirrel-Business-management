import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:squirrel/ui/abstraction/view_state.abs.dart';

part 'auth.view_state.g.dart';

/// [AuthScreenState]
@CopyWith()
class AuthScreenState extends ViewStateAbs {
  /// Loading
  final bool loading;

  final bool isRequestLoading;

  /// Constructor
  /// @param [loading] loading
  /// @param [isRequestLoading] is request loading
  ///
  AuthScreenState({
    required this.loading,
    required this.isRequestLoading,
  });

  /// Initial
  ///
  AuthScreenState.initial({bool l = true})
      : loading = l,
        isRequestLoading = false;

  /// Props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
        isRequestLoading,
      ];
}
