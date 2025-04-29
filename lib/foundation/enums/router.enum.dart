/// Enum for the routes.
enum RouterEnum {
  /// Auth  
  auth('/auth', 'auth'),

  /// Main
  main('/main', 'main'),

  /// Order details
  orderDetails('/order-details', 'orderDetails'),

  /// Order create
  orderCreate('/order-create', 'orderCreate'),

  /// Order edit
  orderEdit('/order-edit', 'orderEdit'),

  // ignore: flutter_style_todos name of the page
  /// Todo
  todo('/todo', 'todo'),

  /// Stats
  stats('/stats', 'stats'),

  /// Planner
  planner('/planner', 'planner'),

  /// Clients
  customers('/customers', 'clients'),

  /// History
  history('/history', 'history'),

  /// Order delete
  orderDelete('/order-delete', 'orderDelete');

  /// Enum for the routes.
  /// @param path The path of the route.
  /// @param name The name of the route.
  /// 
  const RouterEnum(
    this.path,
    this.name,
  );

  /// The path of the route.
  final String path;

  /// The name of the route.
  final String name;
}
