
import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {

  final String? image;
   
  const ProductImage({
    Key? key,
    this.image
    }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
      child: Container(
        width: double.infinity,
        height: 450,
        decoration: _buildDecoration(),
        child: Opacity(
          opacity: 0.85,
          child: ClipRRect(
            borderRadius: const BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
            child: getImage(image),
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() => BoxDecoration(
    color: Colors.black,
    borderRadius: const BorderRadius.only( topLeft: Radius.circular(20), topRight: Radius.circular(20) ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(5,10)
      )
    ]
  );

  Widget getImage( String? picture ){

    if ( picture == null ){
      return const Image(
          image: AssetImage('assets/no-image.png'),
          fit: BoxFit.cover,
      );
    }

    if ( picture.startsWith('http') ){
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        image: NetworkImage(image!),
        fit: BoxFit.cover,
      ); 
    }

    return Image.file(
      File( picture ),
      fit: BoxFit.cover,
    );  
    
  }

  
}