import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': _en,
        'hi_IN': _hi,
      };
}

// ─────────────────────────────────────────────────────────────────────────────
// English strings
// ─────────────────────────────────────────────────────────────────────────────
const Map<String, String> _en = {
  // App / Splash
  'app_title': 'Bench Booster',
  'splash_tagline': 'Boost Your Performance',

  // Main menu navigation
  'nav_provider': 'Provider',
  'nav_riverpod': 'Riverpod',
  'nav_getx_photos': 'GetX - Photos',
  'nav_mobx_photos': 'MobX - Photos',
  'nav_getx_graphql': 'GetX - GraphQL (Photos)',
  'nav_isolates': 'Isolates Demo',
  'nav_websocket': 'WebSocket Chat',
  'nav_lifting_state': 'Lifting State Up (Cart)',

  // Language toggle
  'lang_toggle_to_hindi': 'हिंदी',
  'lang_toggle_to_english': 'EN',

  // Common
  'retry': 'Retry',
  'ok': 'OK',
  'loading': 'Loading...',
  'error_something_wrong': 'Oops! Something went wrong',
  'no_photos_found': 'No photos found',
  'loading_photos': 'Loading Photos...',
  'loading_graphql_photos': 'Loading GraphQL Photos...',

  // GetX Photos screen
  'getx_app_bar_title': 'GetX Photos',
  'photos_count': '@count Photos',
  'graphql_photos_count': '@count GraphQL Photos',
  'powered_by_getx': 'Powered by GetX',
  'powered_by_getx_graphql': 'Powered by GetX & GraphQL',

  // MobX Photos screen
  'mobx_app_bar_title': 'MobX Photos',
  'powered_by_mobx': 'Powered by MobX',

  // GetX GraphQL screen
  'getx_graphql_app_bar_title': 'GetX GraphQL Photos',

  // Provider screen
  'provider_app_bar_title': 'Provider',

  // Riverpod screen
  'riverpod_app_bar_title': 'Riverpod',

  // Isolates screen
  'isolates_app_bar_title': 'Isolates',
  'isolates_demo_title': 'Isolates Demonstration',
  'isolates_description':
      'This task calculates prime numbers up to 8,000,000. Observe the loading spinner below:',
  'isolates_main_thread_warning': '• Main Thread: The spinner freezes completely.',
  'isolates_spawn_info': '• Isolate.spawn: The spinner keeps spinning smoothly.',
  'isolates_computing': 'Computing...',
  'isolates_idle': 'UI Thread Active / Idle',
  'isolates_run_main_thread': 'Run on Main Thread (Blocks UI)',
  'isolates_run_isolate': 'Run on Isolate (Smooth)',
  'isolates_calculating': 'Calculating...',
  'isolates_method_label': 'Method: @method',
  'isolates_time_label': 'Execution Time: @time',
  'isolates_result_label': 'Result: @result',
  'isolates_primes_found': '@count primes found',
  'isolates_run_method_main': 'Main Thread',
  'isolates_run_method_isolate': 'Isolate.spawn',
  'isolates_dash': '-',

  // Cart / Product screens
  'tech_shop_title': 'Tech Shop',
  'product_catalog_banner':
      'Screen 1 (Catalog): Adding items here updates the shared parent state, which instantly updates the cart badge count.',
  'add_to_cart': 'Add to Cart',
  'add_more': 'Add More',
  'view_cart': 'View Cart',
  'item_added_to_cart': '@name added to cart!',
  'item_removed_from_cart': '@name removed from cart.',

  'your_cart_title': 'Your Cart',
  'cart_banner':
      'Screen 2 (Cart): Removing items here updates the shared parent state, which synchronizes both screens.',
  'cart_empty_title': 'Your cart is empty',
  'cart_empty_subtitle': 'Add some tech products to see them here!',
  'shop_products': 'Shop Products',
  'subtotal': 'Subtotal',
  'estimated_tax': 'Estimated Tax (10%)',
  'order_total': 'Order Total',
  'proceed_to_checkout': 'Proceed to Checkout',
  'order_placed_title': 'Order Placed!',
  'order_placed_message': 'Thank you! Your order of \$@total has been submitted.',

  // WebSocket Chat screen
  'chat_title': 'WebSocket Echo',
  'chat_clear_tooltip': 'Clear chat',
  'chat_status_connected': 'Connected',
  'chat_status_connecting': 'Connecting…',
  'chat_status_disconnected': 'Disconnected',
  'chat_status_error': 'Connection Error',
  'chat_banner_error': 'Failed to connect. Please check connection.',
  'chat_banner_disconnected': 'Disconnected from echo server.',
  'chat_empty_title': 'Start a conversation',
  'chat_empty_subtitle': 'Type a message below.\nThe WebSocket server will mirror it back.',
  'chat_sender_server': 'Server',
  'chat_input_hint': 'Message…',
  'chat_today': 'Today',
  'chat_yesterday': 'Yesterday',

  // ── Responsive Portfolio ─────────────────────────────────────────────────
  // Nav bar
  'pf_brand_handle':        '@SamInfotech',
  'pf_nav_about':           'About',
  'pf_nav_services':        'Services',
  'pf_nav_skills':          'Skills',
  'pf_nav_projects':        'Projects',
  'pf_nav_contact':         'Contact',
  'pf_nav_open_menu':       'Open menu',
  'pf_nav_close_menu':      'Close menu',
  'pf_nav_dark_mode':       'Dark Mode',

  // Hero
  'pf_hero_greeting':       "Hi, I'm Dhaval 👋",
  'pf_hero_bio':
      'Experienced Android Developer and Team Lead with a passion for '
      'crafting high-quality mobile apps. Skilled in code review, task '
      'management, and clean architecture. Committed to fostering a '
      'collaborative learning environment. Author on Medium, sharing '
      'insights on mobile app development.',
  'pf_hero_location':       'Ahmedabad, India',
  'pf_hero_available':      'Available for new projects',
  'pf_hero_connect_me':     'Connect Me',

  // About
  'pf_about_label':         'About Me',
  'pf_about_heading':       'Interested in learning more about me?',
  'pf_about_bullet1_title': 'Mobile Developer & Team Lead',
  'pf_about_bullet1_body':
      "With 11+ years in mobile app development, I've evolved into a "
      'Mobile Developer and Team Lead. Passionate about clean code and '
      'effective team collaboration, striving for top-tier mobile apps. '
      "Beyond coding, I'm an educator dedicated to sharing knowledge "
      "and inspiring others. Let's connect to innovate!",
  'pf_about_bullet2_title': 'Tech Enthusiast & Educator',
  'pf_about_bullet2_body':
      "In addition to app development, I'm an enthusiastic writer and "
      'educator. I regularly share insights on technology and '
      'programming, particularly in mobile development, helping others '
      'navigate the ever-evolving tech landscape.',

  // Skills
  'pf_skills_label':        'Skills',
  'pf_skills_heading':      'My Technical Expertise',
  'pf_skills_subheading':   'Technologies and tools I work with daily.',

  // Projects
  'pf_projects_label':      'Projects',
  'pf_projects_heading':    'Featured Work',
  'pf_projects_subheading': 'A selection of projects I have built.',
  'pf_project1_title':      'Bench Booster',
  'pf_project1_desc':
      'A Flutter learning app demonstrating state management patterns '
      '(Provider, Riverpod, GetX, MobX) along with GraphQL, Isolates, '
      'and WebSocket chat.',
  'pf_project2_title':      'WebSocket Echo Chat',
  'pf_project2_desc':
      'Real-time chat UI built with Flutter GetX and WebSocket '
      'integration. Features typing indicators, connection states, and '
      'message bubbles.',
  'pf_project3_title':      'TechShop Cart',
  'pf_project3_desc':
      'A cart demo showcasing lifting state up pattern in Flutter with '
      'animated transitions between product catalog and cart detail '
      'screens.',

  // Footer
  'pf_footer_text': '© 2026 @SamInfotech · Built with Flutter & LayoutBuilder',
};

