
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/services/products_service.dart';
import 'package:productos_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<ProductsService>(context);
    final listProducts = productsService.products;

    if( productsService.isLoading ) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login_outlined),
            onPressed: () {
              final authService = Provider.of<AuthService>(context, listen: false);
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listProducts.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            productsService.seletedProduct = listProducts[index].copy();
            Navigator.pushNamed(context, 'product');
          },
          child: ProductCard( product:  listProducts[index] ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          productsService.seletedProduct = Product(
            available: false, 
            name: '', 
            price: 0
          );
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}