import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAfYEm4f7fhWfP4JwW7ltwSmosk_JFerDw';

  final storage = const FlutterSecureStorage();

  // si retornamos algo es una error si no todo bien
  Future<String?> createUser(String email, String pasword) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': pasword,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    }); 

    final res = await http.post( url, body: json.encode(authData) );
    final Map<String, dynamic> decodedResp = json.decode( res.body );

    if (decodedResp.containsKey('idToken')) {

      await storage.write(key: 'token', value: decodedResp['idToken']);

      return null;

    } else {
      return decodedResp['error']['message'];
    }


  }

  Future<String?> loginUSer(String email, String pasword) async {

    final Map<String, dynamic> authData = {
      'email': email,
      'password': pasword,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    }); 

    final res = await http.post( url, body: json.encode(authData) );
    final Map<String, dynamic> decodedResp = json.decode( res.body );

    if (decodedResp.containsKey('idToken')) {
      
      await storage.write(key: 'token', value: decodedResp['idToken']);
      
      return null;

    } else {
      return decodedResp['error']['message'];
    }

  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

}