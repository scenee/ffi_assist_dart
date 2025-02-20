import "dart:math";
import "dart:typed_data";

import "package:ffi_helper/ffi_helper.dart";
import "package:test/test.dart";

void main() {
  group("ffi_helper", () {
    setUp(() {
      // Additional setup goes here.
    });

    test("memEquals", () {
      var random = Random();

      // Generate random data.
      //
      // 100 MB minus a few bytes to avoid being an exact multiple of 8 bytes.
      const numBytes = 100 * 1000 * 1000 - 3;
      var data = Uint8List.fromList([
        for (var i = 0; i < numBytes; i += 1) random.nextInt(256),
      ]);

      var dataCopy = Uint8List.fromList(data);
      memEquals(data, dataCopy);
    });
  });
}
