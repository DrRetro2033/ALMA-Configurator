import 'package:fluent_ui/fluent_ui.dart';
import 'package:fear_patcher/core/game.dart';

class TextFixWidget extends StatefulWidget {
  const TextFixWidget({super.key});

  static const Map<TextScale, String> textFixes = {
    TextScale.none: "None",
    TextScale.big: "1080",
    TextScale.bigger: "1440"
  };

  @override
  State<TextFixWidget> createState() => _TextFixWidgetState();
}

class _TextFixWidgetState extends State<TextFixWidget> {
  TextScale currentlySelectedTextFix = Game.getTextScale();

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Text Scale Fix"),
          DropDownButton(
            leading: Text(TextFixWidget.textFixes[currentlySelectedTextFix]!),
            items: TextFixWidget.textFixes.keys.map((e) {
              return MenuFlyoutItem(
                  text: Text(TextFixWidget.textFixes[e]!),
                  selected: currentlySelectedTextFix == e,
                  onPressed: () async {
                    Game.changeTextScale(e).then((value) {
                      setState(() {
                        currentlySelectedTextFix = e;
                      });
                    });
                  });
            }).toList(),
          )
        ]);
  }
}
