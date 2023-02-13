import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/1vs1.dart';
import 'package:tic_tac_toe/pages/contraCPU.dart';
import 'package:tic_tac_toe/pages/menuPincipal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => menuPrincipal(),
        "/pagina1vs1": (BuildContext context) => pagina1vs1(),
        "/paginaCPU": (BuildContext context) => contraCPU(),
      },
    );
  }
}
