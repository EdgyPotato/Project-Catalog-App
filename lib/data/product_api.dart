import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  Future<String> getProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products?limit=20&skip=0'));
    debugPrint(response.statusCode.toString());
    return response.body;
  }
}
