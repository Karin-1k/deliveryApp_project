part of 'add_cart_bloc.dart';

class CartEventInitial extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddCartEvent extends CartEventInitial {
  final int quantity;
  final Products products;
  final ToWichPage wichPage;
  AddCartEvent(
      {required this.quantity, required this.products, required this.wichPage});

  @override
  List<Object> get props => [quantity, products];
}

class ModifieAddCartMap extends CartEventInitial {
  final int id;
  final bool isIncreament;
  ModifieAddCartMap({required this.id, required this.isIncreament});
}

class AddHistoryStorage extends CartEventInitial {
  @override
  List<Object?> get props => [];
}

class AddHistroyForCartPage extends CartEventInitial {
  final String time;
  AddHistroyForCartPage({required this.time});
}
