import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/project/providers/editing_project_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/src/framework.dart';

class EditProjectScreen extends ConsumerWidget {
  const EditProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editingProject = ref.watch(editingProjectProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go(homeRoute);
            },
          ),
        ],
        title: Text("Edit Project"),
      ),
      body: Row(
        children: [
          SizedBox(width: 200, child: Column(children: [
                
              ],
            )),
          Expanded(child: Column(children: [
                
              ],
            )),
        ],
      ),
    );
  }
}
