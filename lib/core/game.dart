import 'dart:typed_data';

import 'package:fear_patcher/core/app_manifest.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:win32_registry/win32_registry.dart';
import 'dart:io';

enum Expansion { base, xp, xp2 }

enum TextScale { none, big, bigger }

class Game {
  static const keyPath =
      r'SOFTWARE\WOW6432Node\Monolith Productions\FEAR\1.00.0000';
  static String get dirPath => _getInstallPath();
  static String get gamePath => "$dirPath/FEAR.exe";
  static String get dirPathXP => "$dirPath/FEARXP";
  static String get gamePathXP => "$dirPathXP/FEARXP.exe";
  static String get dirPathXP2 => "$dirPath/FEARXP2";
  static String get gamePathXP2 => "$dirPathXP2/FEARXP2.exe";

  static String _getInstallPath() {
    final key = Registry.openPath(RegistryHive.localMachine, path: keyPath);
    final value = key.getValueAsString("installdir") ?? "";
    key.close();
    return value;
  }

  static bool isGameInstalled() {
    final key = Registry.openPath(RegistryHive.localMachine, path: keyPath);
    final value = key.getValueAsString("installdir");
    key.close();
    if (value == null) {
      return false;
    }

    return true;
  }

  static String getDirForExpansion(Expansion expansion) {
    switch (expansion) {
      case Expansion.base:
        return dirPath;
      case Expansion.xp:
        return dirPathXP;
      case Expansion.xp2:
        return dirPathXP2;
      default:
        return dirPath;
    }
  }

  static Future<bool> get ramPatch => _isRamPatched();
  static Future<bool> get directInputPatch => _isDirectInputPatched();

  static Future<bool> _isRamPatched() async {
    if (!File(gamePath).existsSync()) {
      return false;
    }
    Uint8List currentExe = File(gamePath).readAsBytesSync();
    Uint8List patchedExe =
        (await rootBundle.load("assets/patches/FEAR/FEAR.exe"))
            .buffer
            .asUint8List();
    bool test = true;
    for (int i = 0; i < currentExe.length; i++) {
      if (currentExe[i] != patchedExe[i]) {
        test = false;
        break;
      }
    }
    return test;
  }

  static Future<void> changeRamPatch(bool apply) async {
    ByteData data;
    ByteData dataXP;
    ByteData dataXP2;
    if (apply) {
      data = await rootBundle.load("assets/patches/FEAR/FEAR.exe");
      dataXP = await rootBundle.load("assets/patches/FEARXP/FEARXP.exe");
      dataXP2 = await rootBundle.load("assets/patches/FEARXP2/FEARXP2.exe");
    } else {
      data = await rootBundle.load("assets/original/FEAR/FEAR.exe");
      dataXP = await rootBundle.load("assets/original/FEARXP/FEARXP.exe");
      dataXP2 = await rootBundle.load("assets/original/FEARXP2/FEARXP2.exe");
    }
    try {
      File(gamePath).writeAsBytesSync(data.buffer.asUint8List());
      File(gamePathXP).writeAsBytesSync(dataXP.buffer.asUint8List());
      File(gamePathXP2).writeAsBytesSync(dataXP2.buffer.asUint8List());
    } catch (e) {
      return;
    }
  }

  static Future<bool> _isDirectInputPatched() async {
    if (!File("$dirPath/dinput8.dll").existsSync()) {
      return false;
    }
    Uint8List currentDll = File("$dirPath/dinput8.dll").readAsBytesSync();
    Uint8List patchedDll = (await rootBundle.load("assets/patches/dinput8.dll"))
        .buffer
        .asUint8List();
    for (int i = 0; i < currentDll.length; i++) {
      if (currentDll[i] != patchedDll[i]) {
        return false;
      }
    }
    return true;
  }

  static Future<void> changeDirectInputPatch(bool apply) async {
    if (apply) {
      if (!File("$dirPath/dinput8.dll").existsSync()) {
        await File("$dirPath/dinput8.dll").create();
      }
      File("$dirPath/dinput8.dll").writeAsBytesSync(
          (await rootBundle.load("assets/patches/dinput8.dll"))
              .buffer
              .asUint8List());
      if (!File("$dirPathXP/dinput8.dll").existsSync()) {
        await File("$dirPathXP/dinput8.dll").create();
      }
      File("$dirPathXP/dinput8.dll").writeAsBytesSync(
          (await rootBundle.load("assets/patches/dinput8.dll"))
              .buffer
              .asUint8List());
      if (!File("$dirPathXP2/dinput8.dll").existsSync()) {
        await File("$dirPathXP2/dinput8.dll").create();
      }
      File("$dirPathXP2/dinput8.dll").writeAsBytesSync(
          (await rootBundle.load("assets/patches/dinput8.dll"))
              .buffer
              .asUint8List());
    } else {
      await File("$dirPath/dinput8.dll").delete();
      if (File("$dirPathXP2/dinput8.dll").existsSync()) {
        await File("$dirPathXP2/dinput8.dll").delete();
      }
      if (File("$dirPathXP/dinput8.dll").existsSync()) {
        await File("$dirPathXP/dinput8.dll").delete();
      }
    }
    return;
  }

