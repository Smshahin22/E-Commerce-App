import 'package:e_commerce/data/models/product_by_category_model.dart';
import 'package:e_commerce/data/models/product_details_model.dart';
import 'package:e_commerce/data/services/network_caller.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  bool _getProductsByCategoryInProgress = false,
      _getProductDetailsInProgress = false;

  ProductByCategoryModel _productByCategoryModel = ProductByCategoryModel();
  ProductDetailsModel _productDetailsModel = ProductDetailsModel();

  bool get getProductsByCategoryInProgress => _getProductsByCategoryInProgress;
  bool get getProductDetailsInProgress => _getProductDetailsInProgress;

  ProductByCategoryModel get productByCategoryModel => _productByCategoryModel;
  ProductDetailsModel get productDetailsModel => _productDetailsModel;



  Future<bool> getProductsByCategory(int categoryId) async {
    _getProductsByCategoryInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(
        url: '/ListProductByCategory/$categoryId');
    _getProductsByCategoryInProgress = false;
    if (response.isSuccess) {
      _productByCategoryModel =
          ProductByCategoryModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }


  Future<bool> getProductDetails(int productId) async {
    _getProductDetailsInProgress = true;
    update();
    final response = await NetworkCaller.getRequest(
        url: '/ProductDetailsById/$productId');
    _getProductDetailsInProgress = false;
    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.returnData);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}
