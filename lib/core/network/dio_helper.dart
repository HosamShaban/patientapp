import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://diabetes-2023.000webhostapp.com/api/patient/",
        receiveDataWhenStatusError: true));
  }

  static Future<Response> getData(String url) {
    dio!.options.headers = {
      'Authorization': 'Bearer 21|juRFJMfuVlKhNFVQK7JHSoMQxCVgM2YXwWDS9yCZ'
    };
    return dio!.get(url);
  }
}