  static TextScale getTextScale() {
    if (_is1080TextFixed()) {
      return TextScale.big;
    } else if (_is1440TextFixed()) {
      return TextScale.bigger;
    }
    return TextScale.none;
  }

  static Future<void> _restoreDefaultTextScale() async {
    if (File("$dirPath/FEARL_1920.Arch00").existsSync()) {
      File("$dirPath/FEARL_1920.Arch00").deleteSync();
      File("$dirPathXP2/FEARL_XP2_1920.Arch00").deleteSync();
    }

    if (File("$dirPath/FEARL_1440.Arch00").existsSync()) {
      File("$dirPath/FEARL_1440.Arch00").deleteSync();
      File("$dirPathXP2/FEARL_XP2_1440.Arch00").deleteSync();
    }

    File("$dirPath/Default.archcfg").writeAsBytesSync(
        (await rootBundle.load("assets/original/FEAR/Default.archcfg"))
            .buffer
            .asInt8List());
    File("$dirPathXP2/Default.archcfg").writeAsBytesSync(
        (await rootBundle.load("assets/original/FEARXP2/Default.archcfg"))
            .buffer
            .asInt8List());
  }

  /// # static `Future<void>` changeTextScale(`TextScale textScale`)
  /// ## Changes the text scale of the games.
  static Future<void> changeTextScale(TextScale textScale) async {
    await _restoreDefaultTextScale();
    switch (textScale) {
      case TextScale.bigger:
        ByteData data1 = (await rootBundle
            .load("assets/patches/FEAR/1440/FEARL_1440.Arch00"));
        File("$dirPath/FEARL_1440.Arch00")
            .writeAsBytesSync(data1.buffer.asUint8List());
        ByteData data2 = (await rootBundle
            .load("assets/patches/FEARXP2/1440/FEARL_XP2_1440.Arch00"));
        File("$dirPathXP2/FEARL_XP2_1440.Arch00")
            .writeAsBytesSync(data2.buffer.asUint8List());

        ByteData cfgData =
            (await rootBundle.load("assets/patches/FEAR/1440/Default.archcfg"));
        File("$dirPath/Default.archcfg")
            .writeAsBytesSync(cfgData.buffer.asInt8List());

        cfgData = (await rootBundle
            .load("assets/patches/FEARXP2/1440/Default.archcfg"));
        File("$dirPathXP2/Default.archcfg")
            .writeAsBytesSync(cfgData.buffer.asInt8List());
        break;
      case TextScale.big:
        ByteData data1 = (await rootBundle
            .load("assets/patches/FEAR/1080/FEARL_1920.Arch00"));
        File("$dirPath/FEARL_1920.Arch00")
            .writeAsBytesSync(data1.buffer.asUint8List());
        ByteData data2 = (await rootBundle
            .load("assets/patches/FEARXP2/1080/FEARL_XP2_1920.Arch00"));
        File("$dirPathXP2/FEARL_XP2_1920.Arch00")
            .writeAsBytesSync(data2.buffer.asUint8List());

        ByteData cfgData =
            (await rootBundle.load("assets/patches/FEAR/1080/Default.archcfg"));
        File("$dirPath/Default.archcfg")
            .writeAsBytesSync(cfgData.buffer.asInt8List());

        cfgData = (await rootBundle
            .load("assets/patches/FEARXP2/1080/Default.archcfg"));
        File("$dirPathXP2/Default.archcfg")
            .writeAsBytesSync(cfgData.buffer.asInt8List());
      case TextScale.none:
        break;
    }
  }

  static bool _is1080TextFixed() {
    if (!File("$dirPath/FEARL_1920.Arch00").existsSync()) {
      return false;
    }
    return true;
  }

  static bool _is1440TextFixed() {
    if (!File("$dirPath/FEARL_1440.Arch00").existsSync()) {
      return false;
    }
    return true;
  }

  static Future<void> launch(Expansion expansion) async {
    switch (expansion) {
      case Expansion.base:
        await Process.run(
            "powershell.exe", ["start", "steam://rungameid/21090"]);
        break;
      case Expansion.xp:
        await Process.run(
            "powershell.exe", ["start", "steam://rungameid/21110"]);
        break;
      case Expansion.xp2:
        await Process.run(
            "powershell.exe", ["start", "steam://rungameid/21120"]);
        break;
    }
  }

  static AppManifest getManifest(Expansion expansion) {
    switch (expansion) {
      case Expansion.base:
        return AppManifest(gamePath);
      case Expansion.xp:
        return AppManifest(gamePathXP);
      case Expansion.xp2:
        return AppManifest(gamePathXP2);
    }
  }
}
