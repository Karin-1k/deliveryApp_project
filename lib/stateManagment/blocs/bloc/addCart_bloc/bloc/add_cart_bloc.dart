import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/cart_repo.dart';
import 'package:dlivery_app_project/utils/enums.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/moduls/cart_model.dart';
import '../../../../data/moduls/products_modul.dart';

part 'add_cart_event.dart';
part 'add_cart_state.dart';

class AddCartBloc extends Bloc<CartEventInitial, AddCartState> {
  final CartRepo cartRepo;
  List<CartModel> get gitcartListHistory => cartRepo.getCartListHistory();

  AddCartBloc(this.cartRepo)
      : super(
            AddCartInitial(addCart: {}, totlalQuantity: 0, histroyDatas: [])) {
    on(addCartBloc);
    on(modifieAddcartMap);
    on(setInitialStorage);
    add(CartEventInitial());
    on(setHistoryStorage);
    on(addHistroyForCartPage);
  }

  void setInitialStorage(CartEventInitial event, Emitter emit) {
    List<CartModel> carts;
    carts = cartRepo.getCartList();
    carts.forEach((element) {
      state.addCart.putIfAbsent(element.id!, () => element);
    });
    int _totlavalues = 0;
    state.addCart.forEach((key, value) {
      _totlavalues += value.quantity!;
    });

    emit(AddCartInitial(
        addCart: state.addCart,
        totlalQuantity: _totlavalues,
        histroyDatas: gitcartListHistory));
  }

  void setHistoryStorage(AddHistoryStorage event, Emitter emit) {
    cartRepo.addtoCartList_history(state.getCarts);
    state.addCart.clear();
    List<CartModel> carts = cartRepo.getCartListHistory();
    emit(AddCartInitial(
        addCart: state.addCart,
        totlalQuantity: 0,
        histroyDatas: gitcartListHistory));
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
          wichPage: event.wichPage,
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
                wichPage: event.wichPage));
      }
    }
    int totlavalues = 0;
    state.addCart.forEach((key, value) {
      totlavalues += value.quantity!;
    });

    emit(AddCartInitial(
        addCart: state.addCart,
        totlalQuantity: totlavalues,
        histroyDatas: gitcartListHistory));
    cartRepo.addtoCartList(state.getCarts);
  }

  //* modifie add cart map
  void modifieAddcartMap(ModifieAddCartMap event, Emitter emit) {
    int totlavalues = 0;

    if (event.isIncreament) {
      if (state.addCart[event.id]!.quantity != 20) {
        state.addCart[event.id]!.quantity =
            state.addCart[event.id]!.quantity! + 1;

        state.addCart.forEach((key, value) {
          totlavalues += value.quantity!;
        });
        emit(AddCartInitial(
            addCart: state.addCart,
            totlalQuantity: totlavalues,
            histroyDatas: gitcartListHistory));
      }
    } else {
      state.addCart[event.id]!.quantity =
          state.addCart[event.id]!.quantity! - 1;

      if (state.addCart[event.id]!.quantity == 0) {
        state.addCart.removeWhere((key, value) => value.quantity == 0);
      }
      state.addCart.forEach((key, value) {
        totlavalues += value.quantity!;
      });

      emit(AddCartInitial(
          addCart: state.addCart,
          totlalQuantity: totlavalues,
          histroyDatas: gitcartListHistory));
      cartRepo.addtoCartList(state.getCarts);
    }
  }

  void addHistroyForCartPage(AddHistroyForCartPage event, Emitter emit) {
    state.addCart.clear();
    List<CartModel> _datas = gitcartListHistory;
    for (var i = 0; i < _datas.length; i++) {
      if (event.time == _datas[i].time) {
        _datas[i].wichPage = ToWichPage.productHistory;
        state.addCart.putIfAbsent(_datas[i].id!, () => _datas[i]);
      }
    }
    cartRepo.addtoCartList(state.getCarts);
    int totlavalues = 0;
    state.addCart.forEach((key, value) {
      totlavalues += value.quantity!;
    });
    emit(AddCartInitial(
        addCart: state.addCart,
        totlalQuantity: totlavalues,
        histroyDatas: gitcartListHistory));
  }

  @override
  void onTransition(Transition<CartEventInitial, AddCartState> transition) {
    super.onTransition(transition);
    // print(transition);
  }
}
