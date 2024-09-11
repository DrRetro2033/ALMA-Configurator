import 'package:fluent_ui/fluent_ui.dart';
import 'package:markdown_widget/widget/markdown.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MarkdownWidget(padding: EdgeInsets.all(16.0), data: """
# About this page
This page will go over some common issues, how to use dgVoodoo2, and give more insight on how the ALMA Patcher fixes the games.

# Using dgVoodoo2

dgVoodoo2 is a graphics wrapper, designed to help fix older games that developed for older hardware. It can be 

# F.E.A.R.

# Extraction Point
  
## <Unknown Error>
Extraction Point might launch with a **<Unknown Error>**. To fix this, you can try setting the following:

- **Run as Administrator** - This usually fixes the issue.

# Perseus Mandate
""");
  }
}
