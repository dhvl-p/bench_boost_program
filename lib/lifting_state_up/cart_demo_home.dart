import 'package:flutter/material.dart';
import 'product_model.dart';
import 'product_list_screen.dart';
import 'cart_details_screen.dart';

enum CartScreenType { catalog, cartDetails }

class CartDemoHome extends StatefulWidget {
  const CartDemoHome({super.key});

  @override
  State<CartDemoHome> createState() => _CartDemoHomeState();
}

class _CartDemoHomeState extends State<CartDemoHome> {
  // 1. State is defined here in the Parent (Lifting State Up)
  final List<Product> _cartItems = [];
  CartScreenType _currentScreen = CartScreenType.catalog;

  // 2. State modification callbacks
  void _addToCart(Product product) {
    setState(() {
      _cartItems.add(product);
    });
  }

  void _removeFromCart(Product product) {
    setState(() {
      _cartItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentScreen == CartScreenType.cartDetails) {
          setState(() {
            _currentScreen = CartScreenType.catalog;
          });
          return false;
        }
        return true;
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        child: _currentScreen == CartScreenType.catalog
            ? ProductListScreen(
                key: const ValueKey('CatalogScreen'),
                cartItems: _cartItems,
                onAddToCart: _addToCart,
                onViewCart: () {
                  setState(() {
                    _currentScreen = CartScreenType.cartDetails;
                  });
                },
              )
            : CartDetailsScreen(
                key: const ValueKey('CartDetailsScreen'),
                cartItems: _cartItems,
                onRemoveFromCart: _removeFromCart,
                onBack: () {
                  setState(() {
                    _currentScreen = CartScreenType.catalog;
                  });
                },
              ),
      ),
    );
  }
}
