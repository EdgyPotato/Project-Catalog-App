import 'package:flutter/material.dart';

import 'dart:async';

import '../data/product.dart';
import '../data/product_api.dart';
import 'product_detail_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Product> products = [];
  bool isLoading = true;
  String? errorMessage;
  int total = 0;
  bool isLoadingMore = false;
  String searchQuery = '';
  Timer? debounceTimer;
  final ScrollController scrollController = ScrollController();

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  void _onSearchChanged(String query) {
    searchQuery = query;

    debounceTimer?.cancel();

    debounceTimer = Timer(const Duration(milliseconds: 350), () {
      _doSearch(query);
    });
  }

  Future<void> _loadProducts() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final productResult = await ProductApi().fetchProducts(
        limit: 20,
        skip: 0,
      );
      setState(() {
        products = productResult.products;
        total = productResult.total;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _loadMore() async {
    if (isLoadingMore) return;
    if (products.length >= total) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final productResult = searchQuery.trim().isEmpty
          ? await ProductApi().fetchProducts(limit: 20, skip: products.length)
          : await ProductApi().searchProducts(
              query: searchQuery.trim(),
              limit: 20,
              skip: products.length,
            );

      setState(() {
        products.addAll(productResult.products);
        isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  Future<void> _doSearch(String query) async {
    if (query.trim().isEmpty) {
      await _loadProducts();
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final productResult = await ProductApi().searchProducts(
        query: query.trim(),
        limit: 20,
        skip: 0,
      );

      if (query.trim() != searchQuery.trim()) return;

      setState(() {
        products = productResult.products;
        total = productResult.total;
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
    _loadProducts();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    debounceTimer?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: Column(
        children: [
          TextField(onChanged: _onSearchChanged),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(errorMessage!),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _loadProducts,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : products.isEmpty
                ? const Center(child: Text('No products available.'))
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ListTile(
                        leading: Image.network(product.thumbnail),
                        title: Text(product.title),
                        subtitle: Text("RM ${product.price.toString()}"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(productId: product.id),
                            ),
                          );
                        },
                      );
                    },
                    controller: scrollController,
                  ),
          ),
        ],
      ),
    );
  }
}
