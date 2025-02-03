import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:init/domain/entities/order.entity.dart';

/// Order details screen
class OrderDetailsScreen extends ConsumerStatefulWidget {
  /// Constructor
  const OrderDetailsScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsScreenState();
}

///
/// State of the order details screen
///
class _OrderDetailsScreenState extends ConsumerState<OrderDetailsScreen> {
  ///
  /// Builds the order details screen
  ///
  @override
  Widget build(BuildContext context) {
    final Order order = GoRouterState.of(context).extra! as Order;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 220,
        title: const Text("Détails de la commande"),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: context.pop,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  const SizedBox(width: 10),
                  Text(
                    "Retour au dashboard",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      subtitle: const SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("@ojfewpo"),
                          ],
                        ),
                      ),
                      title: Text(order.clientContact),
                      leading: CircleAvatar(
                        child: Text(order.clientContact[0]),
                      ),
                      tileColor: Theme.of(context).colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: const ListTile(
                              subtitle: Text("Nombre de commandes"),
                              title: Text("3"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: const ListTile(
                              subtitle: Text("Parrainage"),
                              title: Text("1"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: const ListTile(
                              subtitle: Text("Montant total"),
                              title: Text("1000 €"),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: const ListTile(
                              subtitle: Text("Première commande"),
                              title: Text("2024-01-01"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
