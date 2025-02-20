import "dart:ffi" as ffi;
import "dart:typed_data";

extension HexString_Uint8List on Uint8List {
  String toHexString([String separator = ""]) {
    return map((e) => e.toRadixString(16).padLeft(2, "0")).join(separator);
  }

  String toBlockedHexString(int lineByteLen, {String separator = ""}) {
    final hexBytes = map((e) => e.toRadixString(16).padLeft(2, "0"));
    var ret = "";
    for (int i = 0; i < hexBytes.length; i += 1) {
      ret += hexBytes.elementAt(i);
      if ((i + 1) % lineByteLen == 0) {
        ret += "\n";
      } else {
        ret += separator;
      }
    }
    return ret;
  }
}

extension HexString_List on List {
  String toHexString([String separator = ""]) {
    return map((e) => e.toRadixString(16).padLeft(2, "0")).join(separator);
  }
}

extension HexString_Int on int {
  String toHexString([String separator = ""]) {
    return toRadixString(16).padLeft(2, "0");
  }
}

extension HexString_UnsignedChar on ffi.Pointer<ffi.UnsignedChar> {
  String toHexString(int len) {
    return (this as ffi.Pointer<ffi.Uint8>).asTypedList(len).toHexString();
  }

  String toBlockedHexString(
    int byteLen,
    int lineByteLen, {
    String separator = "",
  }) {
    return (this as ffi.Pointer<ffi.Uint8>)
        .asTypedList(byteLen)
        .toBlockedHexString(lineByteLen, separator: separator);
  }
}

extension HexString_Uint8 on ffi.Pointer<ffi.Uint8> {
  String toHexString(int len) {
    return asTypedList(len).toHexString();
  }
}
