import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:haneen_site__api_dashboard/features/application/models/app_model.dart';

class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key, required AppModel app}) : _app = app;

  final AppModel _app;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      _app.icon,
      width: 40,
      height: 40,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.error, color: Theme.of(context).colorScheme.error);
      },
    );
  }
}
