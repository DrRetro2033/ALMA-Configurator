import 'dart:io';

import "package:fear_patcher/core/game.dart";
import 'package:flutter/services.dart';

// ignore: camel_case_types
class dgVoodoo2 {
  static const String fpsLimitSection =
      "FPSLimit                             = ";
  static const String watermarkSection =
      "dgVoodooWatermark                   = ";
  static const String vsyncSection = "ForceVerticalSync                   = ";

  static bool _isInstalled(Expansion expansion) {
    if (File("${Game.getDirForExpansion(expansion)}/D3D9.dll").existsSync()) {
      return true;
    }
    return false;
  }

  static bool isInstalled(Expansion expansion) {
    return _isInstalled(expansion);
  }

  static Future<void> install(Expansion expansion) async {
    await _install(Game.getDirForExpansion(expansion));
  }

  static Future<void> uninstall(Expansion expansion) async {
    await _uninstall(Game.getDirForExpansion(expansion));
  }

  // static void open(Expansion expansion) {
  //   if (_isInstalled(expansion)) {
  //     Process.run("${Game.getDirForExpansion(expansion)}/dgVoodooCpl.exe", []);
  //   }
  // }

  static Future<void> _install(String path) async {
    // ByteData app =
    //     await rootBundle.load("assets/patches/dgVoodoo2/dgVoodooCpl.exe");
    ByteData dll =
        await rootBundle.load("assets/patches/dgVoodoo2/MS/x86/D3D9.dll");
    ByteData conf =
        await rootBundle.load("assets/patches/dgVoodoo2/dgVoodoo.conf");

    // File appFile = File("$path/dgVoodooCpl.exe");
    File dllFile = File("$path/D3D9.dll");
    File confFile = File("$path/dgVoodoo.conf");

    // if (appFile.existsSync()) {
    //   appFile.deleteSync();
    // }
    // appFile.createSync();

    if (!confFile.existsSync()) {
      confFile.createSync();
      confFile.writeAsBytesSync(conf.buffer.asUint8List());
    }

    if (dllFile.existsSync()) {
      dllFile.deleteSync();
    }
    dllFile.createSync();

    // appFile.writeAsBytesSync(app.buffer.asUint8List());
    dllFile.writeAsBytesSync(dll.buffer.asUint8List());

    // final assestManifest = await rootBundle.loadString('AssetManifest.json');

    // final assestMap = jsonDecode(assestManifest) as Map<String, dynamic>;

    // final paths = assestMap.keys
    //     .where((key) => key.contains("patches/dgVoodoo2/"))
    //     .toList();

    // for (final x in paths) {
    //   ByteData data = await rootBundle.load(x);
    //   if (File("$path/${x.replaceFirst("assets/patches/dgVoodoo2/", "")}")
    //       .existsSync()) {
    //     File("$path/${x.replaceFirst("assets/patches/dgVoodoo2/", "")}")
    //         .deleteSync();
    //   }
    //   File("$path/${x.replaceFirst("assets/patches/dgVoodoo2/", "")}")
    //       .createSync(recursive: true);
    //   File("$path/${x.replaceFirst("assets/patches/dgVoodoo2/", "")}")
    //       .writeAsBytesSync(data.buffer.asUint8List());
    // }
  }

  static Future<void> _uninstall(String path) async {
    // File appFile = File("$path/dgVoodooCpl.exe");
    File dllFile = File("$path/D3D9.dll");

    // if (appFile.existsSync()) {
    //   appFile.deleteSync();
    // }
    if (dllFile.existsSync()) {
      dllFile.deleteSync();
    }
  }

  static int getFrameRateCap(Expansion expansion) {
    int index = _findLineInConfFile(expansion, fpsLimitSection);
    if (index != -1) {
      return int.parse(_getLinesInConfFile(expansion)[index]
          .replaceFirst(fpsLimitSection, ""));
    }
    return 0;
  }

  static Future<void> setFrameRateCap(Expansion expansion, int fpsLimit) async {
    int index = _findLineInConfFile(expansion, fpsLimitSection);
    if (index == -1) {
      return;
    }
    List<String> lines = _getLinesInConfFile(expansion);
    lines[index] = fpsLimitSection + fpsLimit.toString();
    _writeConfFile(expansion, lines);
  }

