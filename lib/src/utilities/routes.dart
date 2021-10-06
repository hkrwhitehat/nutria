import 'package:auto_route/auto_route.dart';
import 'package:nutria/src/screen/home.dart';
import 'package:nutria/src/settings/settings_view.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: <AutoRoute>[
  AutoRoute(page: HomePage, initial: true),
  AutoRoute(page: SettingsView),
])
class $AppRouter {}
