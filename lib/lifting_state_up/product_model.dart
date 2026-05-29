import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final IconData icon;
  final Color color;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.icon,
    required this.color,
    required this.description,
  });
}

// Mock products data
const List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'Wireless Headphones',
    price: 99.99,
    icon: Icons.headphones,
    color: Colors.blueAccent,
    description: 'Immersive sound with active noise cancellation and 40h battery life.',
  ),
  Product(
    id: 2,
    name: 'Smart Watch Series X',
    price: 199.99,
    icon: Icons.watch,
    color: Colors.orangeAccent,
    description: 'Track your health, workouts, and receive notifications on the go.',
  ),
  Product(
    id: 3,
    name: 'Ergonomic Gaming Mouse',
    price: 49.99,
    icon: Icons.mouse,
    color: Colors.purpleAccent,
    description: 'Ultra-lightweight design with 16k DPI optical sensor for precision gaming.',
  ),
  Product(
    id: 4,
    name: 'Mechanical Keyboard',
    price: 129.99,
    icon: Icons.keyboard,
    color: Colors.greenAccent,
    description: 'Tactile blue switches with customizable RGB lighting and premium build.',
  ),
  Product(
    id: 5,
    name: 'Portable Bluetooth Speaker',
    price: 79.99,
    icon: Icons.speaker,
    color: Colors.pinkAccent,
    description: 'Waterproof IPX7 rating, deep bass, and 360-degree surrounding sound.',
  ),
  Product(
    id: 6,
    name: 'Ultra Wide 4K Monitor',
    price: 349.99,
    icon: Icons.monitor,
    color: Colors.tealAccent,
    description: '34-inch curved display with HDR support, perfect for creators and gamers.',
  ),
];
