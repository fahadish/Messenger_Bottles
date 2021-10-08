import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_chatapp/components/contents.dart';
import 'package:my_chatapp/screen/registration_screen.dart';
import 'package:my_chatapp/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();

    final emailField = TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return('Please Enter Your Email ');
        }
        if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
          return('Please Enter a Valid Email');
        }
return null;
      },
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kEmailDecoration,
    );

    final passwordField = TextFormField(

      validator: (value){
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return('Please is Required For Login');

        }
        if (!regex.hasMatch(value)) {
          return ('Please enter the valid password(Min.6 Character)');
        }  

      },
      obscureText: true,

      autofocus: false,
      controller: passwordController,
      keyboardType: TextInputType.emailAddress,
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: kPasswordDecoration,
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color:
      const Color(0xffCDB073),
      child: MaterialButton(
        onPressed: () {
          signIn(emailController.text,passwordController.text);
        },
        child: kTextLogin,
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xff7dbded),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xff7dbded),
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 300,
                      child: Image.asset(
                        'Image/attachment_103937755.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    emailField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(
                      height: 35,
                    ),
                    loginButton,
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Don\'t have an account '),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Color(0xff063563)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password )async{
   if(_formKey.currentState!.validate()){
     await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) => {
       Fluttertoast.showToast(msg: 'Successful Login'),
       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomeScreen() ))

     }).catchError((e){
       Fluttertoast.showToast(msg: e!.message);

     });

   }

  }


}
