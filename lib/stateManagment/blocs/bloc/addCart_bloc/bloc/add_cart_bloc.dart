import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/moduls/cart_model.dart';
import '../../../../data/moduls/products_modul.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<CartEventInitial, AddCartState> {
  AddCartBloc() : super(AddCartInitial(addCart: {}, totlalQuantity: 0)) {
    on(addCartBloc);
  }

  void addCartBloc(AddCartEvent event, Emitter emit) {
    if (state.addCart.containsKey(event.products.id)) {
      state.addCart.update(
        event.products.id!,
        (value) => CartModel(
          id: event.products.id,
          img: event.products.img,
          isExist: true,
          name: event.products.name,
          price: event.products.price,
          quantity: event.quantity,
          time: DateTime.now().toString(),
        ),
      );
      state.addCart.removeWhere((key, value) => value.quantity == 0);
    } else {
      if (event.quantity != 0) {
        state.addCart.putIfAbsent(
            event.products.id!,
            () => CartModel(
                  id: event.products.id,
                  img: event.products.img,
                  isExist: true,
                  name: event.products.name,
                  price: event.products.price,
                  quantity: event.quantity,
                  time: DateTime.now().toString(),
                ));
      }
    }
    int totlavalues = 0;
    state.addCart.forEach((key, value) {
      totlavalues += value.quantity!;
    });
    emit(AddCartInitial(addCart: state.addCart, totlalQuantity: totlavalues));
    state.addCart.forEach((key, value) {
      print('the key is : $key' + ' the value is : ${value.quantity}');
      print(state.addCart);
      print('total quantity is : ${state.totlalQuantity}');
    });
  }
}
