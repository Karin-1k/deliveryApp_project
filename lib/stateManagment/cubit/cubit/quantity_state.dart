part of 'quantity_cubit.dart';

class QuantityState extends Equatable {
  final int quantity;
  final bool isInScope;
  const QuantityState({required this.isInScope, required this.quantity});

  @override
  List<Object> get props => [];
}

class QuantityInitial extends QuantityState {
  final int quantity;
  final bool isInScope;
  QuantityInitial({required this.quantity, required this.isInScope})
      : super(isInScope: isInScope, quantity: quantity);
  @override
  List<Object> get props => [quantity, isInScope];
}

class ChangeQuantity extends QuantityState {
  final int quantity;
  final bool isInScope;
  ChangeQuantity({required this.quantity, required this.isInScope})
      : super(quantity: quantity, isInScope: isInScope);
  @override
  List<Object> get props => [quantity, isInScope];
}
