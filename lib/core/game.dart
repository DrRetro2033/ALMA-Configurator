import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

enum Expansion { base, xp, xp2 }

class Game {
  static const String steamPath =
      "C:/Program Files (x86)/Steam/steamapps/common/FEAR Ultimate Shooter Edition";

  static String get gamePath => "$steamPath/FEAR.exe";
  static String get gamePathXP => "$steamPath/FEARXP/FEARXP.exe";
  static String get gamePathXP2 => "$steamPath/FEARXP2/FEARXP2.exe";

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
    if (!File("$steamPath/dinput8.dll").existsSync()) {
      return false;
    }
    Uint8List currentDll = File("$steamPath/dinput8.dll").readAsBytesSync();
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
      File("$steamPath/dinput8.dll").writeAsBytesSync(
          (await rootBundle.load("assets/patches/dinput8.dll"))
              .buffer
              .asUint8List());
    } else {
      await File("$steamPath/dinput8.dll").delete();
    }
    return;
  }

  static Future<void> launch(Expansion expansion) async {
    switch (expansion) {
      case Expansion.base:
        await Process.start(gamePath, []);
        break;
      case Expansion.xp:
        await Process.start(gamePathXP, []);
        break;
      case Expansion.xp2:
        await Process.start(gamePathXP2, []);
        break;
    }
  }
}
