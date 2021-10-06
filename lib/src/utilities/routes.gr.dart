// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import '../screen/home.dart' as _i3;
import '../settings/settings_controller.dart' as _i5;
import '../settings/settings_view.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return const _i3.HomePage();
        }),
    SettingsView.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<SettingsViewArgs>();
          return _i4.SettingsView(key: args.key, controller: args.controller);
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(SettingsView.name, path: '/settings-view')
      ];
}

class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class SettingsView extends _i1.PageRouteInfo<SettingsViewArgs> {
  SettingsView({_i2.Key? key, required _i5.SettingsController controller})
      : super(name,
            path: '/settings-view',
            args: SettingsViewArgs(key: key, controller: controller));

  static const String name = 'SettingsView';
}

class SettingsViewArgs {
  const SettingsViewArgs({this.key, required this.controller});

  final _i2.Key? key;

  final _i5.SettingsController controller;
}
