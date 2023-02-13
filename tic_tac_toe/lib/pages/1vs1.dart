import 'dart:math';
import 'package:flutter/material.dart';

class pagina1vs1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      home: SegundaClase(),
    );
  }
}

//IMPORTANTE MIRAR DE QUE HEREDA
class SegundaClase extends StatefulWidget {
  @override
  TerceraClase createState() => TerceraClase();
}

//HEREDA DE LA SEGUNDA CLASE
class TerceraClase extends State<SegundaClase> {
  List<String> imagenes = [];
  String cuadrado1 = "assets/images/pablov/1.png";
  String cuadrado2 = "assets/images/pablov/2.png";
  String cuadrado3 = "assets/images/pablov/3.png";
  String cuadrado4 = "assets/images/pablov/4.png";
  String cuadrado5 = "assets/images/pablov/5.png";
  String cuadrado6 = "assets/images/pablov/6.png";
  String cuadrado7 = "assets/images/pablov/7.png";
  String cuadrado8 = "assets/images/pablov/8.png";
  String cuadrado9 = "assets/images/pablov/9.png";

  List<bool> ocupados = [];
  bool ocupado1 = false;
  bool ocupado2 = false;
  bool ocupado3 = false;
  bool ocupado4 = false;
  bool ocupado5 = false;
  bool ocupado6 = false;
  bool ocupado7 = false;
  bool ocupado8 = false;
  bool ocupado9 = false;

  bool ganador = false;
  bool empate = false;
  int turno = 0;
  int contEmpate = 0;

  String mostrarTurno = "";
  bool empezarPartida = true;

  String mostrarTextoGanador = "assets/images/pablov/1.png";
  String mostrarPiezaGanadora = "assets/images/pablov/1.png";
  String botonVolverJugar = "assets/images/pablov/1.png";

