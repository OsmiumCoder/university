import 'package:flutter/material.dart';

/// Main sliver app bar to display
class SliverAppBarComponent extends StatelessWidget {
  /// Constructs a new [SliverAppBarComponent].
  const SliverAppBarComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[800],
      pinned: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('The UPEI Daily'),
        background: Image.asset('assets/bugle.png'),
      ),
    );
  }
}
