import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_shopping_app/providers/cart_notifier.dart';
import 'package:simple_shopping_app/providers/products_provider.dart';
import 'package:simple_shopping_app/shared/cart_icon.dart';

// Use ConsumerWidget for stateless widget that will consume or use a state provider
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The .watch() monitors the state provider for
    // changes and rebuilds the build method once the state changes
    final allProducts = ref.watch(productsProvider); // Watches the productsProvider for changes
    final cartProducts = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder:(context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withOpacity(0.05),
              child: Column(
                children: [
                  Image.asset(allProducts[index].image, width: 60, height: 60,),
                  Text(allProducts[index].title),
                  Text("PHP ${allProducts[index].price}"),

                  if(cartProducts.contains(allProducts[index]))
                    TextButton(
                      onPressed: () {
                        ref.read(
                          cartNotifierProvider.notifier
                        ).removeProduct(allProducts[index]);
                      },
                      child: const Text("Remove"),
                    ),

                  if(!cartProducts.contains(allProducts[index]))
                    TextButton(
                      onPressed: () {
                        // read() to access any method on the Notifier
                        ref.read(
                          cartNotifierProvider.notifier // Access the Notifier instance
                        ).addProduct(allProducts[index]);
                      },
                      child: const Text("Add to Cart"),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}