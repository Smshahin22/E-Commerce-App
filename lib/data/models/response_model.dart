class ResponseModel {
  final int statusCode;
  final bool isSuccess;
  final dynamic returnData;

  ResponseModel({
    required this.returnData,
    required this.statusCode,
    required this.isSuccess});

}