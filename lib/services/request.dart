import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

dynamic getRequest(Uri url) async {
  print(url);
  final http.Response response = await http.get(url).timeout(
      Duration(
        seconds: 10,
      ), onTimeout: () {
    return Future.value(http.Response(json.encode(timeoutResponse()), 400));
  }).catchError((error) {
    return Future.value(http.Response(json.encode(errorResponse()), 400));
  });
  dynamic responseBody = json.decode(response.body);
  print(responseBody);
  return responseBody;
}

Map<String, dynamic> timeoutResponse() {
  return {
    "success": false,
    "message": "Please check your network connection and try again."
  };
}

Map<String, dynamic> errorResponse() {
  return {
    "success": false,
    "message": "Something went wrong, please try again."
  };
}
