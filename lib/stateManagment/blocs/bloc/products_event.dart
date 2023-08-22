part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetProductsEvent extends ProductsEvent {}

class ChangeQuantity extends ProductsEvent {
  final bool quantity;

  ChangeQuantity({required this.quantity});
}
