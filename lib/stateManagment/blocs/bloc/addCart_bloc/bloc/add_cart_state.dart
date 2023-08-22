part of 'add_cart_bloc.dart';

class AddCartState extends Equatable {
  Map<int, CartModel> addCart;
  int totlalQuantity;
  List<CartModel> get getCarts => addCart.entries.map((e) => e.value).toList();
  AddCartState({required this.addCart, required this.totlalQuantity});

  @override
  List<Object> get props => [addCart, totlalQuantity];
}

class AddCartInitial extends AddCartState {
  Map<int, CartModel> addCart;
  int totlalQuantity;

  AddCartInitial({required this.addCart, required this.totlalQuantity})
      : super(addCart: addCart, totlalQuantity: totlalQuantity);
  @override
  // TODO: implement props
  List<Object> get props => [addCart, totlalQuantity];
}
