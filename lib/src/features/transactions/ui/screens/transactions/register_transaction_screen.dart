import 'package:flutter/material.dart';

class RegisterTransaction extends StatefulWidget {
  @override
  _RegisterTransactionState createState() => _RegisterTransactionState();
}

class _RegisterTransactionState extends State<RegisterTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Registro de Transacción',
        ),
      ),
      body: Text('estoy aqui xd'),
    );
  }
}
