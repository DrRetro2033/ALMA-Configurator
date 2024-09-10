import 'package:fluent_ui/fluent_ui.dart';
import 'package:markdown_widget/widget/markdown.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MarkdownWidget(padding: EdgeInsets.all(16.0), data: """
# About this page
This page will go over some common issues with the base game and its expansions, and will give the recommended settings to fix them.

# F.E.A.R.
# Extraction Point
  
## <Unknown Error>
Extraction Point might launch with a **<Unknown Error>**. To fix this, you can try setting the following settings:

- **Run as Administrator** - This usually fixes the issue.
- **Run in Windows 7**
""");
  }
}
