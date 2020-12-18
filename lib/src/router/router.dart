import 'package:facilapp/src/features/transactions/ui/screens/forget_password_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/home_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/login_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/register_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/splash_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/home_transactions_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/register_transaction_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/vouchers/home_voucher_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/movements/movements_screen.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:flutter/material.dart';

// Map<String, WidgetBuilder> routes () {
//   return <String, WidgetBuilder>{
//   '/': (BuildContext context) => SplashOcobo(),
//   '/home': (BuildContext context) => Home(),
//   '/homeTransactions': (BuildContext context) => TransaccionScreen(),
//   '/homeVouchers': (BuildContext context) => VoucherScreen(),
//   '/movements': (BuildContext context) => MovementScreen(),
//   '/login': (BuildContext context) => Login(),
//   '/registerUser' : (BuildContext context) => RegisterScreen(),
//   '/forgetPassword' : (BuildContext context) => ForgetPasswordScreen(),
//   '/registerTransaction' : (BuildContext context) => RegisterTransaction(),
//   };
// }

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.SplashRoute:
      return MaterialPageRoute(builder: (context) => SplashOcobo());
    // case routes.SplashInfoRoute:
    //   final navigator = (settings.arguments as Map)['navigator'];
    //   final color = (settings.arguments as Map)['color'];
    //   final icon = (settings.arguments as Map)['icon'];
    //   final text = (settings.arguments as Map)['text'];
    //   return MaterialPageRoute(builder: (context) => SplashInformation(
    //     navigator: navigator,
    //     color: color,
    //     icon: icon,
    //     text: text,
    //   ));
    case routes.LoginPageRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case routes.HomePageRoute:
      return MaterialPageRoute(builder: (context) => Home());
    case routes.HomeTransactionsPageRoute:
      return MaterialPageRoute(builder: (context) => TransaccionScreen());
    case routes.HomeVochersPageRoute:
      final vouchers = (settings.arguments as Map)['vouchers'];
      final search = (settings.arguments as Map)['search'];
      return MaterialPageRoute(
          builder: (context) => VoucherScreen(
                vouchers: vouchers,
                search: search,
              ));
    case routes.MovementsPageRoute:
      final argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MovementScreen(
                voucher: argument,
              ));
    case routes.RegisterUserPageRoute:
      return MaterialPageRoute(builder: (context) => RegisterScreen());
    case routes.ForgetPasswordPageRoute:
      return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
    case routes.RegisterTransactionPageRoute:
      final argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => RegisterTransactionScreen(
                transaction: argument,
              ));
    case routes.Microfono:
      return MaterialPageRoute(builder: (context) => ForgetPasswordScreen());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
