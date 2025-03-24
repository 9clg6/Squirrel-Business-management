/// Enum for the routes.
enum RouterEnum {
  auth('/auth', 'auth'),
  main('/main', 'main'),
  orderDetails('/order-details', 'orderDetails'),
  orderCreate('/order-create', 'orderCreate'),
  orderEdit('/order-edit', 'orderEdit'),
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
