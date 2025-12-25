import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:haneen_site__api_dashboard/core/router/route_names.dart';
import 'package:haneen_site__api_dashboard/features/application/ui/screens/add_app_screen.dart';
import 'package:haneen_site__api_dashboard/features/auth/ui/screens/log_in_screen.dart';
import 'package:haneen_site__api_dashboard/features/blog/ui/screens/edit_blog_screen.dart';

import 'package:haneen_site__api_dashboard/features/home/ui/screens/home_screen.dart';
import 'package:haneen_site__api_dashboard/features/onboarding/ui/splash_screen.dart';
import 'package:haneen_site__api_dashboard/features/project/ui/screens/edit_project_screen.dart';
import 'package:haneen_site__api_dashboard/features/project/ui/screens/list_project_screen.dart';

import 'package:haneen_site__api_dashboard/features/teckstack/ui/screens/add_tech_stack_screen.dart';

/// The route configuration.
///
final router = GoRouter(
  initialLocation: splashRoute,
  routes: <RouteBase>[
    GoRoute(
      path: splashRoute,
      name: 'splash', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: loginRoute,
      name: 'login', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: homeRoute,
      name: 'home', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: editBlogRoute,
      name: 'addBlog', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return EditBlogScreen();
      },
    ),
    // GoRoute(
    //   path: blogsListRoute,
    //   name: 'blogsList', // Add names for easier navigation
    //   builder: (BuildContext context, GoRouterState state) {
    //     return BlogsListScreen();
    //   },
    // ),
    GoRoute(
      path: editAppRoute,
      name: 'addApp', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return AddAppScreen();
      },
    ),
    GoRoute(
      path: editTechStackRoute,
      name: 'addTechStack', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return AddTechStackScreen();
      },
    ),
    GoRoute(
      path: editProjectRoute,
      name: 'addProject', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return EditProjectScreen();
      },
    ),
    GoRoute(
      path: projectsListRoute,
      name: 'listProject', // Add names for easier navigation
      builder: (BuildContext context, GoRouterState state) {
        return ListProjectScreen();
      },
    ),
    // GoRoute(
    //   path: techStacksListRoute,
    //   name: 'techStacksList', // Add names for easier navigation
    //   builder: (BuildContext context, GoRouterState state) {
    //     return TechStacksListScreen();
    //   },
    // ),
  ],
  errorBuilder: (context, state) =>
      Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
);
