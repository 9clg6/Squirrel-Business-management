import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:init/application/providers/initializer.dart';
import 'package:init/domain/service/order.service.dart';
import 'package:init/ui/abstraction/view_state.abs.dart';

part 'clients.view_state.g.dart';

///
/// [ClientsScreenState]
///
@CopyWith()
class ClientsScreenState extends ViewStateAbs {
  /// Loading state
  final bool? loading;

  /// Order service
  final OrderService orderService;

  ///
  /// Constructor
  ///
  ClientsScreenState(this.loading) : orderService = injector<OrderService>();

  ///
  /// Initial state
  ///
  ClientsScreenState.initial()
      : loading = true,
        orderService = injector<OrderService>();

  ///
  /// Get props
  ///
  @override
  List<Object?> get props => <Object?>[
        loading,
      ];
}
