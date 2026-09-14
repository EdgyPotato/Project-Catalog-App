import 'package:flutter_test/flutter_test.dart';
import 'package:catalog_app/data/product.dart';

void main() {
  test('Product.fromJson parses product data', () {
    final json = {
      'id': 1,
      'title': 'Test Product',
      'description': 'Test Description',
      'price': 99.99,
      'rating': 4.5,
      'thumbnail': 'https://example.com/image.jpg',
      'images': ['https://example.com/image.jpg'],
    };

    final product = Product.fromJson(json);

    expect(product.id, 1);
    expect(product.title, 'Test Product');
    expect(product.price, 99.99);
  });
}