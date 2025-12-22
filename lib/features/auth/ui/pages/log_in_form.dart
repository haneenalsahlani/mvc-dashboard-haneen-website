import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/providers/loading_provider.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/auth/repository/auth_repo.dart';
import 'package:haneen_site__api_dashboard/features/auth/repository/credentials_provider.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogInScreenForm extends HookConsumerWidget {
  LogInScreenForm({super.key, required this.constraints});

  final _formKey = GlobalKey<FormState>();

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userController = useTextEditingController();
    var passController = useTextEditingController();
    var userFocus = useFocusNode();
    var passFocs = useFocusNode();
    final isLoading = ref.watch(loadingIndicatorProvider);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.6),
                SizedBox(
                  height: constraints.maxHeight * 0.4,
                  width: constraints.maxWidth * 0.4,
                  child: Column(
                    spacing: 20,
                    children: [
                      TextFormField(
                        focusNode: userFocus,
                        controller: userController,
                        keyboardType: .text,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder().copyWith(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                          label: Text("username"),
                        ),
                        onEditingComplete: () => passFocs.requestFocus(),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        focusNode: passFocs,
                        controller: passController,
                        keyboardType: .visiblePassword,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            bottom: 11,
                            top: 11,
                            right: 15,
                          ),
                          label: Text("password"),
                        ),

                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        width: .infinity,
                        child: OutlinedButton.icon(
                          clipBehavior: .hardEdge,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(loadingIndicatorProvider.notifier)
                                  .setLoading(true);
                              ref
                                  .read(loginProvider)
                                  .login(
                                    "${userController.text}:${passController.text}",
                                  )
                                  .then((value) {
                                    if (value != null) {
                                      ref
                                          .read(credentialsProvider.notifier)
                                          .updateCredentials(
                                            "${userController.text}:${passController.text}",
                                          );

                                      context.go(homeRoute);
                                    }
                                  });
                              ref
                                  .read(loadingIndicatorProvider.notifier)
                                  .setLoading(false);
                            }
                          },
                          label: Text("login"),
                          icon: Icon(Icons.login_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
