import 'package:e_commerce/data/models/product_by_category_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:get/get.dart';

class PopularProductByRemarkController extends GetxController {
  bool _getPopularProductByRemarkInProgress = false;


  ProductByCategoryModel _popularProduct = ProductByCategoryModel();

  bool get getPopularProductByRemarkInProgress => _getPopularProductByRemarkInProgress;


  ProductByCategoryModel get popularProductsModel => _popularProduct;

  Future<bool> getPopularProductsByRemark() async {
    _getPopularProductByRemarkInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(url:  '/ListProductByRemark/popular');
    _getPopularProductByRemarkInProgress = false;
    if (response.isSuccess) {
      _popularProduct = ProductByCategoryModel.fromJson(response.returnData);
      update();
      return true;
    }else {
      update();
      return false;
    }
  }





}