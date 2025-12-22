import 'package:flutter/material.dart';

class AppRelatedTechListWidget extends StatelessWidget {
  const AppRelatedTechListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Icon(Icons.add);
        },
      ),
    );
  }
}
