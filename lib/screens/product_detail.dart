import 'package:flutter/material.dart';
import 'package:watch/model/store_items.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.item});

  final StoreItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imageUrl,
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            Text(
              item.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Current Price: ${item.currentPrice}',
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              'Original Price: ${item.originalPrice}',
              style: TextStyle(
                fontSize: 16.0,
                decoration: TextDecoration.lineThrough,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              item.description,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
