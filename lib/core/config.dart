import 'dart:io';
import 'package:fear_patcher/extensions.dart';

sealed class Config {
  String get configPathFEAR => "";
  String get configPathFEARXP => "";
  String get configPathFEARXP2 => "";

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
    if (!file.existsSync()) {
      file.createSync();
    }
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

class Settings extends Config {
  @override
  String get configPathFEAR =>
      "C:/Users/Public/Documents/Monolith Productions/FEAR/settings.cfg";
  @override
  String get configPathFEARXP =>
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP/settings.cfg";
  @override
  String get configPathFEARXP2 =>
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP2/settings.cfg";

  Resolution get resolution =>
      Resolution(_loadConfig()["ScreenWidth"], _loadConfig()["ScreenHeight"]);
  set resolution(Resolution resolution) {
    Map<String, dynamic> config = _loadConfig();
    config["ScreenWidth"] = resolution.width;
    config["ScreenHeight"] = resolution.height;
    _saveConfig(config);
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

enum WindowMode {
  fullscreen,
  windowed,
  borderless,
}

class AutoExec extends Config {
  @override
  String get configPathFEAR =>
      "C:/Users/Public/Documents/Monolith Productions/FEAR/autoexec.cfg";

  @override
  String get configPathFEARXP =>
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP/autoexec.cfg";

  @override
  String get configPathFEARXP2 =>
      "C:/Users/Public/Documents/TimeGate Studios/FEARXP2/autoexec.cfg";

  WindowMode get windowMode => _getWindowMode();
  set windowMode(WindowMode mode) {
    Map<String, dynamic> config = _loadConfig();
    config["Windowed"] = mode.index;
    _saveConfig(config);
  }

  WindowMode _getWindowMode() {
    Map<String, dynamic> config = _loadConfig();
    if (!config.containsKey("Windowed")) {
      return WindowMode.fullscreen;
    } else {
      if (config["Windowed"] == 1) {
        return WindowMode.windowed;
      } else if (config["Windowed"] == 2) {
        return WindowMode.borderless;
      }
    }
    return WindowMode.fullscreen;
  }

  String getWindowModeString(WindowMode windowMode) {
    switch (windowMode) {
      case WindowMode.fullscreen:
        return "Fullscreen";
      case WindowMode.windowed:
        return "Windowed";
      case WindowMode.borderless:
        return "Borderless";
    }
  }
}
