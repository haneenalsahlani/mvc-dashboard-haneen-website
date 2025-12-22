import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/form_parts/edit_app_features_list.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/widgets/form_parts/app_form.dart';

class AddAppScreen extends StatelessWidget {
  const AddAppScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.go(homeRoute);
            },
          ),
        ],
        title: const Text('Add App'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Row(
                children: [
                  SizedBox(
                    width: constraints.maxWidth * 0.3,
                    height: constraints.maxHeight,
                    child: AppForm(
                      allowedConstaints: BoxConstraints(
                        maxWidth: constraints.maxWidth * 0.3,
                        maxHeight: constraints.maxHeight,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        EditAppFeaturesList(
                          height: constraints.maxHeight * 0.9,
                          width: constraints.maxWidth * 0.8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
