import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/state/auth.state.dart';
import 'package:squirrel/ui/widgets/custom_app_bar/custom_app_bar.state.dart';

part 'custom_app_bar.view_model.g.dart';

/// [CustomAppBarViewModel]
@Riverpod(
  keepAlive: true,
  dependencies: <Object>[
    AuthService,
  ],
)
class CustomAppBarViewModel extends _$CustomAppBarViewModel {
  @override
  CustomAppBarState build() {
    final AsyncValue<AuthState> authState = ref.watch(authServiceProvider);
    ref.listen(authServiceProvider, (_, AsyncValue<AuthState> next) {
      state = state.copyWith(expirationDate: next.value?.expirationDate);
    });

    return CustomAppBarState(expirationDate: authState.value?.expirationDate);
  }
}
