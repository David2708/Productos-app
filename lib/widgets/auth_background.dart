import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  
  final Widget child;
  
  const AuthBackground({
    super.key, 
    required this.child});

  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _PurpleBox(),
          
          const _HeaderIcon(),

          child,

        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100,),
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(top: 60, left: 40,child: _Buble(),),
          Positioned(top: 200, left: 90,child: _Buble(),),
          Positioned(bottom:60, right: 60,child: _Buble(),),
          Positioned(bottom: 180, right: 20,child: _Buble(),),
          Positioned(bottom: -60, right: 170,child: _Buble(),),
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1),
        ]
      )
    );
  }
}

class _Buble extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.05),
        borderRadius: BorderRadius.circular(100)
      ),
    );
  }
}

