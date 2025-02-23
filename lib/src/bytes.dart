import "dart:typed_data";

Uint8List hex2bytes(String? hexString) {
  if (hexString == null) {
    return Uint8List(0);
  }
  // Remove all whitespace at once
  hexString = hexString.replaceAll(RegExp(r"\s+"), "");
  // Ensure even length
  if (hexString.length % 2 != 0) {
    throw FormatException("Invalid hex string: odd length");
  }
  final len = hexString.length ~/ 2;
  final ret = Uint8List(len);
  for (var i = 0; i < len; i++) {
    int high = _hexCharToByte(hexString.codeUnitAt(i * 2));
    int low = _hexCharToByte(hexString.codeUnitAt(i * 2 + 1));
    ret[i] = (high << 4) | low;
  }
  return ret;
}

int _hexCharToByte(int charCode) {
  // '0'-'9'
  if (charCode >= 48 && charCode <= 57) return charCode - 48;
  // 'a'-'f'
  if (charCode >= 97 && charCode <= 102) return charCode - 97 + 10;
  // 'A'-'F'
  if (charCode >= 65 && charCode <= 70) return charCode - 65 + 10;
  throw FormatException(
      "Invalid hex character: ${String.fromCharCode(charCode)}");
}

Uint8List littleEndianBytes(int value, {int len = 8}) {
  if (len <= 0) {
    return Uint8List(0);
  }

  final bytes = Uint8List(len);
  for (var i = 0; i < len; i++) {
    bytes[i] = (value >> (i * 8)) & 0xff;
  }
  return bytes;
}

Uint8List bigEndianBytes(int value, {int len = 8}) {
  if (len <= 0) {
    return Uint8List(0);
  }

  final bytes = Uint8List(len);
  final last = len - 1;
  for (var i = 0; i < len; i++) {
    bytes[last - i] = (value >> (i * 8)) & 0xff;
  }
  return bytes;
}
