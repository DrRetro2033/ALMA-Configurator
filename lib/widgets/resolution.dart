import 'package:fluent_ui/fluent_ui.dart';
import 'package:fear_patcher/core/config.dart';

class ResolutionWidget extends StatefulWidget {
  const ResolutionWidget({super.key});

  static const Map<String, List<Resolution>> resolutions = {
    "4:3": [
      Resolution(640, 480),
      Resolution(800, 600),
      Resolution(1024, 768),
      Resolution(1280, 960),
    ],
    "16:9": [
      Resolution(1280, 720),
      Resolution(1920, 1080),
      Resolution(2560, 1440),
      Resolution(3840, 2160),
    ],
    "16:10": [
      Resolution(1280, 800),
      Resolution(1440, 900),
      Resolution(1680, 1050),
    ],
    "5:4": [
      Resolution(1280, 1024),
    ],
  };

  @override
  State<ResolutionWidget> createState() => _ResolutionWidgetState();
}

class _ResolutionWidgetState extends State<ResolutionWidget> {
  String get currentlySelectedRatio => _getRatio();
  set currentlySelectedRatio(String value) {
    Config().resolution = ResolutionWidget.resolutions[value]![0];
  }

  int get currentlySelectedResolution => _findSelectedResolution();
  set currentlySelectedResolution(int value) {
    Config().resolution =
        ResolutionWidget.resolutions[currentlySelectedRatio]![value];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Resolution",
        ),
        const SizedBox(width: 10.0),
        Row(
          children: [
            DropDownButton(
                leading: Text(currentlySelectedRatio),
                items: ResolutionWidget.resolutions.keys
                    .map((e) => MenuFlyoutItem(
                        text: Text(e),
                        selected: checkIfRatioSelected(e),
                        onPressed: () {
                          setState(() {
                            currentlySelectedRatio = e;
                          });
                        }))
                    .toList()),
            DropDownButton(
                leading: Text(
                  ResolutionWidget.resolutions[currentlySelectedRatio]![
                          currentlySelectedResolution]
                      .toString(),
                ),
                items: ResolutionWidget.resolutions[currentlySelectedRatio]!
                    .map((e) => MenuFlyoutItem(
                        text: Text(e.toString()),
                        selected: currentlySelectedResolution ==
                            ResolutionWidget
                                .resolutions[currentlySelectedRatio]!
                                .indexOf(e),
                        onPressed: () {
                          setState(() {
                            currentlySelectedResolution = ResolutionWidget
                                .resolutions[currentlySelectedRatio]!
                                .indexOf(e);
                          });
                        }))
                    .toList())
          ],
        ),
      ],
    );
  }

  int _findSelectedResolution() {
    int index = 0;
    Resolution resolution = Config().resolution;
    print(resolution);
    for (var key in ResolutionWidget.resolutions.keys) {
      if (ResolutionWidget.resolutions[key]!.contains(resolution)) {
        index = ResolutionWidget.resolutions[key]!.indexOf(resolution);
        break;
      }
    }
    return index;
  }

  String _getRatio() {
    Resolution resolution = Config().resolution;
    for (var key in ResolutionWidget.resolutions.keys) {
      if (ResolutionWidget.resolutions[key]!.contains(resolution)) {
        return key;
      }
    }
    return "";
  }

  bool checkIfRatioSelected(String ratio) {
    return ratio == _getRatio();
  }
}