  static bool showWatermark(Expansion expansion) {
    int index = _findLineInConfFile(expansion, watermarkSection);
    if (index == -1) {
      return false;
    }
    return _getLinesInConfFile(expansion)[index]
            .replaceFirst(watermarkSection, "") ==
        "true";
  }

  static void setWatermark(Expansion expansion, bool show) {
    int index = _findLineInConfFile(expansion, watermarkSection);
    if (index == -1) {
      return;
    }
    List<String> lines = _getLinesInConfFile(expansion);
    lines[index] = watermarkSection + (show ? "true" : "false");
    _writeConfFile(expansion, lines);
  }

  static bool vsync(Expansion expansion) {
    int index = _findLineInConfFile(expansion, vsyncSection);
    if (index == -1) {
      return false;
    }
    return _getLinesInConfFile(expansion)[index]
            .replaceFirst(vsyncSection, "") ==
        "true";
  }

  static void setVsync(Expansion expansion, bool vsync) {
    int index = 0;
    List<String> lines = _getLinesInConfFile(expansion);
    int offset = 0;
    while (index != -1) {
      index = _findLineInConfFile(expansion, vsyncSection, start: offset);
      offset = index + 1;
      if (index == -1) {
        break;
      }
      lines[index] = vsyncSection + (vsync ? "true" : "false");
    }
    _writeConfFile(expansion, lines);
  }

  static int _findLineInConfFile(Expansion expansion, String line,
      {int? start}) {
    List<String> lines = _getLinesInConfFile(expansion);
    if (lines.isEmpty) {
      return -1;
    }
    int index = lines.indexWhere((String e) => e.startsWith(line), start ?? 0);
    return index;
  }

  static List<String> _getLinesInConfFile(Expansion expansion) {
    File conf = File("${Game.getDirForExpansion(expansion)}/dgVoodoo.conf");
    if (!conf.existsSync()) {
      return List.empty();
    }
    return conf.readAsLinesSync();
  }

  static void _writeConfFile(Expansion expansion, List<String> lines) {
    File conf = File("${Game.getDirForExpansion(expansion)}/dgVoodoo.conf");
    conf.writeAsStringSync(lines.join("\n"));
  }
}

class IndirectSound {
  static Future<bool> _isInstalled(Expansion expansion) async {
    if (File("${Game.getDirForExpansion(expansion)}/dsound.dll").existsSync()) {
      return true;
    }
    return false;
  }

  static Future<bool> isInstalled() {
    return _isInstalled(Expansion.base);
  }

  static Future<void> install() async {
    for (Expansion expansion in Expansion.values) {
      if (await _isInstalled(expansion)) {
        continue;
      }
      await _install(Game.getDirForExpansion(expansion));
    }
  }

  static Future<void> uninstall() async {
    for (Expansion expansion in Expansion.values) {
      if (!(await _isInstalled(expansion))) {
        continue;
      }
      await _uninstall(Game.getDirForExpansion(expansion));
    }
  }

  static Future<void> _install(String path) async {
    ByteData dll1 =
        await rootBundle.load("assets/patches/IndirectSound/dsound.dll");
    ByteData conf =
        await rootBundle.load("assets/patches/IndirectSound/dsound.ini");

    File dll1FIle = File("$path/dsound.dll");
    File confFile = File("$path/dsound.ini");

    if (dll1FIle.existsSync()) {
      dll1FIle.deleteSync();
    }

    if (confFile.existsSync()) {
      confFile.deleteSync();
    }

    dll1FIle.createSync();
    confFile.createSync();

    dll1FIle.writeAsBytesSync(dll1.buffer.asUint8List());
    confFile.writeAsBytesSync(conf.buffer.asUint8List());
  }

  static Future<void> _uninstall(String path) async {
    File dll1File = File("$path/dsound.dll");
    File confFile = File("$path/dsound.ini");

    if (dll1File.existsSync()) {
      dll1File.deleteSync();
    }

    if (confFile.existsSync()) {
      confFile.deleteSync();
    }
  }
}
