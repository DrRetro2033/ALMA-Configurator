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

  Map<String, bool> getParameters() {
    Map<String, bool> manifest = {};
    manifest["runAsAdmin"] = false;
    if (!File(manifestPath).existsSync()) {
      File(manifestPath).createSync();
      _save({"runAsAdmin": false});
    } else {
      String manifestString = File(manifestPath).readAsStringSync();
      if (manifestString.contains(runAsAdminChunk)) {
        manifest["runAsAdmin"] = true;
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
    file.writeAsStringSync("\n</assembly>", mode: FileMode.append);
  }
}
