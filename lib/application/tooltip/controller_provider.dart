import 'package:flutter/material.dart';

class ControllerProvider extends ChangeNotifier {
  /// Internal, private state of the cart.
  // final List<Item> _items = [];
  final Map<String, String> _styleFactors = {};

  /// An unmodifiable view of the items in the cart.
  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);
  Map<String, String> get styleFactors => _styleFactors;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(String key, String val) {
    _styleFactors.update(key, (key) => val, ifAbsent: () => val);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  // /// Removes all items from the cart.
  // void removeAll() {
  //   _items.clear();
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }
}
