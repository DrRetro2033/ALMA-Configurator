import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final Iterable<NavigationPaneItem> items = [
    PaneItem(
        key: const ValueKey("/launch"),
        icon: const Icon(FluentIcons.arrow_up_right),
        title: const Text("Launch"),
        body: const SizedBox.shrink()),
    PaneItem(
        key: const ValueKey("/settings"),
        icon: const Icon(FluentIcons.settings),
        title: const Text("Settings"),
        body: const SizedBox.shrink()),
    // PaneItem(
    //     key: const ValueKey("/guides"),
    //     icon: const Icon(FluentIcons.sticky_notes_outline_app_icon),
    //     title: const Text("Guides"),
    //     body: const SizedBox.shrink()),
    PaneItem(
        key: const ValueKey("/about"),
        icon: const Icon(FluentIcons.info),
        title: const Text("About"),
        body: const SizedBox.shrink()),
  ].map<NavigationPaneItem>((e) => PaneItem(
        key: e.key,
        icon: e.icon,
        title: e.title,
        body: widget.child,
        onTap: () => setState(() {
          final path = (e.key as ValueKey).value;
          if (GoRouterState.of(context).uri.toString() != path) {
            GoRouter.of(context).go(path!);
          }
        }),
      ));
  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: _calculateSelectedIndex(context),
        items: items.toList(),
      ),
      appBar: NavigationAppBar(
        automaticallyImplyLeading: false,
        actions: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: GestureDetector(
                    onPanStart: (details) => appWindow.startDragging())),
            const WindowButtons(),
          ],
        ),
        title: const Text("ALMA Configurator",
            style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    int indexOriginal = items
        .where((item) => item.key != null)
        .toList()
        .indexWhere((item) => item.key == Key(location));
    return indexOriginal;
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          height: 50,
          child: MinimizeWindowButton(
            colors: WindowButtonColors(iconNormal: Colors.white),
          ),
        ),
        SizedBox(
          height: 50,
          child: MaximizeWindowButton(
              colors: WindowButtonColors(iconNormal: Colors.white)),
        ),
        SizedBox(
            height: 50,
            child: CloseWindowButton(
                colors: WindowButtonColors(iconNormal: Colors.white))),
      ],
    );
  }
}
