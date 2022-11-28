import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              SizedBox( height: size.height * 0.25, ),
              CardContainer(
                child: Column(
                  children: [

                    Text('Crear cuenta', style: Theme.of(context).textTheme.headline4,),
                    const SizedBox( height: 30, ),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )

                  ],
                )
              ),

              const SizedBox( height: 50, ),

              TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all( Colors.indigo.withOpacity(0.1) ),
                shape: MaterialStateProperty.all( const StadiumBorder() )
              ),
              child: const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child:  Text(
                  '¿Ya tienes una cuenta?', 
                  style: TextStyle(fontSize: 18, color: Colors.indigo)
                ),
              ),

              ),
              const SizedBox( height: 50, ),

            ],
          ),
        )
      )
    );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(

      key: loginForm.formKey,

      autovalidateMode: AutovalidateMode.onUserInteraction,

      child:Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              color: Colors.deepPurple,
              labelText: 'Example@gmail.com',
              hintText: 'Correo electrónico',
              icon: Icons.ac_unit_outlined
            ),
            onChanged: (value) => loginForm.email = value,
            validator: (value) {

              String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp  = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo';

              
            },
          ),

          const SizedBox(height: 30,),

          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
              color: Colors.deepPurple,
              labelText: 'Contraseña',
              hintText: '****',
              icon: Icons.password_outlined
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              if (value != null && value.length >= 6) return null;
              return 'La contraseña debe de ser de 6 caracteres';
            },
          ),

          const SizedBox(height: 30,),

          MaterialButton(
            
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: loginForm.isLoading ? null : () async {

              FocusScope.of(context).unfocus();
              final authService = Provider.of<AuthService>(context, listen: false);

              if (!loginForm.isValidForm()) return;

              loginForm.isLoading = true;

              //Validamos si el login es correcto
              final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password);

              if (errorMessage ==  null){
                Navigator.pushReplacementNamed(context, 'home');
              } else{
                NotificationsService.showSnackbar(errorMessage);
                loginForm.isLoading = false;
              }

            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(
                loginForm.isLoading 
                ? 'Espere...'
                : 'Ingresar'
              ,
              style: const TextStyle(color: Colors.white),
              ),
            ),
          )

        ],
      )
    );
  }
}