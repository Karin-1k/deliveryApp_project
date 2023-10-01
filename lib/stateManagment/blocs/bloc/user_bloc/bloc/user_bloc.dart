import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dlivery_app_project/stateManagment/data/moduls/user_module.dart';
import 'package:dlivery_app_project/stateManagment/data/repos/user_repo.dart';
import 'package:dlivery_app_project/utils/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepo userRepo;
  UserBloc({required this.userRepo}) : super(UserInitial()) {
    on(userInfoBloc);
  }

  void userInfoBloc(UserInfoEvent event, Emitter emit) async {
    try {
      http.Response response = await userRepo.getUserInfo();
      if (json.decode(response.body)['success'] == 1) {
        emit(GetUserInfoState(
            userDatas:
                UserModel.fromJson(json.decode(response.body)['message'][0])));
      } else if (json.decode(response.body)['success'] == 0) {
        emit(
          GetUserInfoState(
            userDatas: UserModel(
                id: 0,
                name: 'user',
                email: 'email',
                phone: 'phone',
                orderCount: 0),
          ),
        );
      }
      if (json.decode(response.body)['message'] ==
          'invalid token TokenExpiredError: jwt expired') {
        emit(ExpiredTokenState());
      }
    } catch (e) {
      emit(GetUserInfoState(
        userDatas: UserModel(
            id: 0, name: 'null', email: 'null', phone: 'null', orderCount: 0),
      ));
      print('there is an err in userInfoBloc method from User bloc: ' +
          e.toString());
    }
  }
}
