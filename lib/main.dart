import 'package:flutter/material.dart';

import 'styles/colors.dart';
import 'splash_screen.dart';

import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
  getHttp();
}

Dio createDio() {
  return Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      baseUrl: "https://some-website.com"));
}

void getHttp() async {
  try {
    var response = await Dio().get(
        'https://74bbdce5-c395-497b-9acf-3f4bbf4b7604.mock.pstmn.io/api/products');
    print(response);
    print("\n");
    print(response.data[0]['id']);
    print("\n");
    print(response.headers);
    print("\n");
    print(response.statusCode);
    //response = await dio.get('/test', queryParameters: {'id': 12, 'name': 'wendu'});
    // print(response.data.toString());
  } catch (e) {
    print(e);
  }
}

/*
Dio addInterceptors(Dio dio) {
  return dio
    ..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
        onResponse: (Response response) => responseInterceptor(response),
        onError: (DioError dioError) => errorInterceptor(dioError)));
}

dynamic requestInterceptor(RequestOptions options) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.get("token");

  options.headers.addAll({"Token": "$token${DateTime.now()}"});

  return options;
}

dynamic requestInterceptor(RequestOptions options) async {
  if (options.headers.containsKey("requiresToken")) {
    //remove the auxiliary header
    options.headers.remove("requiresToken");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var header = prefs.get("Header");

    options.headers.addAll({"Header": "$header${DateTime.now()}"});

    return options;
  }
}

 */
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App',
      theme: AppColors.myTheme(),
      home: const SplashScreen(),
    );
  }
}
