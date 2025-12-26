import 'package:flutter/material.dart';
import 'package:haneen_site__api_dashboard/core/widgets/image_from_url_card.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.app});
  final AppModel app;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Text(app.title),
              Spacer(),
              ImageFromUrlCard(imageUrl: app.icon, width: 50, height: 50),
            ],
          ),
          Text(app.description),
          Text(app.developmentStage ?? ""),
        ],
      ),
    );
  }
}
