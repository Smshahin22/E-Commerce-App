import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:get/get.dart';

class BottomNavigationBarController extends GetxController {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  Future<void> changeIndex(int index) async {
    if (index == 2 || index == 3) {
     if (await Get.find<AuthController>().checkAuthValidition() == false) {
        return;
      }
    }
    _selectedIndex = index;
    update();
  }
  void backToHome(){
    if(selectedIndex !=0){

    _selectedIndex = 0;
    update();
  }
  }

}