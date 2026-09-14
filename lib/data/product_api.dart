import 'package:http/http.dart' as http;

import 'dart:convert';

import 'product.dart';

class ProductApi {
  ProductResult _decodeJSON(String responseBody) {
    final decodedBody = jsonDecode(responseBody);
    final productsList = decodedBody['products'];
    final int total = decodedBody['total'];
    final List<Product> products = [];

    for (var productJson in productsList) {
      products.add(Product.fromJson(productJson));
    }

    return ProductResult(products: products, total: total);
  }

  Future<ProductResult> fetchProducts({
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.https('dummyjson.com', '/products', {
        'limit': limit.toString(),
        'skip': skip.toString(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    return _decodeJSON(response.body);
  }

  Future<ProductResult> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    final response = await http.get(
      Uri.https('dummyjson.com', '/products/search', {
        'q': query,
        'limit': limit.toString(),
        'skip': skip.toString(),
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to search products');
    }

    return _decodeJSON(response.body);
  }
}

class ProductResult {
  final List<Product> products;
  final int total;

  ProductResult({required this.products, required this.total});
}
