import 'package:facilapp/src/features/transactions/ui/user/cubit/user_cubit.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerOcobo extends StatelessWidget {
  final int selected;

  const DrawerOcobo({this.selected});
  @override
  Widget build(BuildContext context) {
    var option = selected;
    var screenSize = MediaQuery.of(context).size.height * 0.3;
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          var _cubit = BlocProvider.of<UserCubit>(context);
          if (state is ChangedOptionDrawer) {
            option = state.option;
          }
          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: OcoboColors.primaryColor,
                        shape: BoxShape.circle,
                        // image: DecorationImage(image: NetworkImage(''))
                      ),
                      child: Align(
                          alignment: Alignment(0, 0),
                          child: Text('Logo Cliente',
                              style: TextStyle(
                                  fontFamily: "Poppins", color: Colors.white))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Nombre de Usuario',
                      style: TextStyle(fontFamily: "Poppins"),
                    ),
                    Text('correo@gmail.com'),
                  ],
                )),
                ListTile(
                  leading: Icon(Icons.monetization_on_outlined),
                  title: Text(
                    'Transacciones',
                  ),
                  selected: option == 1 ? true : false,
                  onTap: () {
                    _cubit.changeOptionDrawer(option: 1);
                    Navigator.pushNamed(
                        context, routes.HomeTransactionsPageRoute);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.library_books_outlined),
                  focusColor: OcoboColors.primaryColor,
                  selected: option == 2 ? true : false,
                  title: Text('Comprobantes'),
                  onTap: () {
                    _cubit.changeOptionDrawer(option: 2);
                    Navigator.pushNamed(context, routes.HomeVochersPageRoute);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart_outlined),
                  selected: option == 3 ? true : false,
                  title: Text('POS'),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenSize),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.settings_outlined),
                        title: Text('Configuración'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.login),
                        title: Text('Cerrar sesión'),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
