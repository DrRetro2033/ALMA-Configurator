import 'dart:io';

import "package:fear_patcher/core/game.dart";
import 'package:flutter/services.dart';

// ignore: camel_case_types
class dgVoodoo2 {
  static bool _isInstalled(Expansion expansion) {
    if (File("${Game.getDirForExpansion(expansion)}/dgVoodooCpl.exe")
        .existsSync()) {
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

  static void open(Expansion expansion) {
    if (_isInstalled(expansion)) {
      Process.run("${Game.getDirForExpansion(expansion)}/dgVoodooCpl.exe", []);
    }
  }

  static Future<void> _install(String path) async {
    ByteData app =
        await rootBundle.load("assets/patches/dgVoodoo2/dgVoodooCpl.exe");
    ByteData dll =
        await rootBundle.load("assets/patches/dgVoodoo2/MS/x86/D3D9.dll");

    File appFile = File("$path/dgVoodooCpl.exe");
    File dllFile = File("$path/D3D9.dll");

    if (appFile.existsSync()) {
      appFile.deleteSync();
    }
    appFile.createSync();

    if (dllFile.existsSync()) {
      dllFile.deleteSync();
    }
    dllFile.createSync();

    appFile.writeAsBytesSync(app.buffer.asUint8List());
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
    File appFile = File("$path/dgVoodooCpl.exe");
    File dllFile = File("$path/D3D9.dll");

    if (appFile.existsSync()) {
      appFile.deleteSync();
    }
    if (dllFile.existsSync()) {
      dllFile.deleteSync();
    }
  }
}
