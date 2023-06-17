import 'package:e_commerce/data/models/wish_list_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {

bool _addNewItemProgress = false, _getWishListInProgress = false;
WishListModel _wishListModel = WishListModel();

bool get addNewItemInProgress => _addNewItemProgress;
bool get getWishListInProgress => _getWishListInProgress;
WishListModel get wishListModel => _wishListModel;

Future<bool> addToWishList(int productId) async {
  _addNewItemProgress = true;
  update();
  final response = await NetworkCaller.getRequest(url: '/CreateWishList/$productId');
  _addNewItemProgress = false;
  if (response.isSuccess) {
    update();
    return true;
  }else{
    if (response.statusCode == 401) {
      Get.find<AuthController>().logOut();
    }
    return false;
  }
}


Future<bool> getWishList() async {
  _getWishListInProgress = true;
  update();
  final response = await NetworkCaller.getRequest(url: '/ProductWishList');
  _getWishListInProgress = false;
  if (response.isSuccess) {
    _wishListModel = WishListModel.fromJson(response.returnData);
    update();
    return true;
  }else{
    if (response.statusCode == 401) {
      Get.find<AuthController>().logOut();
    }
    return false;
  }
}


}