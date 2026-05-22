import 'dart:isolate';
import 'package:flutter/material.dart';

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
      _runMethod = "Main Thread";
      _executionTime = "Calculating...";
      _result = "-";
    });

    // Short delay to let the loading state render first
    Future.delayed(const Duration(milliseconds: 100), () {
      final stopwatch = Stopwatch()..start();
      final count = _countPrimes(8000000); // 8 million
      stopwatch.stop();

      setState(() {
        _isLoading = false;
        _executionTime = "${stopwatch.elapsedMilliseconds} ms";
        _result = "$count primes found";
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
      _runMethod = "Isolate.spawn";
      _executionTime = "Calculating...";
      _result = "-";
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
          _executionTime = "${stopwatch.elapsedMilliseconds} ms";
          _result = "$message primes found";
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
        title: const Text('Isolates'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
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
                    const Text(
                      'Isolates Demonstration',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This task calculates prime numbers up to 8,000,000. '
                      'Observe the loading spinner below:',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '• Main Thread: The spinner freezes completely.',
                      style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '• Isolate.spawn: The spinner keeps spinning smoothly.',
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
                    _isLoading ? 'Computing...' : 'UI Thread Active / Idle',
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
              child: const Text('Run on Main Thread (Blocks UI)', style: TextStyle(fontWeight: FontWeight.bold)),
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
              child: const Text('Run on Isolate (Smooth)', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 30),

            // Results Section
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'Method: $_runMethod',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Execution Time: $_executionTime'),
            const SizedBox(height: 8),
            Text('Result: $_result'),
          ],
        ),
      ),
    );
  }
}
