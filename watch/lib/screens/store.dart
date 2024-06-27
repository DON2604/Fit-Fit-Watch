import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:watch/data/dummy_product.dart'; // Assuming you have productItems defined here
import 'package:watch/widgets/product_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:watch/model/FitnessAppModel.dart';
import 'package:watch/providers/fitnessappprovider.dart';

class StoreScreen extends ConsumerWidget {
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.read(fitnessAppModelProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 149, 234, 244), // Light Blue
              Color(0xFFF5F5F5), // Light Grey
            ],
            stops: [0.0, 0.7],
          ),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 45.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Fit-Fit Store",
                    style: TextStyle(
                      fontSize: 21.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // Your CarouselSlider code here
            const SizedBox(
              height: 30,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 220.0),
              child: Text(
                "Today's Best Offers",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: productItems.length,
                itemBuilder: (context, index) {
                  final item = productItems[index];
                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (ctx) => FractionallySizedBox(
                          heightFactor: 0.85,
                          child: ProductDetail(item: item),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: Card(
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              item.imageUrl,
                              height: 146.0,
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesome5Solid.coins,
                                color: Color.fromARGB(255, 231, 175, 7),
                                size: 16,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                item.currentPrice,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            item.originalPrice,
                            style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey[600],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              model.buiItem(item.name); 
                            },
                            child: Text('Buy'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
