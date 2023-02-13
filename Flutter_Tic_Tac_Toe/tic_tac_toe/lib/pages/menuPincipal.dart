
import 'package:flutter/material.dart';

class menuPrincipal extends StatelessWidget {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(children: [
        Image(
          image: AssetImage('assets/images/fondo.jpg'),
          fit: BoxFit.fill,
          height: 755,
          width: 1700,
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 540),
            child: Image(
          image: AssetImage('assets/images/logo.png'),
          fit: BoxFit.fitHeight,
          height: 300,
          width: 400,
        )),

        Padding(
            padding: const EdgeInsets.only(top: 300, left: 620),
            child: Container(
              //tamaños que le vamos a dar
              height: 120,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(0, 158, 158, 158),
              ),
              child: IconButton(
                //le decimos el texto que queremos que tenga
                icon: Image(
                  image: AssetImage("assets/images/jugar1VS1.png"),
                ),
                onPressed: () {
                  mostrarPagina1VS1(context);
                },
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 500, left: 620),
            child: Container(
              //tamaños que le vamos a dar
              height: 120,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(0, 158, 158, 158),
              ),
              child: IconButton(
                //le decimos el texto que queremos que tenga
                icon: Image(
                  image: AssetImage("assets/images/jugarCPU.png"),
                ),
                onPressed: () {
                  mostrarPaginaCPU(context);
                },
              ),
            )),
      ]),
    );
  }

  mostrarPagina1VS1(BuildContext context) {
    //llevamos al usuario a la opcion seleccionada

    Navigator.of(context).pushNamed(
      "/pagina1vs1",
    );
  }

    mostrarPaginaCPU(BuildContext context) {
    //llevamos al usuario a la opcion seleccionada

    Navigator.of(context).pushNamed(
      "/paginaCPU",
    );
  }
}
