import "dart:typed_data";

Uint8List hex2bytes(String? hexString) {
  if (hexString == null) {
    return Uint8List(0);
  }
  hexString = hexString.replaceAll(RegExp(r"\s+"), "");
  hexString = hexString.replaceAll(RegExp(r"\n"), "");
  final len = hexString.length ~/ 2;
  final ret = Uint8List(len);
  for (var i = 0; i < len; i++) {
    ret[i] = int.parse(hexString.substring(i * 2, i * 2 + 2), radix: 16);
  }
  return ret;
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
