// Added precomputed hex lookup tables for performance.

import "dart:ffi" as ffi;
import "dart:typed_data";

final List<String> _hexTableLower =
    List<String>.generate(256, (i) => i.toRadixString(16).padLeft(2, "0"));
final List<String> _hexTableUpper = List<String>.generate(
    256, (i) => i.toRadixString(16).padLeft(2, "0").toUpperCase());

extension HexString_Uint8List on Uint8List {
  String toHexString({String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(table[this[i]]);
      if (i < length - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }

  String toBlockedHexString(int lineByteLen,
      {String separator = "", bool upperCase = false}) {
    // Optimized implementation using precomputed hex lookup tables.
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(table[this[i]]);
      if ((i + 1) % lineByteLen == 0) {
        if (i != length - 1) {
          buffer.write("\n");
        }
      } else if (i < length - 1) {
        buffer.write(separator);
      }
    }
    buffer.write("\n");
    return buffer.toString();
  }
}

extension HexString_List on List<int> {
  String toHexString({String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      buffer.write(table[this[i]]);
      if (i < length - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }
}

extension HexString_Int on int {
  String toHexString({String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    // Assuming the int is in the range 0-255
    return table[this];
  }
}

extension HexString_UnsignedChar on ffi.Pointer<ffi.UnsignedChar> {
  // Modified toHexString to use pointer arithmetic directly with precomputed hex lookup tables for faster conversion.
  String toHexString(int len, {String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < len; i++) {
      buffer.write(table[this[i]]);
      if (i < len - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }

  // Updated toBlockedHexString to use pointer arithmetic directly with precomputed hex lookup tables for faster conversion.
  String toBlockedHexString(int byteLen, int lineByteLen,
      {String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < byteLen; i++) {
      buffer.write(table[this[i]]);
      if ((i + 1) % lineByteLen == 0) {
        if (i < byteLen - 1) {
          buffer.write("\n");
        }
      } else if (i < byteLen - 1) {
        buffer.write(separator);
      }
    }
    buffer.write("\n");
    return buffer.toString();
  }
}

extension HexString_Uint8 on ffi.Pointer<ffi.Uint8> {
  String toHexString(int len, {String separator = "", bool upperCase = false}) {
    final table = upperCase ? _hexTableUpper : _hexTableLower;
    final buffer = StringBuffer();
    for (int i = 0; i < len; i++) {
      buffer.write(table[this[i]]);
      if (i < len - 1) {
        buffer.write(separator);
      }
    }
    return buffer.toString();
  }
}
