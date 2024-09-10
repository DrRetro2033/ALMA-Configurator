import 'dart:io';
import 'package:fear_patcher/extensions.dart';

class Config {
  static const String configPathFEAR =
      "C:/Users/Public/Documents/Monolith Productions/FEAR/settings.cfg";
  static const String configPathFEARXP =
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP/settings.cfg";
  static const String configPathFEARXP2 =
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP2/settings.cfg";

  Resolution get resolution =>
      Resolution(_loadConfig()["ScreenWidth"], _loadConfig()["ScreenHeight"]);
  set resolution(Resolution resolution) {
    Map<String, dynamic> config = _loadConfig();
    config["ScreenWidth"] = resolution.width;
    config["ScreenHeight"] = resolution.height;
    _saveConfig(config);
  }

  Config() {
    _init();
  }

  void _init() {
    if (!File(configPathFEAR).existsSync()) {
      return;
    }
  }

  Map<String, dynamic> _loadConfig() {
    final file = File(configPathFEAR);
    if (!file.existsSync()) {
      return {};
    }
    Map<String, dynamic> config = {};
    for (String line in file.readAsLinesSync()) {
      if (line.contains(" ")) {
        final split = line.split(" ");
        config[split[0].removeQuotes()] = split[1].removeQuotes().parse();
      }
    }
    return config;
  }

  void _saveConfig(Map<String, dynamic> config) {
    final file = File(configPathFEAR);
    file.writeAsStringSync("");
    for (String key in config.keys) {
      bool isFinal = config.keys.last == key;
      if (config[key] is double) {
        file.writeAsStringSync(
            "\"$key\" \"${config[key].toString().addRequiredZerosToEnd()}\"${isFinal ? "" : "\n"}",
            mode: FileMode.append);
      } else {
        file.writeAsStringSync(
            "\"$key\" \"${config[key]}\"${isFinal ? "" : "\n"}",
            mode: FileMode.append);
      }
    }
    File(configPathFEAR).copySync(configPathFEARXP);
    File(configPathFEAR).copySync(configPathFEARXP2);
  }
}

class Resolution {
  final int width;
  final int height;

  const Resolution(this.width, this.height);

  @override
  String toString() {
    return "${width}x$height";
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is Resolution) {
      return width == other.width && height == other.height;
    }
    return false;
  }
}
