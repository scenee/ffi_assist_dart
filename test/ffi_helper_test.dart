import "dart:math";
import "dart:typed_data";

import "package:ffi_helper/ffi_helper.dart";
import "package:test/test.dart";

void main() {
  group("bytes", () {
    setUp(() {
      // Additional setup goes here.
    });

    // Test for hext2bytes
    test("hex2bytes", () {
      var hexString = "000123456789abcdef";
      var data = hex2bytes(hexString);
      expect(
          data,
          Uint8List.fromList([
            0x00,
            0x01,
            0x23,
            0x45,
            0x67,
            0x89,
            0xab,
            0xcd,
            0xef,
          ]));
    });
    // Test hex2bytes with odd length
    test("hex2bytes odd length", () {
      var hexString = "000123456789abcde";
      expect(() => hex2bytes(hexString), throwsFormatException);
    });

    // Test hex2bytes with null
    test("hex2bytes null", () {
      var data = hex2bytes(null);
      expect(data, Uint8List(0));
    });

    // Test for littleEndianBytes
    test("littleEndianBytes", () {
      var value = 0x0123456789abcdef;
      var data = littleEndianBytes(value, len: 8);
      expect(
          data,
          Uint8List.fromList([
            0xef,
            0xcd,
            0xab,
            0x89,
            0x67,
            0x45,
            0x23,
            0x01,
          ]));
    });

    // Test for bigEndianBytes
    test("bigEndianBytes", () {
      var value = 0x0123456789abcdef;
      var data = bigEndianBytes(value, len: 8);
      expect(
          data,
          Uint8List.fromList([
            0x01,
            0x23,
            0x45,
            0x67,
            0x89,
            0xab,
            0xcd,
            0xef,
          ]));
    });
  });

  group("equality", () {
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

    test("equals", () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final dataCopy = Uint8List.fromList([1, 2, 3, 4, 5]);
      expect(data.equals(dataCopy), isTrue);
    });
    test("equals empty", () {
      expect(Uint8List(0).equals(Uint8List(0)), isTrue);
    });

    test("equals different", () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final dataCopy = Uint8List.fromList([1, 2, 3, 4, 6]);
      expect(data.equals(dataCopy), isFalse);
    });

    test("equals different length", () {
      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final dataCopy = Uint8List.fromList([1, 2, 3, 4, 5, 6]);
      expect(data.equals(dataCopy), isFalse);
    });
  });

  group("hex_string", () {
    // Test the toBlockedHexString extension method.
    test("toBlockedHexString", () {
      var data = Uint8List.fromList([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(data.toBlockedHexString(4), "00010203\n04050607\n0809\n");
    });

    test("toBlockedHexString", () {
      var data = Uint8List.fromList([0, 1, 2, 3]);
      expect(data.toBlockedHexString(4), "00010203\n");
    });

    // Test the toBlockedHexString extension method for long text
    test("toBlockedHexString long", () {
      var data = Uint8List.fromList([
        for (var i = 0; i < 256; i += 1) i % 256,
      ]);
      expect(
          data.toBlockedHexString(16),
          "000102030405060708090a0b0c0d0e0f\n"
          "101112131415161718191a1b1c1d1e1f\n"
          "202122232425262728292a2b2c2d2e2f\n"
          "303132333435363738393a3b3c3d3e3f\n"
          "404142434445464748494a4b4c4d4e4f\n"
          "505152535455565758595a5b5c5d5e5f\n"
          "606162636465666768696a6b6c6d6e6f\n"
          "707172737475767778797a7b7c7d7e7f\n"
          "808182838485868788898a8b8c8d8e8f\n"
          "909192939495969798999a9b9c9d9e9f\n"
          "a0a1a2a3a4a5a6a7a8a9aaabacadaeaf\n"
          "b0b1b2b3b4b5b6b7b8b9babbbcbdbebf\n"
          "c0c1c2c3c4c5c6c7c8c9cacbcccdcecf\n"
          "d0d1d2d3d4d5d6d7d8d9dadbdcdddedf\n"
          "e0e1e2e3e4e5e6e7e8e9eaebecedeeef\n"
          "f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff\n");
    });

    test("toHexString", () {
      var data = Uint8List.fromList([
        for (var i = 0; i < 256; i += 1) i % 256,
      ]);
      expect(
          data.toHexString(),
          "000102030405060708090a0b0c0d0e0f"
          "101112131415161718191a1b1c1d1e1f"
          "202122232425262728292a2b2c2d2e2f"
          "303132333435363738393a3b3c3d3e3f"
          "404142434445464748494a4b4c4d4e4f"
          "505152535455565758595a5b5c5d5e5f"
          "606162636465666768696a6b6c6d6e6f"
          "707172737475767778797a7b7c7d7e7f"
          "808182838485868788898a8b8c8d8e8f"
          "909192939495969798999a9b9c9d9e9f"
          "a0a1a2a3a4a5a6a7a8a9aaabacadaeaf"
          "b0b1b2b3b4b5b6b7b8b9babbbcbdbebf"
          "c0c1c2c3c4c5c6c7c8c9cacbcccdcecf"
          "d0d1d2d3d4d5d6d7d8d9dadbdcdddedf"
          "e0e1e2e3e4e5e6e7e8e9eaebecedeeef"
          "f0f1f2f3f4f5f6f7f8f9fafbfcfdfeff");
    });
  });

  // Test toHexString with upper case
  test("toHexString upper case", () {
    var data = Uint8List.fromList([
      for (var i = 0; i < 256; i += 1) i % 256,
    ]);
    expect(
        data.toHexString(upperCase: true),
        "000102030405060708090A0B0C0D0E0F"
        "101112131415161718191A1B1C1D1E1F"
        "202122232425262728292A2B2C2D2E2F"
        "303132333435363738393A3B3C3D3E3F"
        "404142434445464748494A4B4C4D4E4F"
        "505152535455565758595A5B5C5D5E5F"
        "606162636465666768696A6B6C6D6E6F"
        "707172737475767778797A7B7C7D7E7F"
        "808182838485868788898A8B8C8D8E8F"
        "909192939495969798999A9B9C9D9E9F"
        "A0A1A2A3A4A5A6A7A8A9AAABACADAEAF"
        "B0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF"
        "C0C1C2C3C4C5C6C7C8C9CACBCCCDCECF"
        "D0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF"
        "E0E1E2E3E4E5E6E7E8E9EAEBECEDEEEF"
        "F0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF");
  });
}
