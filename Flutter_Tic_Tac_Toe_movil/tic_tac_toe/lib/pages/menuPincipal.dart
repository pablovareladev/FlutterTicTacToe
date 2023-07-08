import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class menuPrincipal extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  AudioCache cache = AudioCache();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image(
          image: AssetImage('assets/images/fondo.jpg'),
          fit: BoxFit.cover,
          height: 1200,
          width: 2400,
        ),
        Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 490, left: 0),
                child: Image(
                  image: AssetImage('assets/images/logo.png'),
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
                      image: AssetImage("assets/images/jugar1VS1.png"),
                    ),
                    onPressed: ()  async {
                      await cache.play('audio/buttonSound.mp3');
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
                    image: AssetImage("assets/images/jugarCPU.png"),
                  ),
                  onPressed: () async{
                    await cache.play('audio/buttonSound.mp3');
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
