import 'package:fluent_ui/fluent_ui.dart';
import 'package:markdown_widget/widget/markdown.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MarkdownWidget(padding: EdgeInsets.all(16.0), data: """
# About this page
This page will go over some common issues, how to use dgVoodoo2, and will give more insight to how the ALMA Patcher fixes the games.

# dgVoodoo2

dgVoodoo2 is a graphics wrapper, designed to help fix older games that developed for older hardware. dgVoodoo2 is not required for the ALMA Patcher to work, but it is highly recommended, as it will allow fine control on the how the game is rendered and displayed. For example, The LithTech engine games is known to break at higher frame rates, and with the help of dgVoodoo2, ALMA Patcher can help fix this issue.

## Installing dgVoodoo2
To use dgVoodoo2, you need to press the **Install dgVoodoo2** button. You can install it for a particular expansion in the **Individual Options** section.

# F.E.A.R.

# Extraction Point
  
## <Unknown Error>
Extraction Point might launch with a **<Unknown Error>**. To fix this, you can try setting the following:

- **Run as Administrator** - This usually fixes the issue.

# Perseus Mandate
""");
  }
}
