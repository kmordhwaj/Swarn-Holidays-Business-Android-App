// ignore_for_file: avoid_print, use_rethrow_when_possible

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swarn_holidays_business_main/abc/home1.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:ionicons/ionicons.dart';
//import 'package:rive/rive.dart';
//import 'package:swarn_holidays_business_main/screens/general/home/home1.dart';
//import 'package:swarn_holidays_business_main/screens/general/registration/registerscreen.dart';
import 'package:swarn_holidays_business_main/services/auth_service.dart';
import 'package:swarn_holidays_business_main/widgets/backgroundimage.dart';

//final GoogleSignIn googleSignIn = GoogleSignIn();

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static const String id = 'login_screen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  //formkey
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  bool isAuth = false;

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //authentication
  // final _auth = FirebaseAuth.instance;
/*
  @override
  void initState() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('error signing in : $err');
    });
    super.initState();

    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('error signing in : $err');
    });
  } */

/*
  handleSignIn(GoogleSignInAccount? account) {
    if (account != null) {
      print('user signed in :  $account');
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  //googlesignin
  googleLogin() {
    googleSignIn.signIn();
  }

  //googlelogout
  googleLogout() {
    googleSignIn.signOut();
  }
 */
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/logob.png',
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: TextFormField(
                            controller: emailController,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white),
                              prefixIcon: Icon(Icons.mail, color: Colors.white),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return "Please Enter Valid Email";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: TextFormField(
                            controller: passwordController,
                            autofocus: false,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.white),
                              prefixIcon:
                                  Icon(Icons.vpn_key, color: Colors.white),
                            ),
                            obscureText: true,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Please Enter Your Password";
                              }
                              if (!regex.hasMatch(value)) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        if (_isLoading) const CircularProgressIndicator(),
                        if (!_isLoading)
                          ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                                elevation: 8,
                                primary: Colors.blue,
                                fixedSize: const Size(200, 40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        /*        const SizedBox(height: 20.0),
                        ListTile(
                          contentPadding: const EdgeInsets.only(left: 110),
                          tileColor: Colors.black87,
                          title: Center(
                            child: Text('LogIn With',
                                style: TextStyle(
                                    color: Colors.lightGreen.shade300,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25)),
                          ),
                          trailing: const Padding(
                            padding: EdgeInsets.only(right: 115.0),
                            child: Icon(
                              Ionicons.logo_google,
                              color: Colors.lightBlue,
                              size: 30,
                            ),
                          ),
                          onTap: googleLogin,
                        ),
                     */
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  _submit() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();
      //Logging the user
      try {
        await AuthService.loginUser(
                emailController.text.trim(), passwordController.text.trim())
            .then((id) => {
                  Fluttertoast.showToast(msg: 'logged in successfully'),
                  print('here is the error'),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const Home1(
                            isCameFromLogin: true,
                          )))
                });
      } on PlatformException catch (e) {
        Fluttertoast.showToast(msg: 'error');
        setState(() {
          _isLoading = false;
        });
        throw (e);
      }
    }
  }
}
