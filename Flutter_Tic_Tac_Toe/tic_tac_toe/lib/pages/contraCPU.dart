import 'dart:math';
import 'package:flutter/material.dart';

class contraCPU extends StatelessWidget {
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
  String cuadrado1 = "assets/images/1.png";
  String cuadrado2 = "assets/images/2.png";
  String cuadrado3 = "assets/images/3.png";
  String cuadrado4 = "assets/images/4.png";
  String cuadrado5 = "assets/images/5.png";
  String cuadrado6 = "assets/images/6.png";
  String cuadrado7 = "assets/images/7.png";
  String cuadrado8 = "assets/images/8.png";
  String cuadrado9 = "assets/images/9.png";

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
  bool escogerFicha = false;
  bool haJugadoCPU = false;

  String mostrarTextoGanador = "assets/images/1.png";
  String mostrarPiezaGanadora = "assets/images/1.png";
  String botonVolverJugar = "assets/images/1.png";
  String fichaUsuario = "";
  String fichaCPU = "";
  String mostrarTextoCPUGana ="assets/images/1.png";

  @override
  Widget build(BuildContext context) {
    if (escogerFicha == false) {
      return Scaffold(
        body: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/fondo.jpg'),
              fit: BoxFit.fill,
              height: 755,
              width: 1700,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 100, left: 500),
                child: Image(
                  image: AssetImage('assets/images/textoescogerficha.png'),
                  fit: BoxFit.fitHeight,
                  height: 200,
                  width: 500,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 300, left: 674),
              child: Container(
                //tamaños que le vamos a dar
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 158, 158, 158),
                ),
                child: IconButton(
                  //le decimos el texto que queremos que tenga
                  icon: Image(
                    image: AssetImage("assets/images/O.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      escogerFicha = true;
                      fichaUsuario = "O";
                      fichaCPU = "X";
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 490, left: 674),
              child: Container(
                //tamaños que le vamos a dar
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color.fromARGB(0, 158, 158, 158),
                ),
                child: IconButton(
                  //le decimos el texto que queremos que tenga
                  icon: Image(
                    image: AssetImage("assets/images/X.png"),
                  ),
                  onPressed: () {
                    setState(() {
                      escogerFicha = true;
                      fichaUsuario = "X";
                      fichaCPU = "O";
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
      //mientras no seleccione con que fucha quiere empezar no empezará la partida
    } else {

      if(fichaUsuario == "X" && ganador == false){
         mostrarTurno = "assets/images/X.png";
      }else if (fichaUsuario == "O" && ganador == false){
         mostrarTurno = "assets/images/O.png";
      }else{
        mostrarTurno = "assets/images/1.png";
      }
      //solo queremos que entr una vez en estos if
      if (empezarPartida) {
        //inicializamos la variable aqui para que cada vez que pase tome un valor diferente
        //es decir que en alguna partida pueda empezar X y en otras O
        int turnoAleatorio = Random().nextInt(10) + 1;
        if (turnoAleatorio > 5 && fichaUsuario == "O") {
          //seria turno de X
          turno = 1;
          jugarCPU();
        } else {
          //seria turno de O
          turno = 0;
        }

        if (turnoAleatorio > 5 && fichaUsuario == "X") {
          //seria turno de X
          turno = 1;
          
        } else if(fichaCPU == "O"){
          //seria turno de O
          turno = 0;
          jugarCPU();
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
        body: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/fondo.jpg'),
              fit: BoxFit.fill,
              height: 755,
              width: 1700,
            ),
            Padding(
                padding: const EdgeInsets.only(top: 140, left: 570),
                child: Image(
                  image: AssetImage('assets/images/tablero.png'),
                  fit: BoxFit.cover,
                  height: 350,
                )),
                            Padding(
                padding: const EdgeInsets.only(top: 500, left: 520),
                child: Image(
                  image: AssetImage(mostrarTextoCPUGana),
                  fit: BoxFit.fitHeight,
                  height: 200,
                  width: 500,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 0, left: 570),
                child: Image(
                  image: AssetImage('assets/images/textojugar.png'),
                  fit: BoxFit.cover,
                  height: 190,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 40, left: 865),
                child: Image(
                  image: AssetImage(mostrarTurno),
                  fit: BoxFit.cover,
                  height: 45,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 490, left: 585),
                child: Image(
                  image: AssetImage(mostrarTextoGanador),
                  fit: BoxFit.cover,
                  height: 200,
                )),
            Padding(
                padding: const EdgeInsets.only(top: 610, left: 690),
                child: Image(
                  image: AssetImage(mostrarPiezaGanadora),
                  fit: BoxFit.cover,
                  height: 100,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 490, left: 654),
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
                        "assets/images/botonvolverjugar.png") {
                      resetearPartida();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 140, right: 45),
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
                        if (cuadrado1 == "assets/images/1.png" &&
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
                        if (cuadrado2 == "assets/images/2.png" &&
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
                        if (cuadrado3 == "assets/images/3.png" &&
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 257, right: 45),
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
                        if (cuadrado4 == "assets/images/4.png" &&
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
                        if (cuadrado5 == "assets/images/5.png" &&
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
                        if (cuadrado6 == "assets/images/6.png" &&
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 370, right: 45),
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
                        if (cuadrado7 == "assets/images/7.png" &&
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
                        if (cuadrado8 == "assets/images/8.png" &&
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
                        if (cuadrado9 == "assets/images/9.png" &&
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
          ],
        ),
      );
    }
  }

  jugar() {
    setState(() {
      turno++;

      if (turno % 2 != 0 && fichaUsuario == "O") {
        ponerPiezaO();
        if (ganador == false) {
//ya que ya habrá juagado con lo cual cambiamos la imagen y no hay ganador
        }
        comprobarEmpate();
        jugarCPU();
        
      } else if (turno % 2 == 0 && fichaUsuario == "O") {
        ponerPiezaO();
        if (ganador == false) {
          //ya que ya habrá juagado con lo cual cambiamos la imagen
        }
        comprobarEmpate();
        jugarCPU();
      }

      if (turno % 2 != 0 && fichaUsuario == "X") {
        ponerPiezaX();
        if (ganador == false) {
//ya que ya habrá juagado con lo cual cambiamos la imagen y no hay ganador
        }
        comprobarEmpate();
        jugarCPU();
  
      } else if (turno % 2 == 0 && fichaUsuario == "X") {
        ponerPiezaX();
        if (ganador == false) {
          //ya que ya habrá juagado con lo cual cambiamos la imagen
        }
        comprobarEmpate();
        jugarCPU();   
        
      }
    });
  }
  //llamar a esta funcion cada vez que se pulse un cuadrado y pasarle el cuadrado correspondidente e igualarlo al mismo
  ponerPiezaX() {
    setState(() {
      //si turno NO es par es turno para jugador X
      if (cuadrado1 == "assets/images/1.png" && ocupado1 == true) {
        cuadrado1 = "assets/images/X.png";
      } else if (cuadrado2 == "assets/images/2.png" && ocupado2 == true) {
        cuadrado2 = "assets/images/X.png";
      } else if (cuadrado3 == "assets/images/3.png" && ocupado3 == true) {
        cuadrado3 = "assets/images/X.png";
      } else if (cuadrado4 == "assets/images/4.png" && ocupado4 == true) {
        cuadrado4 = "assets/images/X.png";
      } else if (cuadrado5 == "assets/images/5.png" && ocupado5 == true) {
        cuadrado5 = "assets/images/X.png";
      } else if (cuadrado6 == "assets/images/6.png" && ocupado6 == true) {
        cuadrado6 = "assets/images/X.png";
      } else if (cuadrado7 == "assets/images/7.png" && ocupado7 == true) {
        cuadrado7 = "assets/images/X.png";
      } else if (cuadrado8 == "assets/images/8.png" && ocupado8 == true) {
        cuadrado8 = "assets/images/X.png";
      } else if (cuadrado9 == "assets/images/9.png" && ocupado9 == true) {
        cuadrado9 = "assets/images/X.png";
      }
      //Comprobamos si ha ganado alguien
      comprobarGanador();
    });
  }

  ponerPiezaO() {
    setState(() {
      //si turno es par es turno para jugador O
      if (cuadrado1 == "assets/images/1.png" && ocupado1 == true) {
        cuadrado1 = "assets/images/O.png";
      } else if (cuadrado2 == "assets/images/2.png" && ocupado2 == true) {
        cuadrado2 = "assets/images/O.png";
      } else if (cuadrado3 == "assets/images/3.png" && ocupado3 == true) {
        cuadrado3 = "assets/images/O.png";
      } else if (cuadrado4 == "assets/images/4.png" && ocupado4 == true) {
        cuadrado4 = "assets/images/O.png";
      } else if (cuadrado5 == "assets/images/5.png" && ocupado5 == true) {
        cuadrado5 = "assets/images/O.png";
      } else if (cuadrado6 == "assets/images/6.png" && ocupado6 == true) {
        cuadrado6 = "assets/images/O.png";
      } else if (cuadrado7 == "assets/images/7.png" && ocupado7 == true) {
        cuadrado7 = "assets/images/O.png";
      } else if (cuadrado8 == "assets/images/8.png" && ocupado8 == true) {
        cuadrado8 = "assets/images/O.png";
      } else if (cuadrado9 == "assets/images/9.png" && ocupado9 == true) {
        cuadrado9 = "assets/images/O.png";
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
        mostrarTurno = "assets/images/1.png";
        mostrarTextoGanador = "assets/images/textoempate.png";
        //mostramos el boton para poder volver a jugar
        empate = true;
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

      cuadrado1 = "assets/images/1.png";
      cuadrado2 = "assets/images/2.png";
      cuadrado3 = "assets/images/3.png";
      cuadrado4 = "assets/images/4.png";
      cuadrado5 = "assets/images/5.png";
      cuadrado6 = "assets/images/6.png";
      cuadrado7 = "assets/images/7.png";
      cuadrado8 = "assets/images/8.png";
      cuadrado9 = "assets/images/9.png";

//reseteamos otras varables...
      empate = false;
      turno = 0;
      contEmpate = 0;
      ganador = false;
      empezarPartida = true;
      contEmpate = 0;
      botonVolverJugar = "assets/images/1.png";
      mostrarPiezaGanadora = "assets/images/1.png";
      mostrarTextoGanador = "assets/images/1.png";
      mostrarTextoCPUGana ="assets/images/1.png";
    });
  }

  comprobarGanador() {
    setState(() {
      if ((cuadrado1 == "assets/images/X.png" &&
              cuadrado2 == "assets/images/X.png" &&
              cuadrado3 == "assets/images/X.png") ||
          (cuadrado4 == "assets/images/X.png" &&
              cuadrado5 == "assets/images/X.png" &&
              cuadrado6 == "assets/images/X.png") ||
          (cuadrado7 == "assets/images/X.png" &&
              cuadrado8 == "assets/images/X.png" &&
              cuadrado9 == "assets/images/X.png") ||
          (cuadrado1 == "assets/images/X.png" &&
              cuadrado4 == "assets/images/X.png" &&
              cuadrado7 == "assets/images/X.png") ||
          (cuadrado2 == "assets/images/X.png" &&
              cuadrado5 == "assets/images/X.png" &&
              cuadrado8 == "assets/images/X.png") ||
          (cuadrado3 == "assets/images/X.png" &&
              cuadrado6 == "assets/images/X.png" &&
              cuadrado9 == "assets/images/X.png") ||
          (cuadrado1 == "assets/images/X.png" &&
              cuadrado5 == "assets/images/X.png" &&
              cuadrado9 == "assets/images/X.png") ||
          (cuadrado3 == "assets/images/X.png" &&
              cuadrado5 == "assets/images/X.png" &&
              cuadrado7 == "assets/images/X.png")) {
        ganador = true;

        if(ganador == true && fichaUsuario != "X"){
          mostrarTextoCPUGana = "assets/images/textoCPUgana.png";
        }else{
        mostrarTextoGanador = "assets/images/ganador.png";
        mostrarPiezaGanadora = "assets/images/X.png";
        mostrarTurno = "assets/images/1.png";
        }

        //mostramos el boton para poder reiniciar la partida
        mostrarBotonVolverJugar();
      }

      if ((cuadrado1 == "assets/images/O.png" &&
              cuadrado2 == "assets/images/O.png" &&
              cuadrado3 == "assets/images/O.png") ||
          (cuadrado4 == "assets/images/O.png" &&
              cuadrado5 == "assets/images/O.png" &&
              cuadrado6 == "assets/images/O.png") ||
          (cuadrado7 == "assets/images/O.png" &&
              cuadrado8 == "assets/images/O.png" &&
              cuadrado9 == "assets/images/O.png") ||
          (cuadrado1 == "assets/images/O.png" &&
              cuadrado4 == "assets/images/O.png" &&
              cuadrado7 == "assets/images/O.png") ||
          (cuadrado2 == "assets/images/O.png" &&
              cuadrado5 == "assets/images/O.png" &&
              cuadrado8 == "assets/images/O.png") ||
          (cuadrado3 == "assets/images/O.png" &&
              cuadrado6 == "assets/images/O.png" &&
              cuadrado9 == "assets/images/O.png") ||
          (cuadrado1 == "assets/images/O.png" &&
              cuadrado5 == "assets/images/O.png" &&
              cuadrado9 == "assets/images/O.png") ||
          (cuadrado3 == "assets/images/O.png" &&
              cuadrado5 == "assets/images/O.png" &&
              cuadrado7 == "assets/images/O.png")) {
        ganador = true;

        if(ganador == true && fichaUsuario != "O"){
          mostrarTextoCPUGana = "assets/images/textoCPUgana.png";
        }else{
        mostrarTextoGanador = "assets/images/ganador.png";
        mostrarPiezaGanadora = "assets/images/O.png";
        mostrarTurno = "assets/images/1.png";
        }
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
      botonVolverJugar = "assets/images/botonvolverjugar.png";
    });
  }

  jugarCPU() {
    setState(() {
      while (!haJugadoCPU && !ganador && !empate) {
        int randomCPU = Random().nextInt(9) + 1;

        //solo entrará en los if si tiene hueco disponible
        if (randomCPU == 1 && fichaCPU == "X" && ocupado1 == false) {
          cuadrado1 = "assets/images/X.png";
          ocupado1 = true;
          haJugadoCPU = true;
        } else if (randomCPU == 2 && fichaCPU == "X" && ocupado2 == false) {
          cuadrado2 = "assets/images/X.png";
          ocupado2 = true;
          haJugadoCPU = true;
        } else if (randomCPU == 3 && fichaCPU == "X" && ocupado3 == false) {
          cuadrado3 = "assets/images/X.png";
          ocupado3 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 4 && fichaCPU == "X" && ocupado4 == false) {
          cuadrado4 = "assets/images/X.png";
          ocupado4 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 5 && fichaCPU == "X" && ocupado5 == false) {
          cuadrado5 = "assets/images/X.png";
          ocupado5 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 6 && fichaCPU == "X" && ocupado6 == false) {
          cuadrado6 = "assets/images/X.png";
          ocupado6 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 7 && fichaCPU == "X" && ocupado7 == false) {
          cuadrado7 = "assets/images/X.png";
          ocupado7 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 8 && fichaCPU == "X" && ocupado8 == false) {
          cuadrado8 = "assets/images/X.png";
          ocupado8 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 9 && fichaCPU == "X" && ocupado9 == false) {
          cuadrado9 = "assets/images/X.png";
          ocupado9 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        }
        //solo entrará en los if si tiene hueco disponible
        if (randomCPU == 1 && fichaCPU == "O" && ocupado1 == false) {
          cuadrado1 = "assets/images/O.png";
          ocupado1 = true;
          haJugadoCPU = true;
        } else if (randomCPU == 2 && fichaCPU == "O" && ocupado2 == false) {
          cuadrado2 = "assets/images/O.png";
          ocupado2 = true;
          haJugadoCPU = true;
        } else if (randomCPU == 3 && fichaCPU == "O" && ocupado3 == false) {
          cuadrado3 = "assets/images/O.png";
          ocupado3 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 4 && fichaCPU == "O" && ocupado4 == false) {
          cuadrado4 = "assets/images/O.png";
          ocupado4 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 5 && fichaCPU == "O" && ocupado5 == false) {
          cuadrado5 = "assets/images/O.png";
          ocupado5 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 6 && fichaCPU == "O" && ocupado6 == false) {
          cuadrado6 = "assets/images/O.png";
          ocupado6 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 7 && fichaCPU == "O" && ocupado7 == false) {
          cuadrado7 = "assets/images/O.png";
          ocupado7 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 8 && fichaCPU == "O" && ocupado8 == false) {
          cuadrado8 = "assets/images/O.png";
          ocupado8 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        } else if (randomCPU == 9 && fichaCPU == "O" && ocupado9 == false) {
          cuadrado9 = "assets/images/O.png";
          ocupado9 = true;
          haJugadoCPU = true;
          //nos aseguramos de que ha jugado la CPU y marcamos el cuadrado como ocupado
        }
      }

//se muestra el turno del usuario una vez juegue la CPU

      turno++;
      comprobarGanador();
      comprobarEmpate();
      //sale del while con lo cual la CPU ya marcó
      haJugadoCPU = false;
    });
  }
}
