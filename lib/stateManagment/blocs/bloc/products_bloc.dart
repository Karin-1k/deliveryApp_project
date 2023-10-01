import 'package:bloc/bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/products_modul.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/products_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitialState()) {
    on(_getProducts);
  }
  void _getProducts(GetProductsEvent event, Emitter emit) async {
    try {
      var data = ProductsRepo().getProducts();
      List<ProductsModul> product = await data.then((value) => value);
      print('im here now ');
      emit(ProductsDatasState(products: product));
    } catch (e) {
      emit(ErrorState(
          err: 'can\'t find the server may couse internet connection'));
      throw Exception(e.toString());
    }
  }
}
