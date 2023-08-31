import 'package:bloc/bloc.dart';

class ObserverManagment extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('observer');
    print(transition);
    print(bloc);
  }
}
