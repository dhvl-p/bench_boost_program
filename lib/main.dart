import 'package:bench_boost_program/getx/GetxGraphQLHome.dart';
import 'package:bench_boost_program/websocket_chat/WebSocketChatHome.dart';
import 'package:bench_boost_program/getx/GetxHome.dart';
import 'package:bench_boost_program/isolates/isolates_simple_home.dart';
import 'package:bench_boost_program/provider/ProviderHome.dart';
import 'package:bench_boost_program/provider/provider/dataprovider.dart';
import 'package:bench_boost_program/riverpod/RiverpodHome.dart';
import 'package:bench_boost_program/splash_screen.dart';
import 'package:bench_boost_program/lifting_state_up/cart_demo_home.dart';
import 'package:bench_boost_program/mobx/MobxHome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DataProvider>(create: (_) => DataProvider())
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bench Booster',
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Provider', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),),
            trailing: const Icon(Icons.chevron_right),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProviderHone()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
           ListTile(
            title: Text('Riverpod',style: TextStyle(fontWeight:  FontWeight.w400, fontSize: 24),),
            trailing: Icon(Icons.chevron_right), // Right arrow icon
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RiverpodHone()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('GetX - Photos', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetxHome()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('MobX - Photos', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MobxHome()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('GetX - GraphQL (Photos)', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GetxGraphQLHome()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('Isolates Demo', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IsolatesSimpleHome()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('WebSocket Chat', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebSocketChatHome()),
              );
            },
          ),
          const Divider(
            height: 1,
            thickness: 2,
            color: Colors.grey,
            indent: 16,
            endIndent: 16,
          ),
          ListTile(
            title: const Text('Lifting State Up (Cart)', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartDemoHome()),
              );
            },
          ),


        ],
      ),
    );
  }
}
