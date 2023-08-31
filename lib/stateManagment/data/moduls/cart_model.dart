import 'package:dlivery_app_project/stateManagment/data/moduls/products_modul.dart';
import 'package:dlivery_app_project/utils/enums.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist = false;
  String? time;
  ToWichPage? wichPage;
  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.wichPage});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    wichPage = stringToToWichPage(json['wichPage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'name': this.name,
      'price': this.price,
      'img': this.img,
      'quantity': this.quantity,
      'isExist': this.isExist,
      'time': this.time,
      'wichPage':
          this.wichPage.toString() //!becareful should convert enum to String
      //! bcz toJson only expect num and string or bool
    };
  }
}
