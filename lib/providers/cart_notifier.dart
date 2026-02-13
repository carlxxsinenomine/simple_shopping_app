


import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:simple_shopping_app/models/product.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier { // Use Set instead of List cause we don't want any duplicates
 // Define the initial value of the state
  @override
  Set<Product> build() {
    return const {};
  }
  // Make methods to update the state
  // Inside any method here in this class we get access to a state object ( Since naka-inherit sa Notifier )
  void addProduct(Product product) {
    // Take the state value ( Set of product )
    // Check if the state does not contain a specific product
    // Add the product if it's not already in the cart
    if(!state.contains(product)) {
      state = {...state, product}; // Add the new product to the current list of products
    }
  }

  void removeProduct(Product product) {
    if(state.contains(product)) {
      // Set the new state to where the to-be-deleted product's id
      // doesn't match the current product/s on the Set
      // So if the IDs matched then remove it by not including it to the new state object
      state = state.where((prod) => prod.id != product.id).toSet();
    }
  }

}

// This is the provider that we will use inside any Consumer

// Remove this since we gonna let riverpod generate this provider for us
// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(() {
//   return CartNotifier(); // Returns a Set of Product object
// });