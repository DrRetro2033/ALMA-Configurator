import 'package:fear_patcher/core/app_manifest.dart';
import 'package:fear_patcher/widgets/dgvoodoo2_panel.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fear_patcher/core/game.dart';

class InvidiualOptions extends StatefulWidget {
  const InvidiualOptions({super.key, required this.optionsFor});

  final Expansion optionsFor;

  AppManifest get manifest => Game.getManifest(optionsFor);

  @override
  State<InvidiualOptions> createState() => _InvidiualOptionsState();
}

class _InvidiualOptionsState extends State<InvidiualOptions> {
  @override
  Widget build(BuildContext context) {
    // print(widget.manifest.runAsAdmin);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            alignment: Alignment.center,
            width: 500,
            height: 100,
            getExpansionLogoPath(),
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 10.0),
          Checkbox(
              checked: widget.manifest.runAsAdmin,
              content: const Text("Run as Administrator"),
              onChanged: (value) {
                setState(() {
                  widget.manifest.runAsAdmin = value!;
                });
              }),
          const SizedBox(height: 10.0),
          DGVoodoo2Panel(expansion: widget.optionsFor),
          const SizedBox(height: 10.0),
          const Divider(direction: Axis.horizontal)
        ]);
  }

  String getExpansionLogoPath() {
    switch (widget.optionsFor) {
      case Expansion.base:
        return "assets/images/fear_logo.png";
      case Expansion.xp:
        return "assets/images/fearxp_logo.png";
      case Expansion.xp2:
        return "assets/images/fearxp2_logo.png";
    }
  }
}
