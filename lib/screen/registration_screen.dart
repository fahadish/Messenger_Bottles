

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chatapp/components/contents.dart';
import 'package:my_chatapp/screen/home_screen.dart';
import 'package:my_chatapp/screen/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_chatapp/models/user_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKeys = GlobalKey<FormState>();

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {


    final signUpButton = Material(
      elevation: 5,
      color: const Color(0xffCDB073),borderRadius: BorderRadius.circular(30.0),child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,

        onPressed: (){
          signUp(emailEditingController.text, passwordEditingController.text);
          Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    },
    child: kTextSignUp
    ),
    ) ;


    final firstNameField = TextFormField(
      autofocus: false,
      validator: (value){
        RegExp regexp = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return('The first name can\'t be empty');
        }
        if (!regexp.hasMatch(value)) {
          return('Please enter the valid name (Min. 3 character)');

        }
return null;
      },
      keyboardType: TextInputType.name,
      controller: firstNameEditingController,
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kEmailDecoration.copyWith(hintText: 'Enter your name',prefixIcon: const Icon(Icons.account_circle_sharp)),
    );

    final secondNameField = TextFormField(

      validator: (value){
        if (value!.isEmpty) {
          return ('Please enter the second name');
        }
        return null;
      },

      autofocus: false,

      keyboardType: TextInputType.name,
      controller: secondNameEditingController,
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kEmailDecoration.copyWith(hintText: 'Enter second name',prefixIcon: const Icon(Icons.account_circle_sharp)),
    );
    final emailTextField = TextFormField(
      validator: (value){
        if (value!.isEmpty) {
          return('Enter your your email');
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return('Please enter a valid email');
        }
        return null;
      },
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      controller: emailEditingController,
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kEmailDecoration,
    );

    final passwordTextField = TextFormField(
      
      validator: (value){
        RegExp regexp =RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (value!.isEmpty) {
          return('Enter your password');
        }  
        if (regexp.hasMatch(value)) {
          return('Enter a valid password');
          
        }  
        return null;
      },
      obscureText: true,
      autofocus: false,
      keyboardType: TextInputType.visiblePassword,
      controller: passwordEditingController,
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kPasswordDecoration,
    );
    final confirmPasswordTextField = TextFormField(
      validator: (value){
        if (confirmPasswordEditingController.text != passwordEditingController.text) {
          return'Password didn\'t match';
        }
        return null;
      },
      autofocus: false,
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      controller: confirmPasswordEditingController,
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kPasswordDecoration,
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
elevation: 0,
      ),
      backgroundColor: const Color(0xff7dbded),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xff7dbded),
            child: Padding(
              padding: const EdgeInsets.all(36),
              child: Form(
                key: _formKeys,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'Image/attachment_103937755.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    firstNameField,
                    const SizedBox(height: 20,),
                    secondNameField,
                    const SizedBox(height: 20,),
                    emailTextField,
                    const SizedBox(height: 20,),
                    passwordTextField,
                    const SizedBox(height: 20),
                    confirmPasswordTextField,
                    const SizedBox(height: 20,),
                    signUpButton,
                    SizedBox(height: 20,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signUp(String email, String password)async{
    if (_formKeys.currentState!.validate()) {
      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        postDetailToFireStore()}).catchError((e){
         Fluttertoast.showToast(msg: e!.message);
      });
      
    }  
  }

postDetailToFireStore() async{
    FirebaseFirestore firebaseFirestore =  FirebaseFirestore.instance;

    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email= user!.email;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName= secondNameEditingController.text;

    await firebaseFirestore.collection('users').doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: 'Account Created Successfully :) ');

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context )=> HomeScreen()), (route) => false);
}

}
