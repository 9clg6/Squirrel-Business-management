import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// Stats screen
///
class StatsScreen extends ConsumerStatefulWidget {
  ///
  /// Constructor
  ///
  const StatsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StatsScreenState();
}

///
/// State of the stats screen
///
class _StatsScreenState extends ConsumerState<StatsScreen> {
  ///
  /// Builds the second screen
  ///
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}