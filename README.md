# ffi_assist

## Overview

ffi_assist is a helper library for interfacing with native libraries using Dart's FFI.

## Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  ffi_assist: ^1.0.0
```

## Usage

```dart
import 'package:ffi_assist/ffi_assist.dart';

void main() {
  // Example: Convert hex string to bytes.
  final hexStr = "0123456789abcdef";
  final bytes = hex2bytes(hexStr);
  print("hex2bytes: $bytes");

  // Example: Display bytes as blocked hex string (4 bytes per block).
  final blocked = bytes.toBlockedHexString(4);
  print("toBlockedHexString:\n$blocked");

  // Example: Little endian conversion of an integer.
  final leBytes = littleEndianBytes(0x0123456789abcdef, len: 8);
  print("littleEndianBytes: $leBytes");

  // Example: Big endian conversion of an integer.
  final beBytes = bigEndianBytes(0x0123456789abcdef, len: 8);
  print("bigEndianBytes: $beBytes");
}
```

## Contributing

Contributions are welcome! Please submit a pull request or open an issue.
