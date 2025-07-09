import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xml_rpc/client_c.dart' as xml_rpc;
import '../constants/colors.dart';
import '../constants/staticData.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth';

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 1000);

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  bool isLoginSuccess = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FlutterLogin(
        logo: "assets/polycrome_logo_large.png",
        theme: LoginTheme(
          pageColorDark: kMainColor,
          pageColorLight: kBgColor,
          primaryColor: kMainColor,
          accentColor: kBgColor,
          cardTheme: CardTheme(
            color: Colors.grey,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          buttonTheme: LoginButtonTheme(
            backgroundColor: kMainColor,
            splashColor: kMainColor,
            highlightColor: kMainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          inputTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: kBgColor),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kMainColor),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          footerTextStyle: TextStyle(color: Colors.white),
          titleStyle: TextStyle(color: kBgColor, fontSize: 24),
          bodyStyle: TextStyle(color: kBgColor),
          cardInitialHeight: 360,
        ),
        hideForgotPasswordButton: true,
        title: "",
        navigateBackAfterRecovery: true,
        onConfirmRecover: _signupConfirm,
        onConfirmSignup: _signupConfirm,
        loginAfterSignUp: false,
        userValidator: (value) {
          if (value!.isEmpty) {
            return "Enter Valid Email";
          }
          return null;
        },
        passwordValidator: (value) {
          if (value!.isEmpty) {
            return 'Enter Valid Password';
          }
          return null;
        },
        onLogin: (loginData) async {
          debugPrint('Login info');
          debugPrint('Name: ${loginData.name}');
          debugPrint('Password: ${loginData.password}');
          isLoginSuccess = false;

          int userIds = await checkUserLogin(
            "Jayaseelan", "123"
            // loginData.name,
            // loginData.password,
          );
          debugPrint("User IDff: $userIds");
          if (userIds > 0) {
            isLoginSuccess = true;
            return null;
          } else {
            isLoginSuccess = false;
            return Future.value("Invalid Email or password");
          }
        },
        onSubmitAnimationCompleted: () async{
          if (isLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            setState(() {});
          }
        },
        onRecoverPassword: (name) {
          debugPrint('Recover password info');
          debugPrint('Name: $name');
          return _recoverPassword(name);
        },
      ),
    );
  }
  Future<int> checkUserLogin(
      String userName,
      String password,
      )
  async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print("eeerrrrd");
    try {
      final userId = await xml_rpc.call(
        Uri.parse(
          '${baseUrl}xmlrpc/2/common',
        ),
        'login',
        [dbName, userName, password],
      );
      print("useropp.$userId");
      if (userId != false) {
        pref.setInt("user_Id", userId);
        pref.setString("password", password);
        print("wwerr.${userId}");
        return userId;
      }else{
        return -1;
      }
    } catch (e) {
      print("eeeeeooo..$e");
      return -1; // exception
    }
  }
}
