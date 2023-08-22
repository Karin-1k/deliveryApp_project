import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dlivery_app_project/stateManagment/blocs/bloc/addCart_bloc/bloc/add_cart_bloc.dart';
import 'package:equatable/equatable.dart';

part 'quantity_state.dart';

class QuantityCubit extends Cubit<QuantityState> {
  QuantityCubit() : super(QuantityInitial(quantity: 0, isInScope: false));

  void increment() {
    if (state.quantity != 20) {
      emit(ChangeQuantity(quantity: state.quantity + 1, isInScope: false));
    } else {
      emit(ChangeQuantity(quantity: state.quantity, isInScope: true));
    }
  }

  void decrement() {
    if (state.quantity != 0) {
      emit(ChangeQuantity(quantity: state.quantity - 1, isInScope: false));
    } else {
      emit(ChangeQuantity(quantity: state.quantity, isInScope: true));
    }
  }

  void zeroQuantity(int quantity){
    emit(QuantityInitial(quantity: quantity, isInScope: false));
  }
}
