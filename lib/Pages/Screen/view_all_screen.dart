import 'package:flutter/material.dart';
import 'package:food_delivery/Widgets/products_items_display.dart';
import 'package:food_delivery/core/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewAllProductScreen extends StatefulWidget {
  const ViewAllProductScreen({super.key});

  @override
  State<ViewAllProductScreen> createState() => _ViewAllProductScreenState();
}

class _ViewAllProductScreenState extends State<ViewAllProductScreen> {
  final supabase = Supabase.instance.client;
  List<FoodModel> products = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchFoodProduct();
  }

  Future<void> fetchFoodProduct() async {
    try {
      final response =
          await Supabase.instance.client
              .from("food_product")
              .select(); // Supabase table name
      final data = response as List;

      setState(() {
        products = data.map((json) => FoodModel.fromJson(json)).toList();
        isLoading = false;
      });
    } catch (error) {
      // ignore: avoid_print
      print("Error fetching product: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text("All Products"),
        backgroundColor: Colors.blue[50],
        centerTitle: true,
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                itemCount: products.length,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return ProductsItemsDisplay(foodModel: products[index]);
                },
              ),
    );
  }
}
