// Import BenchmarkBase class.
import "dart:typed_data";

import "package:benchmark_harness/benchmark_harness.dart";
import "package:ffi_assist/ffi_assist.dart";

// Create a new benchmark by extending BenchmarkBase
class ToBlockedHexStringBenchmark extends BenchmarkBase {
  ToBlockedHexStringBenchmark() : super("Template");

  Uint8List data = Uint8List.fromList([
    for (var i = 0; i < 1000; i += 1) i % 256,
  ]);

  static void main() {
    ToBlockedHexStringBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
    data.toBlockedHexString(16);
  }

  // Not measured setup code executed prior to the benchmark runs.
  @override
  void setup() {}

  // Not measured teardown code executed after the benchmark runs.
  @override
  void teardown() {}

  // To opt into the reporting the time per run() instead of per 10 run() calls.
  @override
  void exercise() => run();
}

class ToHexStringBenchmark extends BenchmarkBase {
  ToHexStringBenchmark() : super("Template");

  Uint8List data = Uint8List.fromList([
    for (var i = 0; i < 1000; i += 1) i % 256,
  ]);

  static void main() {
    ToHexStringBenchmark().report();
  }

  // The benchmark code.
  @override
  void run() {
    data.toHexString();
  }

  @override
  void exercise() => run();
}

void main() {
  ToBlockedHexStringBenchmark.main();
  ToHexStringBenchmark.main();
}
