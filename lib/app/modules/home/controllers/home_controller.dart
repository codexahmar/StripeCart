import 'package:get/get.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  List<ProductModel> allProducts = [];
  List<ProductModel> filteredProducts = [];
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() {
    allProducts = DummyHelper.products;
    _applyFilters();
  }

  void changeCategory(String category) {
    if (selectedCategory == category) return;
    selectedCategory = category;
    _applyFilters();
  }

  void onSearchChanged(String query) {
    searchQuery = query.trim().toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    filteredProducts = allProducts.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          (product.category != null &&
              product.category!.toLowerCase() == selectedCategory.toLowerCase());

      final matchesSearch = searchQuery.isEmpty ||
          (product.name != null &&
              product.name!.toLowerCase().contains(searchQuery)) ||
          (product.brand != null &&
              product.brand!.toLowerCase().contains(searchQuery));

      return matchesCategory && matchesSearch;
    }).toList();

    update();
  }
}
