import "dart:ffi" as ffi;
import "dart:typed_data";

import "package:ffi/ffi.dart";

extension Convert_Pointer_UnsignedChar on ffi.Pointer<ffi.UnsignedChar> {
  Uint8List toUint8List(int len) {
    final ret = Uint8List(len);
    for (var i = 0; i < len; i++) {
      ret[i] = this[i];
    }
    return ret;
  }
}

extension Convert_String on String {
  ffi.Pointer<T> toPointer<T extends ffi.NativeType>(
      {ffi.Allocator allocator = calloc}) {
    final p = allocator<ffi.UnsignedChar>(length);
    for (var i = 0; i < codeUnits.length; i++) {
      p[i] = codeUnits[i];
    }
    return p.cast<T>();
  }
}

extension Convert_Uint8List on Uint8List {
  ffi.Pointer<ffi.UnsignedChar> toPointer({ffi.Allocator allocator = calloc}) {
    final p = allocator<ffi.UnsignedChar>(length);
    for (var i = 0; i < length; i++) {
      p[i] = this[i];
    }
    return p;
  }
}
