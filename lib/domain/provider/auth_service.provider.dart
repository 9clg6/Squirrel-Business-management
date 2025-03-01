import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/application/providers/initializer.dart';
import 'package:squirrel/domain/service/auth.service.dart';
import 'package:squirrel/domain/state/auth.state.dart';

part 'auth_service.provider.g.dart';

/// [AuthServiceNotifier]
@Riverpod(keepAlive: true)
class AuthServiceNotifier extends _$AuthServiceNotifier {
  /// Constructor
  ///
  AuthServiceNotifier();

  /// Build
  ///
  @override
  AuthState build() {
    final service = injector.get<AuthService>();

    service.addListener(
      (s) => state = s,
    );

    return service.authState;
  }
}
