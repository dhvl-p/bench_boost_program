import 'package:bench_boost_program/getx/GetxGraphQLHome.dart';
import 'package:bench_boost_program/responsive_portfolio/portfolio_page.dart';
import 'package:bench_boost_program/websocket_chat/WebSocketChatHome.dart';
import 'package:bench_boost_program/getx/GetxHome.dart';
import 'package:bench_boost_program/isolates/isolates_simple_home.dart';
import 'package:bench_boost_program/localization/app_locales.dart';
import 'package:bench_boost_program/localization/app_translations.dart';
import 'package:bench_boost_program/provider/ProviderHome.dart';
import 'package:bench_boost_program/provider/provider/dataprovider.dart';
import 'package:bench_boost_program/riverpod/RiverpodHome.dart';
import 'package:bench_boost_program/splash_screen.dart';
import 'package:bench_boost_program/lifting_state_up/cart_demo_home.dart';
import 'package:bench_boost_program/mobx/MobxHome.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bench Booster',
      debugShowCheckedModeBanner: false,
      // GetX Localization
      translations: AppTranslations(),
      locale: AppLocales.english,
      fallbackLocale: AppLocales.english,
      supportedLocales: AppLocales.supportedLocales,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SplashScreen(),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Locale controller — holds the single observable that drives the toggle button
// ─────────────────────────────────────────────────────────────────────────────
class LocaleController extends GetxController {
  final isHindi = false.obs;

  void toggleLocale() {
    isHindi.value = !isHindi.value;
    Get.updateLocale(isHindi.value ? AppLocales.hindi : AppLocales.english);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Home page
// ─────────────────────────────────────────────────────────────────────────────
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final localeCtrl = Get.put(LocaleController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        title: Text('app_title'.tr),
        actions: [
          // Obx wraps ONLY the toggle button — the only widget that needs
          // reactive rebuild from the isHindi observable.
          Obx(() => TextButton(
                onPressed: localeCtrl.toggleLocale,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white.withValues(alpha: 0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.white38),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.translate, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      localeCtrl.isHindi.value ? 'EN' : 'हिंदी',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('nav_provider'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const ProviderHone()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_riverpod'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const RiverpodHone()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_getx_photos'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const GetxHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_mobx_photos'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const MobxHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_getx_graphql'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const GetxGraphQLHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_isolates'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const IsolatesSimpleHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_websocket'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const WebSocketChatHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: Text('nav_lifting_state'.tr, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const CartDemoHome()),
          ),
          const Divider(height: 1, thickness: 2, color: Colors.grey, indent: 16, endIndent: 16),
          ListTile(
            title: const Text('Responsive Portfolio (LayoutBuilder)', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Get.to(() => const PortfolioPage()),
          ),
        ],
      ),
    );
  }
}
