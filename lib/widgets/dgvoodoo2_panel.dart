import "package:fluent_ui/fluent_ui.dart";
import "package:fear_patcher/core/libraries.dart";
import "package:flutter/material.dart" as material;
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
          const Text("dgVoodoo2",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Tooltip(
              message:
                  "dgVoodoo2 is a graphics wrapper, designed to help fix older games that were developed for older hardware.",
              child: getInstallButton()),
          // const SizedBox(height: 8.0),
          // Button(
          //     onPressed:
          //         !_isInstalled ? null : () => dgVoodoo2.open(widget.expansion),
          //     child: const Text("Open dgVoodoo2 Control Panel")),
          const SizedBox(height: 10.0),
          const Text("Visuals", style: TextStyle(fontSize: 20.0)),
          // DropDownButton(leading: getFullScreenIcon(), items: [
          //   MenuFlyoutItem(
          //       leading: const Icon(material.Icons.open_in_full_sharp),
          //       text: const Text("Full Screen"),
          //       onPressed: () {
          //         dgVoodoo2.setFullscreen(widget.expansion, true);
          //         setState(() {});
          //       }),
          //   MenuFlyoutItem(
          //       leading: const Icon(material.Icons.desktop_windows_sharp),
          //       text: const Text("Windowed"),
          //       onPressed: () {
          //         dgVoodoo2.setFullscreen(widget.expansion, false);
          //         setState(() {});
          //       }),
          // ]),
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
          const SizedBox(height: 8.0),
          Checkbox(
              content: const Text("Force VSync"),
              checked: dgVoodoo2.vsync(widget.expansion),
              onChanged: !_isInstalled
                  ? null
                  : (value) {
                      dgVoodoo2.setVsync(widget.expansion, value!);
                      setState(() {});
                    }),
          const SizedBox(height: 8.0),
          const Row(
            mainAxisSize: MainAxisSize.min,
          ),
        ]);
  }

  Widget getFullScreenIcon() {
    if (dgVoodoo2.fullscreen(widget.expansion)) {
      return const Row(
        children: [
          Text("Full Screen"),
          SizedBox(width: 10.0),
          Icon(material.Icons.open_in_full_sharp),
        ],
      );
    } else {
      return const Row(
        children: [
          Text("Windowed"),
          SizedBox(width: 10.0),
          Icon(material.Icons.desktop_windows_sharp),
        ],
      );
    }
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
