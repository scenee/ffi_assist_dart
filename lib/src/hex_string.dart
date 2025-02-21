import "dart:ffi" as ffi;
import "dart:typed_data";

extension HexString_Uint8List on Uint8List {
  String toHexString({String separator = "", bool upperCase = false}) {
    return map((e) {
      final hex = e.toRadixString(16).padLeft(2, "0");
      return (upperCase) ? hex.toUpperCase() : hex;
    }).join(separator);
  }

  String toBlockedHexString(int lineByteLen,
      {String separator = "", bool upperCase = false}) {
    final hexBytes = map((e) {
      final hex = e.toRadixString(16).padLeft(2, "0");
      return (upperCase) ? hex.toUpperCase() : hex;
    });
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
  String toHexString({String separator = "", bool upperCase = false}) {
    return map((e) {
      final hex = e.toRadixString(16).padLeft(2, "0");
      return (upperCase) ? hex.toUpperCase() : hex;
    }).join(separator);
  }
}

extension HexString_Int on int {
  String toHexString({String separator = "", bool upperCase = false}) {
    final hex = toRadixString(16).padLeft(2, "0");
    return (upperCase) ? hex.toUpperCase() : hex;
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
  String toHexString(int len, {String separator = "", bool upperCase = false}) {
    return asTypedList(len)
        .toHexString(separator: separator, upperCase: upperCase);
  }
}
