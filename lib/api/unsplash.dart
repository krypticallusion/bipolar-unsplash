import 'dart:convert';

import 'package:bipolar_unsplash/api/models.dart';
import "package:dio/dio.dart";

class DioConfig {
  static var dioInstance = Dio(BaseOptions(
      method: "GET",
      baseUrl: "https://api.unsplash.com",
      headers: {
        "Authorization": "Client-ID q85fI9p-Aitz5QHRv9Q9ENpDxvak4N5Yo7YVpcNBVg0"
      }));
}

final dioInstance = DioConfig.dioInstance;

Future<Unsplash> getPhotos({String query, int page = 1}) async {
  var queryResult = await dioInstance.get("/search/photos", queryParameters: {
    "query": query,
    "page": page,
    "per_page": 20,
  });

  return Unsplash.fromJson(queryResult.data);
}
