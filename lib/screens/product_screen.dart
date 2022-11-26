
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_from_provider.dart';
import 'package:productos_app/services/products_service.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {

   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => ProductFormProvider( productService.seletedProduct! ),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {

  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            SafeArea(
              child: Stack(
                children: [
                  
                  ProductImage( image: productService.seletedProduct?.picture, ),

                  Positioned(
                    top: 30,
                    left: 20,
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(), 
                      icon: const Icon(Icons.arrow_back_ios_outlined, size: 40, color: Colors.white,) 
                    ),
                  ),

                  Positioned(
                    top: 30,
                    right: 30,
                    child: IconButton(
                      onPressed: () async {
                        final picker = ImagePicker();
                        final XFile? photo = await picker.pickImage(source: ImageSource.camera,);

                        if( photo == null) {
                          // print('No selecciono nada');
                          return;
                        } 

                        // print('Tenemos imagen ${photo.path}');
                        productService.updateSelectedProductImage(photo.path);

                      },
                      icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white,) 
                    ),
                  ),

                ],
              ),
            ),

            const _ProductForm(),

            const SizedBox(height: 100)

          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving 
          ? null
          : () async {

          if(!productForm.isValidatedForm()) return;

          final String? imageUrl = await productService.uploadImage();

          if(imageUrl != null) productForm.product.picture = imageUrl;

          await productService.saveOrCreateProduct(productForm.product);
        },
        child: productService.isSaving 
          ? const CircularProgressIndicator(color: Colors.white)
          : const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

  final productForm = Provider.of<ProductFormProvider>(context);
  final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  initialValue: product.name,
                  onChanged: (value) => product.name = value,
                  validator: (value) {
                    if(value == null || value.length < 3){
                      return 'El producto debe tener un nombre';
                    }
                    return null;
                  },
                  decoration: InputDecorations.authInputDecoration(
                    labelText: 'Nombre del producto', 
                    hintText: 'Nombre', 
                    color: Colors.indigo)
                ),

                TextFormField(
                  initialValue: '${product.price}',
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  onChanged: (value) {
                    double.tryParse(value) == null
                    ? product.price = 0
                    : product.price = double.parse(value);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.authInputDecoration(
                    labelText: 'Precio', 
                    hintText: '\$ 150', 
                    color: Colors.indigo)
                ),

                const SizedBox(height: 20),

                SwitchListTile.adaptive(
                  
                  title: const Text('Disponible'),
                  value: product.available, 
                  activeColor: Colors.indigo,
                  onChanged: (value) => productForm.updateAvailability(value)
                ),

                const SizedBox(height: 20,)

              ],
            ),
          ),
        )
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only( bottomLeft: Radius.circular(20) , bottomRight: Radius.circular(20)  ),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(5, 10)
      )
    ]
  );
}