import 'package:facilapp/src/features/transactions/ui/screens/forget_password_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/home_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/login_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/register_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/splash_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/home_transactions_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> routes () {
  return <String, WidgetBuilder>{
  '/': (BuildContext context) => SplashOcobo(),
  '/home': (BuildContext context) => Home(),
  '/homeTransactions': (BuildContext context) => TransaccionScreen(),
  '/login': (BuildContext context) => Login(),
  '/registerUser' : (BuildContext context) => RegisterScreen(),
  '/forgetPassword' : (BuildContext context) => ForgetPasswordScreen(),

  };
}