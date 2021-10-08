import 'package:flutter/material.dart';
import 'package:my_chatapp/models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_chatapp/screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user  = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();

@override
  void initState() {
    super.initState();

    FirebaseFirestore.instance.collection('users').doc(user!.uid).get().then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
      });

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff7dbded,),
      appBar: AppBar(title: const Text('Welcome'),centerTitle: true,backgroundColor: const Color(0xffCDB073),),body:

      Center(child: Padding(padding: const EdgeInsets.all(20),  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:<Widget> [
          SizedBox(
            height: 180,child: Image.asset('Image/attachment_103937755.png',fit: BoxFit.contain,),
          ),
const Text('Welcome Back',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          const SizedBox(height: 10,),
           Text('${loggedInUser.firstName}${loggedInUser.secondName}',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),),
           Text('${loggedInUser.email}',style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w400),),
          const SizedBox(height: 15,),ActionChip(label:const Text('Logout'), onPressed: (){
            logOut(context);

          })

        ],

      ) ,),),

    );
  }
  Future<void>  logOut(BuildContext context)
  async{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));

  }
}
