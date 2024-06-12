import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class StoreItem {
  final String imageUrl;
  final String name;
  final String currentPrice;
  final String originalPrice;

  StoreItem({
    required this.imageUrl,
    required this.name,
    required this.currentPrice,
    required this.originalPrice,
  });
}

class StoreScreen extends StatelessWidget {
  StoreScreen({super.key});

  final List<StoreItem> storeItems = [
    StoreItem(
      imageUrl: 'assets/items/item0.jpg',
      name: 'Headphones',
      currentPrice: '\$108.97',
      originalPrice: '\$135',
    ),
    StoreItem(
      imageUrl: 'assets/items/item1.jpg',
      name: 'Sports Shoes',
      currentPrice: '\$112.50',
      originalPrice: '\$140',
    ),
    StoreItem(
      imageUrl: 'assets/items/item2.jpg',
      name: 'Hydration Bottle',
      currentPrice: '\$15.99',
      originalPrice: '\$20',
    ),
    StoreItem(
      imageUrl: 'assets/items/item3.jpg',
      name: 'Skipping Rope',
      currentPrice: '\$12.99',
      originalPrice: '\$18',
    ),
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            height: 22,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 132.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
            items: [1, 2, 3].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  final List<String> phrase = [
                    'Strength',
                    'Fitness',
                    'Health',
                  ];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/carousel/car$i.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(
                              0.28), // Adjust the opacity here to change the darkness
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        phrase[i - 1],
                        style: const TextStyle(
                            fontSize: 25.0, color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 28,
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
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: storeItems.length,
              itemBuilder: (context, index) {
                final item = storeItems[index];
                return Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        item.imageUrl,
                        height: 140.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        item.currentPrice,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        item.originalPrice,
                        style: TextStyle(
                          fontSize: 14.0,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
