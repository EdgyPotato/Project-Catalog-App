import 'package:flutter/material.dart';

import '../data/product.dart';
import '../data/product_api.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Product? product;
  bool isLoading = true;
  String? errorMessage;

  Future<void> _loadDetails() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedProduct = await ProductApi().fetchProductById(
        widget.productId,
      );
      setState(() {
        product = fetchedProduct;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(errorMessage!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _loadDetails,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    Text(product!.description),
                    const SizedBox(height: 10),
                    Text('Price: RM ${product!.price.toStringAsFixed(2)}'),
                    const SizedBox(height: 10),
                    Text('Rating: ${product!.rating}'),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: product!.images.length,
                        itemBuilder: (context, index) {
                          final imageUrl = product!.images[index];

                          return Image.network(imageUrl);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
