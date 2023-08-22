part of 'add_cart_bloc.dart';

class CartEventInitial extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCartEvent extends CartEventInitial {
  final int quantity;
  final Products products;
  AddCartEvent({required this.quantity, required this.products});

  @override
  List<Object> get props => [quantity, products];
}
