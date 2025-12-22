import 'package:flutter/material.dart';

import 'package:haneen_site__api_dashboard/core/router/app_router.dart';
import 'package:haneen_site__api_dashboard/core/services/messanger_service.dart';
import 'package:haneen_site__api_dashboard/core/theme/color_scheme.dart';
import 'package:haneen_site__api_dashboard/core/theme/styles/text_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: MessengerService.messengerKey,
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: appColorScheme,
        textTheme: KTextTheme,
      ),
    );
  }
}
