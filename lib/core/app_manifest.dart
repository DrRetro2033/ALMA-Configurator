import 'dart:io';

class AppManifest {
  String excutablePath;
  String get manifestPath => "$excutablePath.manifest";
  bool get runAsAdmin => getParameters()["runAsAdmin"] ?? false;
  set runAsAdmin(bool value) {
    Map<String, bool> manifest = getParameters();
    manifest["runAsAdmin"] = value;
    _save(manifest);
  }

  bool get disableFullScreenOptimization =>
      getParameters()["disableFullScreenOptimization"] ?? false;
  set disableFullScreenOptimization(bool value) {
    Map<String, bool> manifest = getParameters();
    manifest["disableFullScreenOptimization"] = value;
    _save(manifest);
  }

  AppManifest(this.excutablePath);

  static const String runAsAdminChunk = """
    <!-- Request privileges to run as administrator -->
    <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
      <security>
        <requestedPrivileges>
          <requestedExecutionLevel level="requireAdministrator" uiAccess="false"/>
        </requestedPrivileges>
      </security>
    </trustInfo>
""";

  static const String disableFullScreenOptimizationChunk = """
    <compatibility xmlns="urn:schemas-microsoft-com:compatibility.v1">
      <application>
        <!-- Disable Full-Screen Optimizations -->
        <windowsSettings>
          <disableFullScreenOptimizations>true</disableFullScreenOptimizations>
        </windowsSettings>
      </application>
    </compatibility>
""";

  Map<String, bool> getParameters() {
    Map<String, bool> manifest = {};
    manifest["runAsAdmin"] = false;
    manifest["disableFullScreenOptimization"] = false;
    if (!File(manifestPath).existsSync()) {
      File(manifestPath).createSync();
      _save({"runAsAdmin": false});
    } else {
      // Read manifest file and check if it contains any of the chunks below.
      String manifestString = File(manifestPath).readAsStringSync();
      if (manifestString.contains(runAsAdminChunk)) {
        manifest["runAsAdmin"] = true;
      }
      if (manifestString.contains(disableFullScreenOptimizationChunk)) {
        manifest["disableFullScreenOptimization"] = true;
      }
    }
    return manifest;
  }

  void _save(Map<String, bool> manifest) {
    File file = File(manifestPath);
    file.writeAsStringSync("");
    file.writeAsStringSync(
        """<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<assembly xmlns="urn:schemas-microsoft-com:asm.v1" manifestVersion="1.0">\n""",
        mode: FileMode.append);
    if (manifest["runAsAdmin"]!) {
      file.writeAsStringSync(runAsAdminChunk, mode: FileMode.append);
    }
    if (manifest["disableFullScreenOptimization"]!) {
      file.writeAsStringSync(disableFullScreenOptimizationChunk,
          mode: FileMode.append);
    }
    file.writeAsStringSync("\n</assembly>", mode: FileMode.append);
  }
}
