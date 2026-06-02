import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IsolatesSimpleHome extends StatefulWidget {
  const IsolatesSimpleHome({super.key});

  @override
  State<IsolatesSimpleHome> createState() => _IsolatesSimpleHomeState();
}

class _IsolatesSimpleHomeState extends State<IsolatesSimpleHome> {
  bool _isLoading = false;
  String _executionTime = "-";
  String _result = "-";
  String _runMethod = "-";

  // Heavy CPU-bound computation: Counting primes up to [max]
  static int _countPrimes(int max) {
    int count = 0;
    for (int i = 2; i <= max; i++) {
      bool isPrime = true;
      for (int j = 2; j * j <= i; j++) {
        if (i % j == 0) {
          isPrime = false;
          break;
        }
      }
      if (isPrime) count++;
    }
    return count;
  }

  // Runs computation directly on the main thread (will freeze the UI loader)
  void _runOnMainThread() {
    setState(() {
      _isLoading = true;
      _runMethod = 'isolates_run_method_main'.tr;
      _executionTime = 'isolates_calculating'.tr;
      _result = 'isolates_dash'.tr;
    });

    // Short delay to let the loading state render first
    Future.delayed(const Duration(milliseconds: 100), () {
      final stopwatch = Stopwatch()..start();
      final count = _countPrimes(8000000); // 8 million
      stopwatch.stop();

      setState(() {
        _isLoading = false;
        _executionTime = '${stopwatch.elapsedMilliseconds} ms';
        _result = 'isolates_primes_found'.trParams({'count': '$count'});
      });
    });
  }

  // Static entry point function for Isolate.spawn.
  // Receives the SendPort from the main thread, calculates primes, and sends the result back.
  static void _isolateEntryPoint(SendPort mainSendPort) {
    final count = _countPrimes(8000000); // 8 million
    mainSendPort.send(count);
  }

  // Runs computation in a background isolate using Isolate.spawn (UI loader spins smoothly)
  void _runOnIsolate() async {
    setState(() {
      _isLoading = true;
      _runMethod = 'isolates_run_method_isolate'.tr;
      _executionTime = 'isolates_calculating'.tr;
      _result = 'isolates_dash'.tr;
    });

    final stopwatch = Stopwatch()..start();

    // 1. Create a ReceivePort to receive messages from the spawned isolate
    final receivePort = ReceivePort();

    // 2. Spawn the isolate, passing it the SendPort of our ReceivePort
    final isolate = await Isolate.spawn(_isolateEntryPoint, receivePort.sendPort);

    // 3. Listen to the ReceivePort for the result
    receivePort.listen((message) {
      stopwatch.stop();
      if (mounted) {
        setState(() {
          _isLoading = false;
          _executionTime = '${stopwatch.elapsedMilliseconds} ms';
          _result = 'isolates_primes_found'.trParams({'count': '$message'});
        });
      }

      // 4. Clean up resources by closing the port and killing the isolate
      receivePort.close();
      isolate.kill(priority: Isolate.immediate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('isolates_app_bar_title'.tr),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instructions / Explanation card
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'isolates_demo_title'.tr,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'isolates_description'.tr,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'isolates_main_thread_warning'.tr,
                      style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'isolates_spawn_info'.tr,
                      style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Continuous loading visualizer
            Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 12),
                  Text(
                    _isLoading ? 'isolates_computing'.tr : 'isolates_idle'.tr,
                    style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Buttons
            ElevatedButton(
              onPressed: _isLoading ? null : _runOnMainThread,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[50],
                foregroundColor: Colors.red[700],
                side: BorderSide(color: Colors.red[200]!),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('isolates_run_main_thread'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isLoading ? null : _runOnIsolate,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[50],
                foregroundColor: Colors.green[700],
                side: BorderSide(color: Colors.green[200]!),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text('isolates_run_isolate'.tr, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),

            // Results Section
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'isolates_method_label'.trParams({'method': _runMethod}),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('isolates_time_label'.trParams({'time': _executionTime})),
            const SizedBox(height: 8),
            Text('isolates_result_label'.trParams({'result': _result})),
          ],
        ),
      ),
    );
  }
}
