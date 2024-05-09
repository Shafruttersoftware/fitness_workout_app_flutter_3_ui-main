import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/common_widget/round_textfield.dart';
import 'package:fitness/view/login/complete_profile_view.dart';
import 'package:fitness/view/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../datasource/securesto.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool passToggle = true;
  late final nameController = TextEditingController();
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  bool isCheck = false;

  Future<void> registration() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((_) {
        Fluttertoast.showToast(
          msg: "Registration successfully,Please Login",
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey there,",
                    style: TextStyle(color: TColor.gray, fontSize: 16),
                  ),
                  Text(
                    "Create an Account",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: media.width * 0.05,
                  ),
                  // const RoundTextField(
                  //   hitText: "First Name",
                  //   icon: "assets/img/user_text.png",
                  // ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  // const RoundTextField(
                  //   hitText: "Last Name",
                  //   icon: "assets/img/user_text.png",
                  // ),
                  SizedBox(
                    height: media.width * 0.04,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    cursorColor: const Color(0xFF008080),
                    decoration: InputDecoration(
                        hintText: "Enter your name",
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
                          Icons.person_2_outlined,
                          color: Theme.of(context).brightness == Brightness.light ? const Color(0xFF008080) :Colors.white,
                        )),
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
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        },
                        icon: Icon(
                          isCheck
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank_outlined,
                          color: TColor.gray,
                          size: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child:  Text(
                            "By continuing you accept our Privacy Policy and\nTerm of Use",
                            style: TextStyle(color: TColor.gray, fontSize: 10),
                          ),

                      )
                    ],
                  ),
                  SizedBox(
                    height: media.width * 0.4,
                  ),
                  RoundButton(title: "Register", onPressed: () async{
                    registration();
                    await SecureStorage.setString(nameController.text);
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
                       Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: TColor.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Login",
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
