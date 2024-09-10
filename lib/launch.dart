import 'package:fear_patcher/core/game.dart';
import 'package:fluent_ui/fluent_ui.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Button(
          onPressed: () {
            Game.launch(Expansion.base);
          },
          child: const Text(
            "Launch F.E.A.R.",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Button(
          onPressed: () {
            Game.launch(Expansion.xp);
          },
          child: const Text(
            "Launch Extraction Point.",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}
