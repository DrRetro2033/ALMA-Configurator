import "package:fluent_ui/fluent_ui.dart";

class DGVoodoo2Panel extends StatefulWidget {
  const DGVoodoo2Panel({super.key});

  @override
  State<DGVoodoo2Panel> createState() => _DGVoodoo2PanelState();
}

class _DGVoodoo2PanelState extends State<DGVoodoo2Panel> {
  final bool _isInstalled = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          "dgVoodoo2 is a graphics wrapper, designed to help fix older games that developed for older hardware.",
      child: Column(children: [
        getInstallButton(),
        const SizedBox(height: 8.0),
        Button(
            onPressed:
                !_isInstalled ? null : () => debugPrint('pressed button'),
            focusable: false,
            child: const Text("Open dgVoodoo2 Control Panel")),
      ]),
    );
  }

  Widget getInstallButton() {
    if (true) {
      return Button(child: const Text("Install dgVoodoo2"), onPressed: () {});
      // ignore: dead_code
    } else {
      return Button(child: const Text("Uninstall dgVoodoo2"), onPressed: () {});
    }
  }
}
