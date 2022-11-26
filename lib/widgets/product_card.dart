
import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;
   
  const ProductCard({
    Key? key, 
    required this.product
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 20),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [

            _BackgroundImage( image: product.picture, ),

            _ProductDetails( name: product.name, id: product.id,),

            Positioned(
              top: 0,
              right: 0,
              child: _PriceTag( price: product.price, )
            ),


            if(!product.available)
              const Positioned(
                top: 0,
                left: 0,
                child: _NotAvalible()
              )

          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(5,10)
      )
    ]

  );

}

class _NotAvalible extends StatelessWidget {
  const _NotAvalible({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
      ),
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle( color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}



class _PriceTag extends StatelessWidget {

  final double price;

  const _PriceTag({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 5),
      width: 100,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only( topRight: Radius.circular(20), bottomLeft: Radius.circular(20) )
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding:const EdgeInsets.symmetric( horizontal: 10 ),
          child: Text('\$ $price', style: const TextStyle(color: Colors.white, fontSize: 20) ),
        ),
      ),

    );
  }
}




class _ProductDetails extends StatelessWidget {

  final String name;
  final String? id;

  const _ProductDetails({
    Key? key, 
    required this.name, 
    this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only( right: 50 ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), topRight: Radius.circular(20)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          color: Colors.indigo,
          width: double.infinity,
          height: 70,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(name,
              style: const TextStyle( fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              ),

              Text(id ?? '',
              style: const TextStyle( fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold ),
              overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
        ),
      ),
    );
  }
}



class _BackgroundImage extends StatelessWidget {

  final String? image;

  const _BackgroundImage({
    Key? key, 
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: image == null
          ? const Image(
            image: AssetImage('assets/no-image.png'),
            fit: BoxFit.cover,
            )
          : FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(image!),
              fit: BoxFit.cover,
            ), 
      ),
    );
  }

}



