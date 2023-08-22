part of 'products_bloc.dart';

@immutable
abstract class ProductsState extends Equatable {
  List<Object?> get props => [];
}

//initial loading
class ProductsInitialState extends ProductsState {
  @override
  List<Object?> get props => [];
}

//* getting products
class ProductsDatasState extends ProductsState {
  final List<ProductsModul> products;
  ProductsDatasState({required this.products});

  @override
  List<Object?> get props => [products];
}

//! err state
class ErrorState extends ProductsState {
  final String err;
  ErrorState({required this.err});

  @override
  List<Object?> get props => [err];
}


