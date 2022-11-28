

import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
   
  const CheckAuthScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if( !snapshot.hasData ){
              return const Text('Espere');
            }

            Future.microtask(() {
                Navigator.pushReplacement(
                  context, 
                  PageRouteBuilder(
                    transitionDuration: const Duration( seconds: 0 ),
                    pageBuilder: ( _ , __ , ___ ) => 
                      snapshot.data == '' 
                      ? const LoginScreen()
                      : const HomeScreen(),
                    )
                );
              });

            return Container();
          },
        ),
      ),
    );
  }
}