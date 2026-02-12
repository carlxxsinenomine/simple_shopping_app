


import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';

class CartNotifier extends Notifier<Set<Product>> { // Use Set instead of List cause we don't want any duplicates
 // Define the initial value of the state
  @override
  Set<Product> build() {
    return const {
      Product(id: '4', title: 'Red Backpack', price: 14, image: 'assets/products/backpack.png'),
    };
  }
  // Make methods to update the state
}

// This is the provider that we will use inside any Consumer
final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
  return CartNotifier(); // Returns a Set of Product object
});