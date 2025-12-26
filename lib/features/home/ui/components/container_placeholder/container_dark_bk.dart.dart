import 'package:flutter/material.dart';

class ContainerDarkBk extends StatelessWidget {
  const ContainerDarkBk({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.surface.withAlpha(100),
            Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(50),
            Theme.of(context).colorScheme.surface.withAlpha(100),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
