import 'package:fluent_ui/fluent_ui.dart';

class ModsPage extends StatefulWidget {
  const ModsPage({super.key});

  @override
  State<ModsPage> createState() => _ModsPageState();
}

class _ModsPageState extends State<ModsPage> {
  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 8.0));
  }
}

class ModButton extends StatefulWidget {
  final String archiveName;

  const ModButton({super.key, required this.archiveName});

  @override
  State<ModButton> createState() => _ModButtonState();
}

class _ModButtonState extends State<ModButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile.selectable(
      title: Text(widget.archiveName),
      selected: false,
    );
  }
}
