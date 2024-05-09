import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../datasource/securesto.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  bool isCheck = false;
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailController.text, password: passwordController.text)
          .then((value) {
        Fluttertoast.showToast(
          msg: "Login successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor:const Color(0xFF008080),
          textColor: Colors.white,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const CompleteProfileView(),
            ));
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF008080),
          content: Text(
            e.code,
            style: const TextStyle(fontSize: 18.0),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              height: media.height * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey there,",
                    style: TextStyle(color: TColor.gray, fontSize: 16),
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email address";
                      } else if (!value.contains("@")) {
                        return "Please Enter Valid Email";
                      } else if (!value.contains(".com")) {
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },
                    cursorColor: const Color(0xFF008080),
                    decoration: InputDecoration(
                        hintText: "Enter your email",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30)),
                        suffixIcon:  Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF008080) :Colors.white,
                        )),
                    // hitText: "Email",
                    // icon: "assets/img/email.png",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: passToggle,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      } else if (value.length < 6) {
                        return "Please enter at least 6 digit";
                      }
                      return null;
                    },
                    cursorColor: const Color(0xFF008080),
                    decoration: InputDecoration(
                        hintText: "Enter Password",
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        filled: true,
                        fillColor: Colors.green.withOpacity(0.5),
                        border: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(30)),
                        suffixIcon: InkWell(
                          onTap: (){
                            setState(() {
                              passToggle =! passToggle;
                            });
                          },
                          child:Icon(
                            passToggle ? Icons.visibility: Icons.visibility_off,color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF008080) :Colors.white,
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 10,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                 const Spacer(),
                  RoundButton(
                      title: "Login",
                      onPressed: ()async{
                        userLogin();
                        // await SecureStorage.setString(nameController.text);
                        await SecureStorage.setString1(emailController.text);
                        await SecureStorage.setString2(passwordController.text);
                        if(_formKey.currentState!.validate()) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const CompleteProfileView()  ));}
                        else{
                          Fluttertoast.showToast(
                              msg: "Please fill all detail",
                              backgroundColor: Colors.redAccent);
                        }
                      }),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                      Text(
                        "  Or  ",
                        style: TextStyle(color: TColor.black, fontSize: 12),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: TColor.gray.withOpacity(0.5),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/img/google.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: media.width * 0.04,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: TColor.white,
                            border: Border.all(
                              width: 1,
                              color: TColor.gray.withOpacity(0.4),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            "assets/img/facebook.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Don’t have an account yet? ",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
