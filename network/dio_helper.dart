import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://diabetes-2023.000webhostapp.com/api/patient/",
        receiveDataWhenStatusError: true));
  }

  Future<Response> getData(String url) {
    dio!.options.headers = {
      'Authorization': 'Bearer 9|4g7ttHlPA9iteiIBjrmPBBXBjnVMh9LAFbfdvu1T'
    };
    return dio!.get(url);
  }

  Future<Response?> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    dio?.options.headers = {
      'Authorization': '$token',
    };
    return await dio?.post(url, data: data);
  }
}
