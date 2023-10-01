import 'package:dlivery_app_project/utils/constants.dart';
import '../moduls/products_modul.dart';
import 'package:dio/dio.dart';

class ProductsRepo {
  Future<List<ProductsModul>> getProducts() async {
    try {
      print('here we are ');
      final apiResponse = await Dio().get(Constants.nodeApi,
          options: Options(
            receiveTimeout: const Duration(seconds: 30),
          ));

      if (apiResponse.statusCode == 200) {
        print(apiResponse.data.runtimeType);
        print('agrem gyan darmana ');
        List convertApi = apiResponse.data;
        var result = [
          {"totalSize": convertApi.length, "typeId": 1, "offset": 0, "products": convertApi}
        ];
        final value =
            result.map((json) => ProductsModul.fromJson(json)).toList();

        return value;
      } else {
        throw Exception(
            'request failed with this status code: ${apiResponse.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
