import 'package:http/http.dart' as http;

import 'dart:convert';

import 'product.dart';

class ProductApi {
  Future<ProductResult> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products?limit=$limit&skip=$skip'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final decodedBody = jsonDecode(response.body);
    final productsList = decodedBody['products'];
    final int total = decodedBody['total'];
    final List<Product> products = [];

    for (var productJson in productsList) {
      products.add(Product.fromJson(productJson));
    }
    
    return ProductResult(products: products, total: total);
  }
}

class ProductResult {
  final List<Product> products;
  final int total;

  ProductResult({required this.products, required this.total});
}
