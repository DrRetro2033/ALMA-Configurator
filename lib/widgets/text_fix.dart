import 'package:fluent_ui/fluent_ui.dart';

class TextFixWidget extends StatefulWidget {
  const TextFixWidget({super.key});

  static const Map<int, String> textFixes = {0: "None", 1: "1080", 2: "1440"};

  @override
  State<TextFixWidget> createState() => _TextFixWidgetState();
}

class _TextFixWidgetState extends State<TextFixWidget> {
  int currentlySelectedTextFix = 0;

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
                  onPressed: () {
                    setState(() {
                      currentlySelectedTextFix = e;
                    });
                  });
            }).toList(),
          )
        ]);
  }
}
