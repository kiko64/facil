import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/button_navigation.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKeyRegisterUser = GlobalKey<FormState>();
  String _company;
  String _role;
  bool _iconPassword;
  bool _colorPassword;

  //Lista para el select de empresa
  List<DropdownMenuItem<String>> listCompany = [
    DropdownMenuItem(
        child: Text(
          "OcoboSoft",
        ),
        value: "OcoboSoft"),
    DropdownMenuItem(
        child: Text(
          'Ibacrea SAS',
        ),
        value: 'Ibacrea SAS'),
  ];

  //Lista para el select de empresa
  List<DropdownMenuItem<String>> listRole = [
    DropdownMenuItem(
        child: Text(
          "Contador",
        ),
        value: "Contador"),
    DropdownMenuItem(
        child: Text(
          'Usuario',
        ),
        value: 'Usuario'),
  ];

  @override
  void initState() {
    super.initState();
    _colorPassword = false;
    _iconPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarOcobo(
          textAction: 'Iniciar Sesión',
          navigator: () {
            Navigator.pushNamed(context, routes.LoginPageRoute);
            // Navigator.of(context).pushNamed('/login');
          },
        ),
        body: Form(
          key: _formKeyRegisterUser,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registro',
                    style: TextStyle(fontFamily: "Poppins", fontSize: 20),
                  ),
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese el nombre';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correo,
                    decoration: InputDecoration(
                      labelText: 'Correo',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese el correo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: _iconPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _iconPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: _colorPassword ? Colors.red : Colors.black,
                        onPressed: () {
                          if (_iconPassword) {
                            _iconPassword = false;
                          } else {
                            _iconPassword = true;
                          }
                          setState(() {});
                        },
                      ),
                      labelText: 'Contraseña',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        _colorPassword = true;
                        setState(() {});
                        return 'Ingrese la contraseña';
                      }
                      _colorPassword = false;
                      setState(() {});
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Empresa',
                    ),
                    items: listCompany,
                    value: _company,
                    onChanged: (value) {
                      setState(() {
                        _company = value;
                      });
                    },
                    validator: (value) {
                      if (_company.isEmpty) {
                        return 'Debe Seleccionar';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Rol',
                    ),
                    items: listRole,
                    value: _role,
                    onChanged: (value) {
                      setState(() {
                        _role = value;
                      });
                    },
                    validator: (value) {
                      if (_role.isEmpty) {
                        return 'Debe Seleccionar';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  ButtonNavigation(
                    text: 'Registrarse',
                    navigator: () async {
                      if (!_formKeyRegisterUser.currentState.validate()) {
                        return;
                      }
                      // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          routes.HomeTransactionsPageRoute, (Route<dynamic> route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
