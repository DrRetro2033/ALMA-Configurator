import 'package:fear_patcher/core/game.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LaunchButton(expansion: Expansion.base),
        SizedBox(
          height: 20.0,
        ),
        LaunchButton(expansion: Expansion.xp),
        SizedBox(
          height: 10.0,
        ),
        LaunchButton(expansion: Expansion.xp2),
      ],
    ));
  }
}

class LaunchButton extends StatelessWidget {
  const LaunchButton({super.key, required this.expansion});

  final Expansion expansion;

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: () {
        Game.launch(expansion);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(width: 30.0, height: 30.0, getExpansionIconPath()),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            "Launch ${getExpansionName()}.",
            textAlign: TextAlign.center,
            style: FluentTheme.of(context).typography.subtitle,
          ),
        ],
      ),
    );
  }

  String getExpansionName() {
    switch (expansion) {
      case Expansion.base:
        return "F.E.A.R";
      case Expansion.xp:
        return "Extraction Point";
      case Expansion.xp2:
        return "Perseus Mandate";
    }
  }

  String getExpansionIconPath() {
    switch (expansion) {
      case Expansion.base:
        return "assets/images/fear_icon.png";
      case Expansion.xp:
        return "assets/images/fearxp_icon.png";
      case Expansion.xp2:
        return "assets/images/fearxp2_icon.png";
    }
  }
}
