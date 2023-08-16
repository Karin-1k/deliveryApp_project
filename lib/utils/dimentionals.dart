import 'package:get/get.dart';

class Dimentional {
//* screen height/width
  static final double screenHight = Get.context!.height;
  static final double screenWidth = Get.context!.width;
//* dynamic containers
  static final double pageViewContainer = (screenHight / 3.5);
  static final double pageViewTextContainer = (screenHight / 6.5);
  static final double pageView = (screenHight / 2.44);
  //* dynamic height
  static final double height10 = (screenHight / 78.1);
  static final double height15 = (screenHight / 52);
  static final double height20 = (screenHight / 39);
  static final double height30 = (screenHight / 26);
  static final double height45 = (screenHight / 17.3);
  static final double height120 = (screenHight / 6.5);


  //*dynamic width
  static final double width10 = (screenHight / 78.1);
  static final double width15 = (screenHight / 52);
  static final double width20 = (screenHight / 39);
  static final double width30 = (screenHight / 26);
  static final double width45 = (screenHight / 17.3);

  //* dynamic font size
  static final double font20 = (screenHight / 39);
  static final double font24 = (screenHight / 32.5);
  static final double font16 = (screenHight / 48.8);
  static final double font26 = (screenHight / 30);

  //* dynamic radius
  static final double radius5 = (screenHight / 156.2);
  static final double radius20 = (screenHight / 39);
  static final double radius15 = (screenHight / 52);
  static final double radius30 = (screenHight / 26);

  //* list view img size
  static final double listViewImgSize = screenWidth / 3.2;
  static final double listViewtextcontSize = screenWidth / 3.9;

  //* popular food sizes
  static final double popularcontimgsize = screenHight / 2.2;



}
