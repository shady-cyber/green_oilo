import 'package:dio/dio.dart';
import 'end_points.dart';

class DioHelper {
  static Dio dio = Dio(
    BaseOptions(baseUrl: EndPoints.BASE_URL, receiveDataWhenStatusError: true),
  );
  DioHelper();

  static Future<Response> getDataWithToken(
      {required String path,
      Map<String, dynamic>? query,
      required String tokenid}) async {
    return await dio.get(path,
        queryParameters: query,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> getData(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio.get(path, queryParameters: query);
  }

  static Future<Response> postImageDataWithToken(
      {required String path,
        required FormData data,
        required String tokenid}) async {
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> postImageDataTraineeWithToken({
    required String path,
    required FormData data,
    required String tokenid,
    Duration connectTimeout = const Duration(seconds: 10), // Adjust the values as needed
    Duration receiveTimeout = const Duration(seconds: 10), // Adjust the values as needed
  }) async {
    Dio dio = Dio();
    dio.options.headers = {
      "Authorization": "Bearer " + tokenid,
    };
    dio.options.connectTimeout = connectTimeout; // Set the connect timeout
    dio.options.receiveTimeout = receiveTimeout; // Set the receive timeout

    try {
      return await dio.post(path, data: data);
    } catch (e) {
      // Handle exceptions here
      throw e;
    }
  }

  static Future<Response> PostDataWithToken({
    required String path,
    Map<String, dynamic>? data,
    required String tokenid,
  }) async {
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

//
  static Future<Response> postDataWithToken(
      {required String path,
      required Map<String, dynamic> data,
      required String tokenid}) async {
    return await dio.post(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> postData(
      {required String path, required Map<String, dynamic> data}) async {
    return await dio.post(path,
        data: data, options: Options(headers: {"Authorization": "Bearer "}));
  }

  static Future<Response> deleteData({
    required String path,
    Map<int, dynamic>? data,
    required String tokenid,
  }) async {
    return await dio.delete(
        path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> putData({
    required String path,
    Map<String, dynamic>? data,
    required String tokenid,
  }) async {
    return await dio.put(path,
        data: data,
        options: Options(headers: {"Authorization": "Bearer " + tokenid}));
  }

  static Future<Response> putDataWithoutToken({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    return await dio.put(
      path,
      data: data,
    );
  }
}
