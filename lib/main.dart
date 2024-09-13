import 'dart:io';

import 'package:fear_patcher/about.dart';
import 'package:fear_patcher/app_shell.dart';
import 'package:fear_patcher/core/game.dart';
import 'package:fear_patcher/guides.dart';
import 'package:fear_patcher/settings.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

import 'package:fear_patcher/launch.dart';

void main() {
  if (!Game.isGameInstalled()) {
    final lpCaption = 'No installation found!'.toNativeUtf16();
    final lpText = '''
ALMA Configurator cannot find an installation of F.E.A.R on your machine. Make sure you have F.E.A.R installed. Otherwise, try launching the base game first and try again.
'''
        .toNativeUtf16();
    final result = MessageBox(NULL, lpText, lpCaption,
        MESSAGEBOX_STYLE.MB_ICONERROR | MESSAGEBOX_STYLE.MB_OK);
    exit(1);
  }
  runApp(const MyApp());
  doWhenWindowReady(() {
    appWindow.minSize = const Size(800, 600);
    appWindow.alignment = Alignment.center;
    appWindow.show();
  });
}

final router = GoRouter(initialLocation: "/launch", routes: <RouteBase>[
  ShellRoute(
    routes: <RouteBase>[
      GoRoute(path: "/launch", builder: (context, state) => const LaunchPage()),
      GoRoute(
          path: "/settings", builder: (context, state) => const SettingsPage()),
      GoRoute(path: "/guides", builder: (context, state) => const GuidesPage()),
      GoRoute(path: "/about", builder: (context, state) => const AboutPage()),
    ],
    builder: (context, state, child) => AppShell(child: child),
  )
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp.router(
        darkTheme: FluentThemeData.dark(),
        themeMode: ThemeMode.dark,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider);
  }
}
