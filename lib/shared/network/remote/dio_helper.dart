import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        headers: {
          "Content-Type": "application/json",
          lang: lang,
        },
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      "Content-Type": "application/json",
      'Authorization': token,
      'lang':lang,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
      'lang': lang,
    };
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  


   static Future<Response> putData({
    required Map<String, dynamic> data,
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': token,
      'lang': lang,
    };
    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

