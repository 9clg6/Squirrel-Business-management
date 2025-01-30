import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Second screen
///
class ClientsScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const ClientsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClientsScreenState();
}

///
/// State of the second screen
///
class _ClientsScreenState extends ConsumerState<ClientsScreen> {
  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Clients'),
      ),
    );
  }
}