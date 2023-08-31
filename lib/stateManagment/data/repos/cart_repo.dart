import 'dart:convert';

import 'package:dlivery_app_project/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../moduls/cart_model.dart';

//* i initialized shared preferences in init method into spash page
class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo(this.sharedPreferences);
  List<String> cart = [];
  void addtoCartList(List<CartModel> cartList) {
    cart = [];
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(Constants.cartListKey, cart);
  }

  List<CartModel> getCartList() {
    List<String> cartLists = [];
    if (sharedPreferences.containsKey(Constants.cartListKey)) {
      cartLists = sharedPreferences.getStringList(Constants.cartListKey)!;
    }
    List<CartModel> carts = [];
    cartLists.forEach(
        (element) => carts.add(CartModel.fromJson(jsonDecode(element))));
    return carts;
  }

  List<String> cart_History = [];

  void addtoCartList_history(List<CartModel> cartListHistory) {
//     sharedPreferences.remove(Constants.cartListKey);
// sharedPreferences.remove(Constants.cartListhistoryKey);
    cart_History = [];
    var time = DateTime.now();

    if (sharedPreferences.containsKey(Constants.cartListhistoryKey)) {
      cart_History =
          sharedPreferences.getStringList(Constants.cartListhistoryKey)!;
    }

    cartListHistory.forEach((element) {
      element.time =
          time.toString(); //!  setting the same time for giving group values
      cart_History.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(Constants.cartListhistoryKey, cart_History);
    sharedPreferences.remove(Constants.cartListKey);
    // List<CartModel> x = getCartListHistory();
  }

  List<CartModel> getCartListHistory() {
    List<CartModel> getHistoryKeys = [];

    if (sharedPreferences.containsKey(Constants.cartListhistoryKey)) {
      List<String> historyCarts =
          sharedPreferences.getStringList(Constants.cartListhistoryKey)!;
      historyCarts.forEach((element) {
        getHistoryKeys.add(CartModel.fromJson(jsonDecode(element)));
      });
    }

    return getHistoryKeys;
  }
}
