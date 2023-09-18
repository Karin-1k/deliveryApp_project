import 'package:dlivery_app_project/utils/constants.dart';
import 'package:http/http.dart';
import 'dart:convert' as co;
import '../moduls/products_modul.dart';

class ProductsRepo {
  Future<List<ProductsModul>> getProducts() async {
    try {
      // final response = await get(Uri.parse(Constants.mainUrl));
      final apiResponse = await get(Uri.parse(Constants.nodeApi));
      List convertApi = await co.json.decode(apiResponse.body);
      var result = [
        {"totalSize": 6, "typeId": 1, "offset": 0, "products": convertApi}
      ];
      // List result = await co.json.decode(response.body);
      final value = result.map((json) => ProductsModul.fromJson(json)).toList();
      return value;
    } catch (e) {
      throw Exception(e);
    }
  }
}
