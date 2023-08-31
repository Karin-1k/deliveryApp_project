import 'package:dlivery_app_project/utils/constants.dart';
import 'package:http/http.dart';
import 'dart:convert' as co;
import '../moduls/products_modul.dart';

class ProductsRepo {
  Future<List<ProductsModul>> getProducts() async {
    try {
      final response =
          await get(Uri.parse(Constants.mainUrl));
      List result = await co.json.decode(response.body);

      final value = result.map((json) => ProductsModul.fromJson(json)).toList();
      return value;
    } catch (e) {
      throw Exception(e);
    }
  }
}
