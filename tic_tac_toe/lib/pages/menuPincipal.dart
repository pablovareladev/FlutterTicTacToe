import 'package:flutter/material.dart';

class menuPrincipal extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          OutlinedButton(
            onPressed: () {
              //-------------ROBERTO-----------------------
              //mostrarMenuPrincipal(context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Image(
          image: AssetImage('assets/images/pablov/fondo.jpg'),
          fit: BoxFit.fitWidth,
          height: 1200,
          width: 2400,
        ),
        Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 490, left: 0),
                child: Image(
                  image: AssetImage('assets/images/pablov/logo.png'),
                  fit: BoxFit.fitHeight,
                  height: 300,
                  width: 400,
                ))),
        Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 80, left: 0),
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
                      image: AssetImage("assets/images/pablov/jugar1VS1.png"),
                    ),
                    onPressed: () {
                      mostrarPagina1VS1(context);
                    },
                  ),
                ))),
        Center(
          child: Padding(
              padding: const EdgeInsets.only(top: 300, left: 0),
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
                    image: AssetImage("assets/images/pablov/jugarCPU.png"),
                  ),
                  onPressed: () {
                    mostrarPaginaCPU(context);
                  },
                ),
              )),
        )
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
