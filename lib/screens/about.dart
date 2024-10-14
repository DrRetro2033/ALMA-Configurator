import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:markdown_widget/markdown_widget.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Column(
          children: [
            Text(
              "This app was developed with ❤️ by:",
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 4.0),
            SizedBox(
              width: 220,
              height: 260,
              child: Button(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/me.png", fit: BoxFit.contain),
                    Text("DrRetro2033",
                        textAlign: TextAlign.center,
                        style: FluentTheme.of(context).typography.title)
                  ],
                ),
                onPressed: () {
                  Process.run("powershell.exe",
                      ["start", "https://github.com/DrRetro2033"]);
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Powered by:",
              style: FluentTheme.of(context).typography.subtitle,
            ),
            const SizedBox(height: 4.0),
            Button(
                child: const Column(
                  children: [
                    FlutterLogo(
                      size: 150.0,
                    ),
                    Text("Flutter", textAlign: TextAlign.center)
                  ],
                ),
                onPressed: () {
                  Process.run(
                      "powershell.exe", ["start", "https://flutter.dev"]);
                }),
          ],
        ),
        const MarkdownWidget(shrinkWrap: true, data: """
  # Credits
  ## References
  - [PCGamingWiki](https://www.pcgamingwiki.com/wiki/F.E.A.R.)

  ## Patches and Tools
  - [dgVoodoo2 by dege](https://dege.fw.hu/)
  - [DirectInput FPS Fix by Methanhydrat](https://community.pcgamingwiki.com/files/file/789-directinput-fps-fix/)
"""),
        Text(
          """
This project is a fan-made work and is not affiliated with, endorsed by, or sponsored by Monolith Productions, Warner Bros. Interactive Entertainment, or any other entities associated with the development and distribution of F.E.A.R. and its expansions. All trademarks, logos, and game content related to F.E.A.R. and its expansions are the property of their respective owners.
""",
          style: FluentTheme.of(context).typography.caption,
        ),
      ],
    );
  }
}
