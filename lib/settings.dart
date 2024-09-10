import 'package:fear_patcher/core/game.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:fear_patcher/widgets/resolution.dart';
import 'package:fear_patcher/widgets/text_fix.dart';
import 'package:fear_patcher/widgets/patch_checkbox.dart';
import 'package:fear_patcher/widgets/dgvoodoo2_panel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: getFinalLayout(),
      ),
    );
  }

  List<Widget> getFinalLayout() {
    List<Widget> layout = getPatchSection();

    layout.add(const SizedBox(height: 20.0));

    layout.addAll(getVisualSection());

    return layout;
  }

  List<Widget> getPatchSection() {
    return [
      const Text("Patches",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      PatchCheckbox(
        tooltipMessage:
            "Adds a DLL that fixes DirectInput slowing down the game.",
        name: "DirectInput Fix",
        future: Game.directInputPatch,
        onChanged: (value) {
          Game.changeDirectInputPatch(value).then((value) {
            setState(() {});
          });
        },
      ),
      const SizedBox(height: 10.0),
      PatchCheckbox(
        tooltipMessage:
            "Replaces EXE with a patched version that allows more RAM to be utilized.",
        name: "4GB RAM Fix",
        future: Game.ramPatch,
        onChanged: (value) {
          Game.changeRamPatch(value).then((value) {
            setState(() {});
          });
        },
      ),
      const SizedBox(height: 10.0),
      const DGVoodoo2Panel(),
    ];
  }

  List<Widget> getVisualSection() {
    return [
      const Text("Visuals",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const ResolutionWidget(),
      const SizedBox(height: 10.0),
      const Tooltip(
          message:
              "Increases the text scale at higher resolutions to make it more legible.",
          child: TextFixWidget()),
    ];
  }
}
