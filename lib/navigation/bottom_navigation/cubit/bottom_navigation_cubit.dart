import 'dart:math';

import 'package:bloc/bloc.dart';

import '../../../config/firebase.dart';

class BottomNavigationCubit extends Cubit<int> with ErrorHandling {
  BottomNavigationCubit() : super(0);
  navigateToPage(int page) {
    emit(min(4, max(0, page)));
  }
}
