part of 'add_cart_bloc.dart';

class AddCartState extends Equatable {
  Map<int, CartModel> addCart;
  List<CartModel> histroyDatas ;
  int totlalQuantity;
  List<CartModel> get getCarts => addCart.entries.map((e) => e.value).toList();
  //* getting total price from getscarts list
  int get getTotallPrice {
    var totalPrice = 0;
    if (getCarts.isEmpty) {
      return totalPrice;
    } else {
      getCarts.forEach((element) {
        totalPrice += element.quantity! * element.price!;
      });
      return totalPrice;
    }
  }

  AddCartState({required this.histroyDatas, required this.addCart, required this.totlalQuantity});

  @override
  List<Object> get props => [addCart, totlalQuantity];
}

class AddCartInitial extends AddCartState {
  Map<int, CartModel> addCart;
  int totlalQuantity;
  List<CartModel> histroyDatas ;

  AddCartInitial({required this.addCart, required this.totlalQuantity,required this.histroyDatas})
      : super(addCart: addCart, totlalQuantity: totlalQuantity,histroyDatas: histroyDatas);

  @override
  // TODO: implement props
  List<Object> get props => [addCart, totlalQuantity];
}
