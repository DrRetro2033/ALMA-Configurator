import 'package:fluent_ui/fluent_ui.dart';

class PatchCheckbox extends StatelessWidget {
  final String tooltipMessage;
  final Future<bool> future;
  final Function(bool) onChanged;
  final String name;
  const PatchCheckbox(
      {super.key,
      required this.tooltipMessage,
      required this.future,
      required this.onChanged,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltipMessage,
      child: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const ProgressRing();
          } else {
            return Checkbox(
                content: Text(name),
                checked: snapshot.data,
                onChanged: (e) => onChanged(e!));
          }
        },
      ),
    );
  }
}