// ─────────────────────────────────────────────────────────────────────────────
// Hindi strings
// ─────────────────────────────────────────────────────────────────────────────
const Map<String, String> _hi = {
  // App / Splash
  'app_title': 'बेंच बूस्टर',
  'splash_tagline': 'अपना प्रदर्शन बेहतर करें',

  // Main menu navigation
  'nav_provider': 'प्रोवाइडर',
  'nav_riverpod': 'रिवरपॉड',
  'nav_getx_photos': 'GetX - फ़ोटो',
  'nav_mobx_photos': 'MobX - फ़ोटो',
  'nav_getx_graphql': 'GetX - GraphQL (फ़ोटो)',
  'nav_isolates': 'आइसोलेट्स डेमो',
  'nav_websocket': 'वेबसॉकेट चैट',
  'nav_lifting_state': 'लिफ्टिंग स्टेट अप (कार्ट)',

  // Language toggle
  'lang_toggle_to_hindi': 'हिंदी',
  'lang_toggle_to_english': 'EN',

  // Common
  'retry': 'पुनः प्रयास करें',
  'ok': 'ठीक है',
  'loading': 'लोड हो रहा है...',
  'error_something_wrong': 'उफ़! कुछ गलत हो गया',
  'no_photos_found': 'कोई फ़ोटो नहीं मिली',
  'loading_photos': 'फ़ोटो लोड हो रही हैं...',
  'loading_graphql_photos': 'GraphQL फ़ोटो लोड हो रही हैं...',

  // GetX Photos screen
  'getx_app_bar_title': 'GetX फ़ोटो',
  'photos_count': '@count फ़ोटो',
  'graphql_photos_count': '@count GraphQL फ़ोटो',
  'powered_by_getx': 'GetX द्वारा संचालित',
  'powered_by_getx_graphql': 'GetX और GraphQL द्वारा संचालित',

  // MobX Photos screen
  'mobx_app_bar_title': 'MobX फ़ोटो',
  'powered_by_mobx': 'MobX द्वारा संचालित',

  // GetX GraphQL screen
  'getx_graphql_app_bar_title': 'GetX GraphQL फ़ोटो',

  // Provider screen
  'provider_app_bar_title': 'प्रोवाइडर',

  // Riverpod screen
  'riverpod_app_bar_title': 'रिवरपॉड',

  // Isolates screen
  'isolates_app_bar_title': 'आइसोलेट्स',
  'isolates_demo_title': 'आइसोलेट्स प्रदर्शन',
  'isolates_description':
      'यह कार्य 8,000,000 तक के अभाज्य संख्याओं की गणना करता है। नीचे लोडिंग स्पिनर देखें:',
  'isolates_main_thread_warning': '• मुख्य थ्रेड: स्पिनर पूरी तरह रुक जाता है।',
  'isolates_spawn_info': '• Isolate.spawn: स्पिनर सुचारू रूप से चलता रहता है।',
  'isolates_computing': 'गणना हो रही है...',
  'isolates_idle': 'UI थ्रेड सक्रिय / निष्क्रिय',
  'isolates_run_main_thread': 'मुख्य थ्रेड पर चलाएं (UI ब्लॉक होगा)',
  'isolates_run_isolate': 'आइसोलेट पर चलाएं (सुचारू)',
  'isolates_calculating': 'गणना हो रही है...',
  'isolates_method_label': 'विधि: @method',
  'isolates_time_label': 'निष्पादन समय: @time',
  'isolates_result_label': 'परिणाम: @result',
  'isolates_primes_found': '@count अभाज्य संख्याएं मिलीं',
  'isolates_run_method_main': 'मुख्य थ्रेड',
  'isolates_run_method_isolate': 'Isolate.spawn',
  'isolates_dash': '-',

  // Cart / Product screens
  'tech_shop_title': 'टेक शॉप',
  'product_catalog_banner':
      'स्क्रीन 1 (कैटलॉग): यहाँ आइटम जोड़ने से साझा पैरेंट स्टेट अपडेट होती है, जिससे कार्ट बैज काउंट तुरंत अपडेट होता है।',
  'add_to_cart': 'कार्ट में जोड़ें',
  'add_more': 'और जोड़ें',
  'view_cart': 'कार्ट देखें',
  'item_added_to_cart': '@name कार्ट में जोड़ा गया!',
  'item_removed_from_cart': '@name कार्ट से हटाया गया।',

  'your_cart_title': 'आपकी कार्ट',
  'cart_banner':
      'स्क्रीन 2 (कार्ट): यहाँ आइटम हटाने से साझा पैरेंट स्टेट अपडेट होती है, जिससे दोनों स्क्रीन सिंक्रनाइज़ होती हैं।',
  'cart_empty_title': 'आपकी कार्ट खाली है',
  'cart_empty_subtitle': 'यहाँ देखने के लिए कुछ टेक उत्पाद जोड़ें!',
  'shop_products': 'उत्पाद खरीदें',
  'subtotal': 'उप-कुल',
  'estimated_tax': 'अनुमानित कर (10%)',
  'order_total': 'कुल ऑर्डर',
  'proceed_to_checkout': 'चेकआउट करें',
  'order_placed_title': 'ऑर्डर दिया गया!',
  'order_placed_message': 'धन्यवाद! आपका \$@total का ऑर्डर सबमिट हो गया।',

  // WebSocket Chat screen
  'chat_title': 'वेबसॉकेट इको',
  'chat_clear_tooltip': 'चैट साफ़ करें',
  'chat_status_connected': 'कनेक्टेड',
  'chat_status_connecting': 'कनेक्ट हो रहा है…',
  'chat_status_disconnected': 'डिस्कनेक्टेड',
  'chat_status_error': 'कनेक्शन त्रुटि',
  'chat_banner_error': 'कनेक्ट करने में विफल। कृपया कनेक्शन जांचें।',
  'chat_banner_disconnected': 'इको सर्वर से डिस्कनेक्ट हो गया।',
  'chat_empty_title': 'बातचीत शुरू करें',
  'chat_empty_subtitle': 'नीचे एक संदेश टाइप करें।\nवेबसॉकेट सर्वर उसे वापस भेजेगा।',
  'chat_sender_server': 'सर्वर',
  'chat_input_hint': 'संदेश…',
  'chat_today': 'आज',
  'chat_yesterday': 'कल',

  // ── Responsive Portfolio ─────────────────────────────────────────────────
  // Nav bar
  'pf_brand_handle':        '@SamInfotech',
  'pf_nav_about':           'परिचय',
  'pf_nav_services':        'सेवाएं',
  'pf_nav_skills':          'कौशल',
  'pf_nav_projects':        'परियोजनाएं',
  'pf_nav_contact':         'संपर्क',
  'pf_nav_open_menu':       'मेनू खोलें',
  'pf_nav_close_menu':      'मेनू बंद करें',
  'pf_nav_dark_mode':       'डार्क मोड',

  // Hero
  'pf_hero_greeting':       'नमस्ते, मैं धवल हूं 👋',
  'pf_hero_bio':
      'अनुभवी एंड्रॉयड डेवलपर और टीम लीड, उच्च-गुणवत्ता वाले मोबाइल '
      'ऐप्स बनाने के प्रति उत्साहित। कोड समीक्षा, कार्य प्रबंधन और '
      'स्वच्छ आर्किटेक्चर में कुशल। सहयोगी सीखने के वातावरण को '
      'बढ़ावा देने के लिए प्रतिबद्ध। मीडियम पर लेखक।',
  'pf_hero_location':       'अहमदाबाद, भारत',
  'pf_hero_available':      'नई परियोजनाओं के लिए उपलब्ध',
  'pf_hero_connect_me':     'संपर्क करें',

  // About
  'pf_about_label':         'मेरे बारे में',
  'pf_about_heading':       'मेरे बारे में और जानना चाहते हैं?',
  'pf_about_bullet1_title': 'मोबाइल डेवलपर और टीम लीड',
  'pf_about_bullet1_body':
      '11+ वर्षों के मोबाइल ऐप विकास के साथ, मैं एक मोबाइल डेवलपर और '
      'टीम लीड के रूप में विकसित हुआ हूं। स्वच्छ कोड और प्रभावी टीम '
      'सहयोग के प्रति उत्साहित। शीर्ष स्तर के मोबाइल ऐप्स बनाने के '
      'लिए प्रयासरत।',
  'pf_about_bullet2_title': 'टेक उत्साही और शिक्षक',
  'pf_about_bullet2_body':
      'ऐप विकास के अलावा, मैं एक उत्साही लेखक और शिक्षक हूं। मैं '
      'नियमित रूप से प्रौद्योगिकी और प्रोग्रामिंग पर, विशेष रूप से '
      'मोबाइल विकास में, अंतर्दृष्टि साझा करता हूं।',

  // Skills
  'pf_skills_label':        'कौशल',
  'pf_skills_heading':      'मेरी तकनीकी विशेषज्ञता',
  'pf_skills_subheading':   'प्रौद्योगिकियाँ और उपकरण जो मैं रोज़ उपयोग करता हूं।',

  // Projects
  'pf_projects_label':      'परियोजनाएं',
  'pf_projects_heading':    'विशेष कार्य',
  'pf_projects_subheading': 'मेरे द्वारा बनाई गई कुछ परियोजनाएं।',
  'pf_project1_title':      'बेंच बूस्टर',
  'pf_project1_desc':
      'एक Flutter लर्निंग ऐप जो Provider, Riverpod, GetX, MobX जैसे '
      'स्टेट मैनेजमेंट पैटर्न के साथ GraphQL, Isolates और WebSocket '
      'चैट प्रदर्शित करता है।',
  'pf_project2_title':      'वेबसॉकेट इको चैट',
  'pf_project2_desc':
      'Flutter GetX और WebSocket एकीकरण के साथ निर्मित रीयल-टाइम '
      'चैट UI। टाइपिंग संकेतक, कनेक्शन स्थिति और संदेश बुलबुले '
      'सुविधाएं।',
  'pf_project3_title':      'टेकशॉप कार्ट',
  'pf_project3_desc':
      'Flutter में लिफ्टिंग स्टेट अप पैटर्न का प्रदर्शन करने वाला '
      'कार्ट डेमो, प्रोडक्ट कैटलॉग और कार्ट स्क्रीन के बीच '
      'एनिमेटेड ट्रांज़िशन के साथ।',

  // Footer
  'pf_footer_text': '© 2026 @SamInfotech · Flutter और LayoutBuilder के साथ बनाया गया',
};
