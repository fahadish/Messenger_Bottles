import 'package:flutter/material.dart';
final  kEmailDecoration =  InputDecoration(
  prefixIcon: const Icon(Icons.email),
  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
  hintText: 'Enter Your Email',border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)
),

);
final kPasswordDecoration = InputDecoration(
  prefixIcon: const Icon(Icons.vpn_key),contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
  hintText: 'Enter Your Password',border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20)),
);


const  kTextLogin =const Text('Login',style: TextStyle(
  color: Colors.white,fontSize: 20.0,
  fontWeight: FontWeight.bold,
),);

const  kTextSignUp =const Text('Sign Up',style: TextStyle(
  color: Colors.white,fontSize: 20.0,
  fontWeight: FontWeight.bold,
),);