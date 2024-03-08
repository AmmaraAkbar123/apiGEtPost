import 'dart:convert';
import 'package:apigetpractice/json_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyProviderAPI extends ChangeNotifier {
  List<Product> _productList = [];
  List<Product> get productList => _productList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getApiList() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response =
          await http.get(Uri.parse("https://dummyjson.com/products"));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        var productListJson = jsonData["products"] as List;
        _productList = productListJson.map((e) => Product.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load products');
      }
      _isLoading = false;
    } catch (error) {
      print('Error fetching products: $error');
    }

    notifyListeners();
  }
}
