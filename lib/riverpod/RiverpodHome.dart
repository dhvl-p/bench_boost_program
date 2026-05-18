import 'package:flutter/material.dart';

class RiverpodHone extends StatefulWidget {
  const RiverpodHone({super.key});

  @override
  State<RiverpodHone> createState() => _RiverpodHoneState();
}

class _RiverpodHoneState extends State<RiverpodHone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod'), leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(), // Manual back action
      ),),
      body: const Center(
        child: Text('Riverpod'),
      ),
    );
  }
}
