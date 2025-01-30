import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Second screen
///
class TodoScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const TodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoScreenState();
}

///
/// State of the second screen
///
class _TodoScreenState extends ConsumerState<TodoScreen> {
  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}