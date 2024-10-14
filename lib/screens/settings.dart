import 'package:fear_patcher/core/game.dart';
import 'package:fear_patcher/widgets/invidiual_options.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:fear_patcher/widgets/resolution.dart';
import 'package:fear_patcher/widgets/text_fix.dart';
import 'package:fear_patcher/widgets/patch_checkbox.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: getFinalLayout(),
      ),
    );
  }

  List<Widget> getFinalLayout() {
    List<Widget> layout = getPatchSection();

    layout.add(getDivider());

    layout.addAll(getVisualSection());

    layout.add(const SizedBox(
      height: 10,
    ));

    layout.add(
      const Text("Invidiual Options",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );

    layout.add(getDivider());

    layout.addAll(getInvidiualSection());

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
      // PatchCheckbox(
      //   name: "EAX Support",
      //   tooltipMessage:
      //       "Tricks the games into thinking your computer has EAX support, which allows the games to have surround sound on modern hardware.",
      //   future: IndirectSound.isInstalled(),
      //   onChanged: (p0) {
      //     if (p0) {
      //       IndirectSound.install().then(
      //         (_) {
      //           setState(() {});
      //         },
      //       );
      //     } else {
      //       IndirectSound.uninstall().then((_) {
      //         setState(() {});
      //       });
      //     }
      //   },
      // ),
      // PatchCheckbox(
      //   tooltipMessage:
      //       "Replaces EXE with a patched version that allows more RAM to be utilized.",
      //   name: "4GB RAM Fix",
      //   future: Game.ramPatch,
      //   onChanged: (value) {
      //     Game.changeRamPatch(value).then((value) {
      //       setState(() {});
      //     });
      //   },
      // ),
    ];
  }

  List<Widget> getVisualSection() {
    return [
      const Text("Visuals",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10.0),
      const ResolutionWidget(),
      const SizedBox(height: 10.0),
      const Tooltip(
          message:
              "Increases the text scale at higher resolutions to make it more legible.",
          child: TextFixWidget()),
    ];
  }

  List<Widget> getInvidiualSection() {
    return [
      const SizedBox(height: 20.0),
      const InvidiualOptions(optionsFor: Expansion.base),
      const SizedBox(height: 40.0),
      const InvidiualOptions(optionsFor: Expansion.xp),
      const SizedBox(height: 40.0),
      const InvidiualOptions(optionsFor: Expansion.xp2),
    ];
  }

  Widget getDivider() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Divider(
          direction: Axis.horizontal,
        ));
  }
}
