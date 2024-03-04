import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class NetworkOption {
  static Future<Dio> init() async {
    Dio dio = Dio();

    dio.options = BaseOptions(
      baseUrl: 'https://api.jny.sch.id/api',
      // baseUrl: 'http://10.10.60.122:1001/api',
      headers: {
        'Accept': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );

    IOHttpClientAdapter clientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          HttpClient client = HttpClient();
          client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;

          return client;
        }
    );

    dio.httpClientAdapter = clientAdapter;

    return dio;
  }
}