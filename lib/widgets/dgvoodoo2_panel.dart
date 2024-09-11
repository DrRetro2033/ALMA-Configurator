import "package:fluent_ui/fluent_ui.dart";
import "package:fear_patcher/core/dgvoodoo2.dart";

import 'package:fear_patcher/core/game.dart';

class DGVoodoo2Panel extends StatefulWidget {
  const DGVoodoo2Panel({super.key, required this.expansion});

  final Expansion expansion;

  @override
  State<DGVoodoo2Panel> createState() => _DGVoodoo2PanelState();
}

class _DGVoodoo2PanelState extends State<DGVoodoo2Panel> {
  bool get _isInstalled => dgVoodoo2.isInstalled(widget.expansion);

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
                !_isInstalled ? null : () => dgVoodoo2.open(widget.expansion),
            child: const Text("Open dgVoodoo2 Control Panel")),
      ]),
    );
  }

  Widget getInstallButton() {
    if (!_isInstalled) {
      return Button(
          child: const Text("Install dgVoodoo2"),
          onPressed: () async {
            await dgVoodoo2.install(widget.expansion);
            setState(() {});
          });
      // ignore: dead_code
    } else {
      return Button(
          child: const Text("Uninstall dgVoodoo2"),
          onPressed: () async {
            await dgVoodoo2.uninstall(widget.expansion);
            setState(() {});
          });
    }
  }
}