  @override
  Widget build(BuildContext context) {
    //solo queremos que entr una vez en estos if
    if (empezarPartida) {
      //inicializamos la variable aqui para que cada vez que pase tome un valor diferente
      //es decir que en alguna partida pueda empezar X y en otras O
      int turnoAleatorio = Random().nextInt(10) + 1;
      if (turnoAleatorio > 5) {
        //seria turno de X
        mostrarTurno = "assets/images/pablov/X.png";
        turno = 1;
      } else {
        //seria turno de O
        mostrarTurno = "assets/images/pablov/O.png";
        turno = 0;
      }
      empezarPartida = false;
    }

    //añadimos todos los elementos al arraylist
    imagenes.add(cuadrado1);
    imagenes.add(cuadrado2);
    imagenes.add(cuadrado3);
    imagenes.add(cuadrado4);
    imagenes.add(cuadrado5);
    imagenes.add(cuadrado6);
    imagenes.add(cuadrado7);
    imagenes.add(cuadrado8);
    imagenes.add(cuadrado9);

    //rellenamos tambien el otro array
    ocupados.add(ocupado1);
    ocupados.add(ocupado2);
    ocupados.add(ocupado3);
    ocupados.add(ocupado4);
    ocupados.add(ocupado5);
    ocupados.add(ocupado6);
    ocupados.add(ocupado7);
    ocupados.add(ocupado8);
    ocupados.add(ocupado9);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          OutlinedButton(
            onPressed: () {
              //-------------ROBERTO-----------------------
              mostrarMenuPrincipal(context);
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage('assets/images/pablov/fondo.jpg'),
            fit: BoxFit.fitWidth,
            height: 1200,
            width: 2400,
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 180, left: 0),
                child: Image(
                  image: AssetImage('assets/images/pablov/tablero.png'),
                  fit: BoxFit.cover,
                  height: 350,
                )),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 620, right: 50),
                child: Image(
                  image: AssetImage('assets/images/pablov/textojugar.png'),
                  fit: BoxFit.cover,
                  height: 190,
                )),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 687, left: 280),
                child: Image(
                  image: AssetImage(mostrarTurno),
                  fit: BoxFit.cover,
                  height: 45,
                )),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 430, left: 0),
                child: Image(
                  image: AssetImage(mostrarTextoGanador),
                  fit: BoxFit.cover,
                  height: 200,
                )),
          ),
          Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 600, left: 0),
                child: Image(
                  image: AssetImage(mostrarPiezaGanadora),
                  fit: BoxFit.cover,
                  height: 100,
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 250, left: 0),
              child: Container(
                //tamaños que le vamos a dar
                height: 70,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 158, 158, 158),
                ),
                child: IconButton(
                  //le decimos el texto que queremos que tenga
                  icon: Image(
                    image: AssetImage(botonVolverJugar),
                  ),
                  onPressed: () {
                    if (botonVolverJugar ==
                        "assets/images/pablov/botonvolverjugar.png") {
                      resetearPartida();
                    }
                  },
                ),
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 410),
            child: Row(
              //para centrar de izquierda a derecha
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //le damos margen
                  margin: const EdgeInsets.all(10),
                  //tamaños que le vamos a dar
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    //le decimos el texto que queremos que tenga
                    icon: Image(
                      image: AssetImage(cuadrado1),
                    ),
                    onPressed: () {
                      if (cuadrado1 == "assets/images/pablov/1.png" &&
                          ganador == false) {
                        ocupado1 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    icon: Image(
                      image: AssetImage(cuadrado2),
                    ),
                    onPressed: () {
                      if (cuadrado2 == "assets/images/pablov/2.png" &&
                          ganador == false) {
                        ocupado2 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    icon: Image(
                      image: AssetImage(cuadrado3),
                    ),
                    onPressed: () {
                      if (cuadrado3 == "assets/images/pablov/3.png" &&
                          ganador == false) {
                        ocupado3 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 180, right: 0),
            child: Row(
              //para centrar de izquierda a derecha
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //le damos margen
                  margin: const EdgeInsets.all(10),
                  //tamaños que le vamos a dar
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    //le decimos el texto que queremos que tenga
                    icon: Image(
                      image: AssetImage(cuadrado4),
                    ),
                    onPressed: () {
                      if (cuadrado4 == "assets/images/pablov/4.png" &&
                          ganador == false) {
                        ocupado4 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    icon: Image(
                      image: AssetImage(cuadrado5),
                    ),
                    onPressed: () {
                      if (cuadrado5 == "assets/images/pablov/5.png" &&
                          ganador == false) {
                        ocupado5 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(0, 158, 158, 158),
                  ),
                  child: IconButton(
                    icon: Image(
                      image: AssetImage(cuadrado6),
                    ),
                    onPressed: () {
                      if (cuadrado6 == "assets/images/pablov/6.png" &&
                          ganador == false) {
                        ocupado6 = true;
                        jugar();
                      } else {
                        mostrarCasillaOcupada();
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 0),
              child: Row(
                //para centrar de izquierda a derecha
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //le damos margen
                    margin: const EdgeInsets.all(10),
                    //tamaños que le vamos a dar
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(0, 158, 158, 158),
                    ),
                    child: IconButton(
                      //le decimos el texto que queremos que tenga
                      icon: Image(
                        image: AssetImage(cuadrado7),
                      ),
                      onPressed: () {
                        if (cuadrado7 == "assets/images/pablov/7.png" &&
                            ganador == false) {
                          ocupado7 = true;
                          jugar();
                        } else {
                          mostrarCasillaOcupada();
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(0, 158, 158, 158),
                    ),
                    child: IconButton(
                      icon: Image(
                        image: AssetImage(cuadrado8),
                      ),
                      onPressed: () {
                        if (cuadrado8 == "assets/images/pablov/8.png" &&
                            ganador == false) {
                          ocupado8 = true;
                          jugar();
                        } else {
                          mostrarCasillaOcupada();
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color.fromARGB(0, 158, 158, 158),
                    ),
                    child: IconButton(
                      icon: Image(
                        image: AssetImage(cuadrado9),
                      ),
                      onPressed: () {
                        if (cuadrado9 == "assets/images/pablov/9.png" &&
                            ganador == false) {
                          ocupado9 = true;
                          jugar();
                        } else {
                          mostrarCasillaOcupada();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  jugar() {
    setState(() {
      turno++;
      if (turno % 2 != 0) {
        ponerPiezaO();
        if (ganador == false) {
//ya que ya habrá juagado con lo cual cambiamos la imagen y no hay ganador
          mostrarTurno = "assets/images/pablov/X.png";
        }
        comprobarEmpate();
      } else if (turno % 2 == 0) {
        ponerPiezaX();
        if (ganador == false) {
          //ya que ya habrá juagado con lo cual cambiamos la imagen
          mostrarTurno = "assets/images/pablov/O.png";
        }
        comprobarEmpate();
      }

      //depende de quien empize , cuando terminen turno va a valer 9 o 10
      if ((turno == 10 && mostrarTurno == "assets/images/pablov/X.png") ||
          (turno == 9 && mostrarTurno == "assets/images/pablov/O.png")) {
        resetearPartida();
      }
    });
  }

  //llamar a esta funcion cada vez que se pulse un cuadrado y pasarle el cuadrado correspondidente e igualarlo al mismo
  ponerPiezaX() {
    setState(() {
      //si turno NO es par es turno para jugador X
      if (cuadrado1 == "assets/images/pablov/1.png" && ocupado1 == true) {
        cuadrado1 = "assets/images/pablov/X.png";
      } else if (cuadrado2 == "assets/images/pablov/2.png" &&
          ocupado2 == true) {
        cuadrado2 = "assets/images/pablov/X.png";
      } else if (cuadrado3 == "assets/images/pablov/3.png" &&
          ocupado3 == true) {
        cuadrado3 = "assets/images/pablov/X.png";
      } else if (cuadrado4 == "assets/images/pablov/4.png" &&
          ocupado4 == true) {
        cuadrado4 = "assets/images/pablov/X.png";
      } else if (cuadrado5 == "assets/images/pablov/5.png" &&
          ocupado5 == true) {
        cuadrado5 = "assets/images/pablov/X.png";
      } else if (cuadrado6 == "assets/images/pablov/6.png" &&
          ocupado6 == true) {
        cuadrado6 = "assets/images/pablov/X.png";
      } else if (cuadrado7 == "assets/images/pablov/7.png" &&
          ocupado7 == true) {
        cuadrado7 = "assets/images/pablov/X.png";
      } else if (cuadrado8 == "assets/images/pablov/8.png" &&
          ocupado8 == true) {
        cuadrado8 = "assets/images/pablov/X.png";
      } else if (cuadrado9 == "assets/images/pablov/9.png" &&
          ocupado9 == true) {
        cuadrado9 = "assets/images/pablov/X.png";
      } else {
        //mostrar mensaje de error, casilla ocupada, por favor seleccione otra
      }
      //Comprobamos si ha ganado alguien
      comprobarGanador();
    });
  }

  ponerPiezaO() {
    setState(() {
      //si turno es par es turno para jugador O
      if (cuadrado1 == "assets/images/pablov/1.png" && ocupado1 == true) {
        cuadrado1 = "assets/images/pablov/O.png";
      } else if (cuadrado2 == "assets/images/pablov/2.png" &&
          ocupado2 == true) {
        cuadrado2 = "assets/images/pablov/O.png";
      } else if (cuadrado3 == "assets/images/pablov/3.png" &&
          ocupado3 == true) {
        cuadrado3 = "assets/images/pablov/O.png";
      } else if (cuadrado4 == "assets/images/pablov/4.png" &&
          ocupado4 == true) {
        cuadrado4 = "assets/images/pablov/O.png";
      } else if (cuadrado5 == "assets/images/pablov/5.png" &&
          ocupado5 == true) {
        cuadrado5 = "assets/images/pablov/O.png";
      } else if (cuadrado6 == "assets/images/pablov/6.png" &&
          ocupado6 == true) {
        cuadrado6 = "assets/images/pablov/O.png";
      } else if (cuadrado7 == "assets/images/pablov/7.png" &&
          ocupado7 == true) {
        cuadrado7 = "assets/images/pablov/O.png";
      } else if (cuadrado8 == "assets/images/pablov/8.png" &&
          ocupado8 == true) {
        cuadrado8 = "assets/images/pablov/O.png";
      } else if (cuadrado9 == "assets/images/pablov/9.png" &&
          ocupado9 == true) {
        cuadrado9 = "assets/images/pablov/O.png";
      } else {
        //mostrar mensaje de error, casilla ocupada, por favor seleccione otra
      }
      //Comprobamos si ha ganado alguien
      comprobarGanador();
    });
  }

  comprobarEmpate() {
    setState(() {
      contEmpate++;

      if (contEmpate == 9 && ganador == false) {
        empate = true;
        mostrarTurno = "assets/images/pablov/1.png";
        mostrarTextoGanador = "assets/images/pablov/textoempate.png";
        //mostramos el boton para poder volver a jugar
        mostrarBotonVolverJugar();
      }
    });
  }

  resetearPartida() {
    setState(() {
      //reseteamos el array de cuadros ocupados
      for (int i = 0; i < ocupados.length; i++) {
        ocupados[i] = false;
      }

      ocupado1 = false;
      ocupado2 = false;
      ocupado3 = false;
      ocupado4 = false;
      ocupado5 = false;
      ocupado6 = false;
      ocupado7 = false;
      ocupado8 = false;
      ocupado9 = false;

      cuadrado1 = "assets/images/pablov/1.png";
      cuadrado2 = "assets/images/pablov/2.png";
      cuadrado3 = "assets/images/pablov/3.png";
      cuadrado4 = "assets/images/pablov/4.png";
      cuadrado5 = "assets/images/pablov/5.png";
      cuadrado6 = "assets/images/pablov/6.png";
      cuadrado7 = "assets/images/pablov/7.png";
      cuadrado8 = "assets/images/pablov/8.png";
      cuadrado9 = "assets/images/pablov/9.png";

//reseteamos otras varables...
      empate = false;
      turno = 0;
      contEmpate = 0;
      ganador = false;
      empezarPartida = true;
      contEmpate = 0;
      botonVolverJugar = "assets/images/pablov/1.png";
      mostrarPiezaGanadora = "assets/images/pablov/1.png";
      mostrarTextoGanador = "assets/images/pablov/1.png";
    });
  }

  comprobarGanador() {
    setState(() {
      if ((cuadrado1 == "assets/images/pablov/X.png" &&
              cuadrado2 == "assets/images/pablov/X.png" &&
              cuadrado3 == "assets/images/pablov/X.png") ||
          (cuadrado4 == "assets/images/pablov/X.png" &&
              cuadrado5 == "assets/images/pablov/X.png" &&
              cuadrado6 == "assets/images/pablov/X.png") ||
          (cuadrado7 == "assets/images/pablov/X.png" &&
              cuadrado8 == "assets/images/pablov/X.png" &&
              cuadrado9 == "assets/images/pablov/X.png") ||
          (cuadrado1 == "assets/images/pablov/X.png" &&
              cuadrado4 == "assets/images/pablov/X.png" &&
              cuadrado7 == "assets/images/pablov/X.png") ||
          (cuadrado2 == "assets/images/pablov/X.png" &&
              cuadrado5 == "assets/images/pablov/X.png" &&
              cuadrado8 == "assets/images/pablov/X.png") ||
          (cuadrado3 == "assets/images/pablov/X.png" &&
              cuadrado6 == "assets/images/pablov/X.png" &&
              cuadrado9 == "assets/images/pablov/X.png") ||
          (cuadrado1 == "assets/images/pablov/X.png" &&
              cuadrado5 == "assets/images/pablov/X.png" &&
              cuadrado9 == "assets/images/pablov/X.png") ||
          (cuadrado3 == "assets/images/pablov/X.png" &&
              cuadrado5 == "assets/images/pablov/X.png" &&
              cuadrado7 == "assets/images/pablov/X.png")) {
        ganador = true;
        mostrarTextoGanador = "assets/images/pablov/ganador.png";
        mostrarPiezaGanadora = "assets/images/pablov/X.png";
        mostrarTurno = "assets/images/pablov/1.png";
        //mostramos el boton para poder reiniciar la partida
        mostrarBotonVolverJugar();
      }

      if ((cuadrado1 == "assets/images/pablov/O.png" &&
              cuadrado2 == "assets/images/pablov/O.png" &&
              cuadrado3 == "assets/images/pablov/O.png") ||
          (cuadrado4 == "assets/images/pablov/O.png" &&
              cuadrado5 == "assets/images/pablov/O.png" &&
              cuadrado6 == "assets/images/pablov/O.png") ||
          (cuadrado7 == "assets/images/pablov/O.png" &&
              cuadrado8 == "assets/images/pablov/O.png" &&
              cuadrado9 == "assets/images/pablov/O.png") ||
          (cuadrado1 == "assets/images/pablov/O.png" &&
              cuadrado4 == "assets/images/pablov/O.png" &&
              cuadrado7 == "assets/images/pablov/O.png") ||
          (cuadrado2 == "assets/images/pablov/O.png" &&
              cuadrado5 == "assets/images/pablov/O.png" &&
              cuadrado8 == "assets/images/pablov/O.png") ||
          (cuadrado3 == "assets/images/pablov/O.png" &&
              cuadrado6 == "assets/images/pablov/O.png" &&
              cuadrado9 == "assets/images/pablov/O.png") ||
          (cuadrado1 == "assets/images/pablov/O.png" &&
              cuadrado5 == "assets/images/pablov/O.png" &&
              cuadrado9 == "assets/images/pablov/O.png") ||
          (cuadrado3 == "assets/images/pablov/O.png" &&
              cuadrado5 == "assets/images/pablov/O.png" &&
              cuadrado7 == "assets/images/pablov/O.png")) {
        ganador = true;
        mostrarTextoGanador = "assets/images/pablov/ganador.png";
        mostrarPiezaGanadora = "assets/images/pablov/O.png";
        mostrarTurno = "assets/images/pablov/1.png";
        //mostramos el boton para poder reiniciar la partida
        mostrarBotonVolverJugar();
      }
    });
  }

  mostrarCasillaOcupada() {
    if (ganador == false && empate == false) {
      final snb = SnackBar(
        content: Row(
          children: [
            Icon(Icons.priority_high),
            //para tener una separacion entre un elemento y el otro
            Text("Esa casilla ya está ocupada.")
          ],
        ),
        backgroundColor: Color.fromARGB(255, 111, 111, 110),
      );
      //le pasamos el contexto a ScaffoldMessenger y que muestre la variable
      ScaffoldMessenger.of(context).showSnackBar(snb);
    }
  }

  mostrarBotonVolverJugar() {
    setState(() {
      botonVolverJugar = "assets/images/pablov/botonvolverjugar.png";
    });
  }

  mostrarMenuPrincipal(BuildContext context) {
    //llevamos al usuario a la opcion seleccionada

    Navigator.of(context).pushNamed(
      "/",
    );
  }
}
