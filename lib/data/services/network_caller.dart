import 'dart:convert';
import 'package:e_commerce/ui/state_managers/auth_controller.dart';
import 'package:e_commerce/data/models/response_model.dart';
import 'package:e_commerce/data/utils/urls.dart';
import 'package:http/http.dart';

class NetworkCaller {
  NetworkCaller._();
//getRequest
  static Future<ResponseModel> getRequest({required String url}) async{
    try {
      print(AuthController.token.toString());
    final Response response = await get(Uri.parse(Urls.baseUrl + url), headers: {
      'content-type' : 'application/json',
      'Accept' : 'application/json',
      'token' : AuthController.token.toString()
    });
    if (response.statusCode == 200) {
      return ResponseModel(
        isSuccess: true,
        statusCode: response.statusCode,
        returnData: jsonDecode(response.body),
      );
    } else{
    return ResponseModel(
    isSuccess: false,
    statusCode: response.statusCode,
    returnData: jsonDecode(response.body));
    }
  } catch (e) {
      return ResponseModel(
        isSuccess: false,
        statusCode: -1,
        returnData: e.toString(),
      );
    }
    }

    //postRequest
  static Future<ResponseModel> postRequest({required String url, Map<String, dynamic>? body, }) async{
    try {
      print(AuthController.token.toString());
      print(body);
      final Response response = await post(Uri.parse(Urls.baseUrl + url), headers: {
        'content-type' : 'application/json',
        'Accept' : 'application/json',
        'token' : AuthController.token.toString()
      }, body: jsonEncode(body));
      if (response.statusCode == 200) {
        return ResponseModel(
          isSuccess: true,
          statusCode: response.statusCode,
          returnData: jsonDecode(response.body),
        );
      } else{
        return ResponseModel(
            isSuccess: false,
            statusCode: response.statusCode,
            returnData: jsonDecode(response.body));
      }
    } catch (e) {
      return ResponseModel(
        isSuccess: false,
        statusCode: -1,
        returnData: e.toString(),
      );
    }
  }


}