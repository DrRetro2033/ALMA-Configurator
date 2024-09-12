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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tooltip(
              message:
                  "dgVoodoo2 is a graphics wrapper, designed to help fix older games that developed for older hardware.",
              child: getInstallButton()),
          const SizedBox(height: 8.0),
          Button(
              onPressed:
                  !_isInstalled ? null : () => dgVoodoo2.open(widget.expansion),
              child: const Text("Open dgVoodoo2 Control Panel")),
          const SizedBox(height: 20.0),
          Text("Advanced Options",
              style: FluentTheme.of(context).typography.bodyLarge),
          Text(
              "Frame Rate Cap: ${dgVoodoo2.getFrameRateCap(widget.expansion) == 0 ? "Unlimited" : dgVoodoo2.getFrameRateCap(widget.expansion)} FPS"),
          SizedBox(
            width: 300.0,
            child: Slider(
                onChanged: !_isInstalled
                    ? null
                    : (value) {
                        dgVoodoo2.setFrameRateCap(
                            widget.expansion, value.toInt());
                        setState(() {});
                      },
                value: dgVoodoo2.getFrameRateCap(widget.expansion) / 1.0,
                min: 0,
                max: 144.0),
          ),
        ]);
  }

  Widget getInstallButton() {
    if (!_isInstalled) {
      return Button(
          child: const Text("Install dgVoodoo2"),
          onPressed: () async {
            await dgVoodoo2.install(widget.expansion);
            if (mounted) {
              showContentDialog(context);
            }
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

  void showContentDialog(BuildContext context) async {
    // ignore: unused_local_variable
    final result = await showDialog<String>(
      context: context,
      builder: (context) => ContentDialog(
        title: const Text('Notice'),
        content: const Text(
          'Before using dgVoodoo2, please go to Guides and read about the "IMPORTANT STEP", before configuring anything in the dgVoodoo2 Control Panel.',
        ),
        actions: [
          FilledButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
    setState(() {});
  }
}
