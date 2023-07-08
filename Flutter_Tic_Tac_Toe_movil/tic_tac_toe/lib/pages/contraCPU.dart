import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
class contraCPU extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TicTacToe',
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
  int turno = 0; //se decide quien empieza
  int contEmpate = 0;

  String mostrarTurno = "";
  bool empezarPartida = true;
  bool escogerFicha = false;
  bool haJugadoCPU = false;
  int primeraEsquina = 0;
  int ronda = 0; //para jugadas de la CPU

  String mostrarTextoGanador = "assets/images/1.png";
  String mostrarPiezaGanadora = "assets/images/1.png";
  String botonVolverJugar = "assets/images/1.png";
  String fichaUsuario = "";
  String fichaCPU = "";
  String mostrarTextoCPUGana = "assets/images/1.png";

  //PARA REPRODUCIR SONIDOS
  AudioCache cache = AudioCache();

  @override
  Widget build(BuildContext context) {
    if (escogerFicha == false) {
      return Scaffold(
        body: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/fondo.jpg'),
              fit: BoxFit.cover,
              height: 1200,
              width: 2400,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 475, left: 0),
                  child: Image(
                    image: AssetImage('assets/images/textoescogerficha.png'),
                    fit: BoxFit.fitHeight,
                    height: 200,
                    width: 500,
                  )),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80, left: 0),
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
                    onPressed: () async{
                      //sonido de escoger ficha O
                        await cache.play('audio/Osound.mp3');
                      setState(() {
                        escogerFicha = true;
                        fichaUsuario = "O";
                        fichaCPU = "X";
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 300, left: 0),
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
                    onPressed: () async{
                      //sonido de escoger ficha X
                        await cache.play('audio/Xsound.mp3');
                      setState(() {
                        escogerFicha = true;
                        fichaUsuario = "X";
                        fichaCPU = "O";
                      });
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      );
      //mientras no seleccione con que ficha quiere empezar no empezará la partida
    } else {
      if (fichaUsuario == "X" && ganador == false) {
        mostrarTurno = "assets/images/X.png";
      } else if (fichaUsuario == "O" && ganador == false) {
        mostrarTurno = "assets/images/O.png";
      } else {
        mostrarTurno = "assets/images/1.png";
      }
      //solo queremos que entre una vez en estos if
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
        } else if (fichaCPU == "O") {
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
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/fondo.jpg'),
              fit: BoxFit.cover,
              height: 1200,
              width: 2400,
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 180, left: 0),
                  child: Image(
                    image: AssetImage('assets/images/tablero.png'),
                    fit: BoxFit.cover,
                    height: 350,
                  )),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 400, left: 50),
                  child: Image(
                    image: AssetImage(mostrarTextoCPUGana),
                    fit: BoxFit.fitHeight,
                    height: 170,
                    width: 550,
                  )),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 620, right: 50),
                  child: Image(
                    image: AssetImage('assets/images/textojugar.png'),
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
                    onPressed: () async{
                      //reproducir sonido de boton
                      await cache.play('audio/buttonSound.mp3');
                        
                      if (botonVolverJugar ==
                          "assets/images/botonvolverjugar.png") {
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
                      onPressed: () async{

                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado1 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado1 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }


                        if (cuadrado1 == "assets/images/1.png" &&
                            ganador == false) {
                          ocupado1 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                              //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                      onPressed: () async{
                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado2 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado2 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                        if (cuadrado2 == "assets/images/2.png" &&
                            ganador == false) {
                          ocupado2 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                      onPressed: () async{
                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado3 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado3 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                        if (cuadrado3 == "assets/images/3.png" &&
                            ganador == false) {
                          ocupado3 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                      onPressed: () async{
                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado4 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado4 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                        if (cuadrado4 == "assets/images/4.png" &&
                            ganador == false) {
                          ocupado4 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                      onPressed: () async{
                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado5 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado5 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                        if (cuadrado5 == "assets/images/5.png" &&
                            ganador == false) {
                          ocupado5 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                      onPressed: () async{
                        //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado6 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado6 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                        if (cuadrado6 == "assets/images/6.png" &&
                            ganador == false) {
                          ocupado6 = true;
                          jugar();

                          //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                        onPressed: () async{
                          //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado7 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado7 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                          if (cuadrado7 == "assets/images/7.png" &&
                              ganador == false) {
                            ocupado7 = true;
                            jugar();

                            //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                        onPressed: () async{
                          //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado8 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado8 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                          if (cuadrado8 == "assets/images/8.png" &&
                              ganador == false) {
                            ocupado8 = true;
                            jugar();

                            //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
                        onPressed: () async{
                          //Si está jugando X
                        if(mostrarTurno == "assets/images/X.png" && ocupado9 == false){
                          //reproducir sonido de X
                           await cache.play('audio/Xsound.mp3');
                          //Si está jugando O
                        }else if(mostrarTurno == "assets/images/O.png" && ocupado9 == false){
                          //reproducir sonido de O
                           await cache.play('audio/Osound.mp3');
                        }
                          if (cuadrado9 == "assets/images/9.png" &&
                              ganador == false) {
                            ocupado9 = true;
                            jugar();

                            //significa que ha ganado el usuario, reproducir sonido victoria
                            if(ganador == true && mostrarTextoGanador != "assets/images/1.png"){
                              await cache.play('audio/victorySound.mp3');
                            //sonido de derrota
                            }else if(ganador == true && mostrarTextoGanador == "assets/images/1.png"){
                              await cache.play('audio/defeatSound.mp3');
                            }
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
  }

  jugar() {
    setState(() {
      turno++;
//comprobamos que TURNO ES PARA SABER QUIEN EMPIEZA y CONTINUA JUGANDO
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
  ponerPiezaX(){
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

  comprobarEmpate() async{
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
    //SONIDO DE EMPATE
    if(contEmpate == 9 && ganador == false){
    await cache.play('audio/tieSound.mp3');
    }
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
      mostrarTextoCPUGana = "assets/images/1.png";
      ronda = 0;
    });
  }

  comprobarGanador() {
    setState(() {
      //aumentamos la ronda para saber que jugada tendrá que hacer la cpu
      ronda++;
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

        if (ganador == true && fichaUsuario != "X") {
          mostrarTextoCPUGana = "assets/images/textoCPUgana.png";
        } else {
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

        if (ganador == true && fichaUsuario != "O") {
          mostrarTextoCPUGana = "assets/images/textoCPUgana.png";
        } else {
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

/*Intentando hacer IA lista   1 3 7 9 */
//FICHA DE LA CPU ES X--------------------------------------------------------------------------------------------------------------------
if(fichaCPU == "X"){
  //PRIMER TURNO de la partida (pillará una esquina de forma aleatoria )
//RONDA 0-------------------------------------------------------------------

        if (ronda == 0) {
          esquinaAleatoriaCPUX();
        }
        //ha empezado jugando el USUARIO, vamos a comprobar la estategia optima
        //RONDA 1--------------------------------------------------------------------------------
        if (ronda == 1) {
          //comprobamos si ha empezado en una esquina para ponerla en el centro
          if (!ocupado5) {
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
            //Si empieza en el centro, esquina aleatoria
          } else if (ocupado5) {
            esquinaAleatoriaCPUX();
          }
        }

        //RONDA 2-------------------------------------------------------------------------

        //ronda 2 significa que ha empezado la CPU, va a comprobar cual es la estrategia optima
        if (ronda == 2) {
          //Comprobamos si el usuario ha escogido el centro
          if (cuadrado5 == "assets/images/O.png") {
            //CPU empezo esquina superior izquierda
            if (ocupado1) {
              cuadrado9 = "assets/images/X.png";
              ocupado9 = true;
              haJugadoCPU = true;
              //CPU empezo esquina superior derecha
            } else if (ocupado3) {
              cuadrado7 = "assets/images/X.png";
              ocupado7 = true;
              haJugadoCPU = true;
              //CPU empezo esquina inferior izquierda
            } else if (ocupado7) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
              //CPU empezo esquina inferior derecha
            } else if (ocupado9) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            }
          }
          //Si ha empezado la CPU y el usuario no ha escogido el centro
          if (!ocupado5) {
            //SI CPU EMPIEZA ESQUINA SUPERIOR IZQUIERDA
            if (cuadrado1 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado2) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU EMPIEZA ESQUINA SUPERIOR DERECHA
            if (cuadrado3 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU ESCOGE ESQUINA INFERIOR IZQUIERDA
            if (cuadrado7 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU ESCOGE ESQUINA INFERIOR DERECHA
            if (cuadrado9 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              }
            }
          }
        }
        //RONDA 3---------------------------------------------------------------------------------------------------------
        //ACORDARME DE IMPLEMENTAR ESQUINA ALEATORIA SI USUARIO POR EJEMPLO HACE 2 6-- CPU NO PUEDE AUN HACER 3 EN RAYA

        if (ronda == 3) {
          //comprobamos primero si podemos cortar un 3 en raya
          cortarTresEnRayaCPUX();

          //CPU EMPEZÓ EN EL CENTRO, DEBE BLOQUEAR A USUARIO
          if (cuadrado5 == "assets/images/X.png") {
            if (ocupado1 && ocupado2 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado3 && !haJugadoCPU) {
              cuadrado2 = "assets/images/X.png";
              ocupado2 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado4 && !haJugadoCPU) {
              cuadrado7 = "assets/images/X.png";
              ocupado7 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado6 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado7 && !haJugadoCPU) {
              cuadrado4 = "assets/images/X.png";
              ocupado4 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado8 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado9 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado3 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado4 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado6 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado8 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado9 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado4 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado6 && !haJugadoCPU) {
              cuadrado9 = "assets/images/X.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado8 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado9 && !haJugadoCPU) {
              cuadrado6 = "assets/images/X.png";
              ocupado6 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado6 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado8 && !haJugadoCPU) {
              cuadrado7 = "assets/images/X.png";
              ocupado7 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado9 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/X.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado8 && !haJugadoCPU) {
              cuadrado9 = "assets/images/X.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado9 && !haJugadoCPU) {
              cuadrado3 = "assets/images/X.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado7 && ocupado8 && !haJugadoCPU) {
              cuadrado9 = "assets/images/X.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado7 && ocupado9 && !haJugadoCPU) {
              cuadrado8 = "assets/images/X.png";
              ocupado8 = true;
              haJugadoCPU = true;
            }
          }
          //Usuario empezó en centro
          if (cuadrado5 == "assets/images/O.png") {
            //Y CPU EMPEZÓ EN ESQUINA SUPERIOR IZQUIERDA
            if (cuadrado1 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/X.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/X.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/X.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/X.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA SUPERIOR DERECHA
            if (cuadrado3 == "assets/images/X.png" && !haJugadoCPU) {
              //casilla que ocupa el usuario
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/X.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/X.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/X.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/X.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA INFERIOR IZQUIERDA
            if (cuadrado7 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado9 = "assets/images/X.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/X.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/X.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/X.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/X.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA INFERIOR DERECHA
            if (cuadrado9 == "assets/images/X.png" && !haJugadoCPU) {
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado7 = "assets/images/X.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/X.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/X.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado3 = "assets/images/X.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/X.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/X.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
          }
        }
//RONDA 4--------------------------------------------------------------------------------------- EMPEZÓ JUGANDO CPU
//COMPROBAR SI PUEDE HACER 3 EN RAYA Y COMPROBAR CORTAR 3 EN RAYA 24 posibilidades//5a ficha de la partida, 3a de la CPU
        if (ronda == 4) {
          //PRIMERO VA A COMPROBAR SI PUEDE HACER 3 EN RAYA
          puedeTresEnRayaCPUX();

          //CPU TIENE ESQUINAS CONTRARIAS y usuario habrá escogido medio
          if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado1 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }
          //SI USUARIO CORTA A LA CPU
          if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado1 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado3 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado3 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado1 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado7 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado8 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }



          //NEW

          else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado8 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado1 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado8 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }
        }

//RONDA 5 HA EMPEZADO JUGANDO EL USUARIO// usuario tiene 3 fichas colocadas y cpu 2-------------------------------------------------------
//se va a colocar 6a pieza de la partida
        if(ronda == 5){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUX();

          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUX();

          if(cuadrado6 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (cuadrado1 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado2 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado8 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado1 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 

            
          }else if (cuadrado1 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true;     
          }else if (cuadrado4 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado1 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true;   
          }else if (cuadrado7 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && cuadrado8 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }

          else if (cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }



//NEW

          else if (cuadrado5 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }
          else if (cuadrado5 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }




          else if (cuadrado1 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && cuadrado1 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado4 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }

    }

//RONDA 6 HA EMPEZADO JUGANDO CPU// CPU tiene 3piezas y usuario 3------------------------------------------------------------------------
//se va a colocar 7a pieza de la partida
        if(ronda == 6){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUX();

          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUX();
        }
//RONDA 7 HA EMPEZADO JUGANDO USUARIO// USUARIO tiene 4 fichas y CPU 3------------------------------------------------------------------------
//se va a colocar 8a pieza de la partida
        if(ronda == 7){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUX();
          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUX();

          if(!ocupado4 && !ocupado6  && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(!ocupado2 && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if (!ocupado1 && !ocupado9 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (!ocupado3 && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado1 && !ocupado2 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (!ocupado2 && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (!ocupado3 && !ocupado6 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (!ocupado6 && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (!ocupado9 && !ocupado8 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (!ocupado8 && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado7 && !ocupado4 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado4 && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }
        }
//RONDA 8 HA EMPEZADO CPU // CPU tiene 4 fichas y USUARIO 4------------------------------------------------------------------------
//se va a colocar 9a Y ULTIMA pieza de la partida
        if(ronda == 8){
 //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUX();
          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUX();
          if(!ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(!ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(!ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(!ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(!ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(!ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(!ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(!ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(!ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }
        }
}
//FICHA DE LA PU ES O----------------------------------------------------------------------------------------------------------------------
if(fichaCPU == "O"){
    //PRIMER TURNO de la partida (pillará una esquina de forma aleatoria )
//RONDA 0-------------------------------------------------------------------

        if (ronda == 0) {
          esquinaAleatoriaCPUO();
        }
        //ha empezado jugando el USUARIO, vamos a comprobar la estategia optima
        //RONDA 1--------------------------------------------------------------------------------
        if (ronda == 1) {
          //comprobamos si ha empezado en una esquina para ponerla en el centro
          if (!ocupado5) {
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
            //Si empieza en el centro, esquina aleatoria
          } else if (ocupado5) {
            esquinaAleatoriaCPUO();
          }
        }
        //RONDA 2-------------------------------------------------------------------------

        //ronda 2 significa que ha empezado la CPU, va a comprobar cual es la estrategia optima
        if (ronda == 2) {
          //Comprobamos si el usuario ha escogido el centro
          if (cuadrado5 == "assets/images/X.png") {
            //CPU empezo esquina superior izquierda
            if (ocupado1) {
              cuadrado9 = "assets/images/O.png";
              ocupado9 = true;
              haJugadoCPU = true;
              //CPU empezo esquina superior derecha
            } else if (ocupado3) {
              cuadrado7 = "assets/images/O.png";
              ocupado7 = true;
              haJugadoCPU = true;
              //CPU empezo esquina inferior izquierda
            } else if (ocupado7) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
              //CPU empezo esquina inferior derecha
            } else if (ocupado9) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            }
          }
          //Si ha empezado la CPU y el usuario no ha escogido el centro
          if (!ocupado5) {
            //SI CPU EMPIEZA ESQUINA SUPERIOR IZQUIERDA
            if (cuadrado1 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado2) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU EMPIEZA ESQUINA SUPERIOR DERECHA
            if (cuadrado3 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU ESCOGE ESQUINA INFERIOR IZQUIERDA
            if (cuadrado7 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado9) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //SI CPU ESCOGE ESQUINA INFERIOR DERECHA
            if (cuadrado9 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado1) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado2) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado3) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado6) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado7) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              }
            }
          }
        }

                //RONDA 3---------------------------------------------------------------------------------------------------------
        //ACORDARME DE IMPLEMENTAR ESQUINA ALEATORIA SI USUARIO POR EJEMPLO HACE 2 6-- CPU NO PUEDE AUN HACER 3 EN RAYA

        if (ronda == 3) {
          //comprobamos primero si podemos cortar un 3 en raya
          cortarTresEnRayaCPUO();

          //CPU EMPEZÓ EN EL CENTRO, DEBE BLOQUEAR A USUARIO
          if (cuadrado5 == "assets/images/O.png") {
            if (ocupado1 && ocupado2 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado3 && !haJugadoCPU) {
              cuadrado2 = "assets/images/O.png";
              ocupado2 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado4 && !haJugadoCPU) {
              cuadrado7 = "assets/images/O.png";
              ocupado7 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado6 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado7 && !haJugadoCPU) {
              cuadrado4 = "assets/images/O.png";
              ocupado4 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado8 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado1 && ocupado9 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado3 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado4 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado6 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado8 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado2 && ocupado9 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado4 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado6 && !haJugadoCPU) {
              cuadrado9 = "assets/images/O.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado8 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado3 && ocupado9 && !haJugadoCPU) {
              cuadrado6 = "assets/images/O.png";
              ocupado6 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado6 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado8 && !haJugadoCPU) {
              cuadrado7 = "assets/images/O.png";
              ocupado7 = true;
              haJugadoCPU = true;
            } else if (ocupado4 && ocupado9 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado7 && !haJugadoCPU) {
              cuadrado1 = "assets/images/O.png";
              ocupado1 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado8 && !haJugadoCPU) {
              cuadrado9 = "assets/images/O.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado6 && ocupado9 && !haJugadoCPU) {
              cuadrado3 = "assets/images/O.png";
              ocupado3 = true;
              haJugadoCPU = true;
            } else if (ocupado7 && ocupado8 && !haJugadoCPU) {
              cuadrado9 = "assets/images/O.png";
              ocupado9 = true;
              haJugadoCPU = true;
            } else if (ocupado7 && ocupado9 && !haJugadoCPU) {
              cuadrado8 = "assets/images/O.png";
              ocupado8 = true;
              haJugadoCPU = true;
            }
          }
          //Usuario empezó en centro
          if (cuadrado5 == "assets/images/X.png") {
            //Y CPU EMPEZÓ EN ESQUINA SUPERIOR IZQUIERDA
            if (cuadrado1 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/O.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/O.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/O.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/O.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA SUPERIOR DERECHA
            if (cuadrado3 == "assets/images/O.png" && !haJugadoCPU) {
              //casilla que ocupa el usuario
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/O.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/O.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/O.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/O.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA INFERIOR IZQUIERDA
            if (cuadrado7 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado9 = "assets/images/O.png";
                ocupado9 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado8 = "assets/images/O.png";
                ocupado8 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/O.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/O.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/O.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
            //Y CPU EMPEZÓ EN ESQUINA INFERIOR DERECHA
            if (cuadrado9 == "assets/images/O.png" && !haJugadoCPU) {
              if (ocupado1 && !haJugadoCPU) {
                // 1 y 5
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado2 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              } else if (ocupado3 && !haJugadoCPU) {
                cuadrado7 = "assets/images/O.png";
                ocupado7 = true;
                haJugadoCPU = true;
              } else if (ocupado4 && !haJugadoCPU) {
                cuadrado6 = "assets/images/O.png";
                ocupado6 = true;
                haJugadoCPU = true;
              } else if (ocupado6 && !haJugadoCPU) {
                cuadrado4 = "assets/images/O.png";
                ocupado4 = true;
                haJugadoCPU = true;
              } else if (ocupado7 && !haJugadoCPU) {
                cuadrado3 = "assets/images/O.png";
                ocupado3 = true;
                haJugadoCPU = true;
              } else if (ocupado8 && !haJugadoCPU) {
                cuadrado2 = "assets/images/O.png";
                ocupado2 = true;
                haJugadoCPU = true;
              } else if (ocupado9 && !haJugadoCPU) {
                cuadrado1 = "assets/images/O.png";
                ocupado1 = true;
                haJugadoCPU = true;
              }
            }
          }
        }
        //RONDA 4--------------------------------------------------------------------------------------- EMPEZÓ JUGANDO CPU
//COMPROBAR SI PUEDE HACER 3 EN RAYA Y COMPROBAR CORTAR 3 EN RAYA 24 posibilidades//5a ficha de la partida, 3a de la CPU
        if (ronda == 4) {
          //PRIMERO VA A COMPROBAR SI PUEDE HACER 3 EN RAYA
          puedeTresEnRayaCPUO();

          //CPU TIENE ESQUINAS CONTRARIAS y usuario habrá escogido medio
          if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado1 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }
          //SI USUARIO CORTA A LA CPU
          if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado1 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado3 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado3 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado1 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado7 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado8 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }          //NEW

          else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado8 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado1 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && cuadrado8 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }


        }
        //RONDA 5 HA EMPEZADO JUGANDO EL USUARIO// usuario tiene 3 fichas colocadas y cpu 2-------------------------------------------------------
//se va a colocar 6a pieza de la partida
        if(ronda == 5){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUO();

          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUO();

          if(cuadrado6 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (cuadrado1 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado2 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado8 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado1 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 

            
          }else if (cuadrado1 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true;     
          }else if (cuadrado4 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado1 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true;   
          }else if (cuadrado7 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && cuadrado8 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && cuadrado5 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }

          else if (cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }

          //NEW
            else if (cuadrado5 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }
          else if (cuadrado5 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }




          else if (cuadrado1 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (cuadrado3 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado2 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && cuadrado1 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (cuadrado5 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && cuadrado4 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }
    }
    //RONDA 6 HA EMPEZADO JUGANDO CPU// CPU tiene 3piezas y usuario 3------------------------------------------------------------------------
//se va a colocar 7a pieza de la partida
        if(ronda == 6){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUO();

          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUO();
        }
//RONDA 7 HA EMPEZADO JUGANDO USUARIO// USUARIO tiene 4 fichas y CPU 3------------------------------------------------------------------------
//se va a colocar 8a pieza de la partida
        if(ronda == 7){
          //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUO();
          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUO();

          if(!ocupado4 && !ocupado6  && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(!ocupado2 && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if (!ocupado1 && !ocupado9 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (!ocupado3 && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado1 && !ocupado2 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if (!ocupado2 && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (!ocupado3 && !ocupado6 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if (!ocupado6 && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (!ocupado9 && !ocupado8 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if (!ocupado8 && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado7 && !ocupado4 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if (!ocupado4 && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }
        }
//RONDA 8 HA EMPEZADO CPU // CPU tiene 4 fichas y USUARIO 4------------------------------------------------------------------------
//se va a colocar 9a Y ULTIMA pieza de la partida
        if(ronda == 8){
 //PRIMERO COMPROBAMOS SI PUEDE GANAR DIRECTAMENTE
          puedeTresEnRayaCPUO();
          //Vamos a comprobar si el usuario nos puede hacer 3 en raya y cortarselo
          cortarTresEnRayaCPUO();
          if(!ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(!ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(!ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(!ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(!ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(!ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(!ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(!ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(!ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }
        }
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


//METODOS CPU CUANDO SEA X------------------------------------------------------------------
  //metodo para que la CPU escoja una esquina aleatoria en el tablero
  esquinaAleatoriaCPUX() {
    int esquinaRandom = Random().nextInt(40) + 1;

    //SUPERIOR IZQUIERDA
    if (esquinaRandom <= 10) {
      cuadrado1 = "assets/images/X.png";
      ocupado1 = true;
      primeraEsquina = 1;
      haJugadoCPU = true;
    }
    //SUPERIOR DERECHA
    if (esquinaRandom > 10 && esquinaRandom < 20) {
      cuadrado3 = "assets/images/X.png";
      ocupado3 = true;
      primeraEsquina = 3;
      haJugadoCPU = true;
    }
    //INFERIOR IZQUIERDA
    if (esquinaRandom > 20 && esquinaRandom < 30) {
      cuadrado7 = "assets/images/X.png";
      ocupado7 = true;
      primeraEsquina = 7;
      haJugadoCPU = true;
    }
    //INFERIOR DERECHA
    if (esquinaRandom > 30 && esquinaRandom < 40) {
      cuadrado9 = "assets/images/X.png";
      ocupado9 = true;
      primeraEsquina = 9;
      haJugadoCPU = true;
    }
  }
  puedeTresEnRayaCPUX(){
    if (cuadrado1 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU) {
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true;    
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado8 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado5 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado6 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado9 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }
  }

  cortarTresEnRayaCPUX(){
    if(cuadrado1 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(cuadrado6 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(cuadrado8 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/X.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/X.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/X.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/X.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/X.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/X.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/X.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/X.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/X.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }
  }


//METODOS CPU CUANDO SEA O------------------------------------------------------------------
  esquinaAleatoriaCPUO() {
    int esquinaRandom = Random().nextInt(40) + 1;

    //SUPERIOR IZQUIERDA
    if (esquinaRandom <= 10) {
      cuadrado1 = "assets/images/O.png";
      ocupado1 = true;
      primeraEsquina = 1;
      haJugadoCPU = true;
    }
    //SUPERIOR DERECHA
    if (esquinaRandom > 10 && esquinaRandom < 20) {
      cuadrado3 = "assets/images/O.png";
      ocupado3 = true;
      primeraEsquina = 3;
      haJugadoCPU = true;
    }
    //INFERIOR IZQUIERDA
    if (esquinaRandom > 20 && esquinaRandom < 30) {
      cuadrado7 = "assets/images/O.png";
      ocupado7 = true;
      primeraEsquina = 7;
      haJugadoCPU = true;
    }
    //INFERIOR DERECHA
    if (esquinaRandom > 30 && esquinaRandom < 40) {
      cuadrado9 = "assets/images/O.png";
      ocupado9 = true;
      primeraEsquina = 9;
      haJugadoCPU = true;
    }
  }
    puedeTresEnRayaCPUO(){
    if (cuadrado1 == "assets/images/O.png" && cuadrado2 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU) {
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true;    
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado4 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado5 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado8 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado5 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado6 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado9 == "assets/images/O.png" && cuadrado5 == "assets/images/O.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado3 == "assets/images/O.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/O.png" && cuadrado6 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado7 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true; 
          }else if(cuadrado2 == "assets/images/O.png" && cuadrado8 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true; 
          }else if(cuadrado1 == "assets/images/O.png" && cuadrado9 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }else if(cuadrado3 == "assets/images/O.png" && cuadrado7 == "assets/images/O.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true; 
          }
  }

  cortarTresEnRayaCPUO(){
    if(cuadrado1 == "assets/images/X.png" && cuadrado2 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true; 
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado4 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(cuadrado6 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(cuadrado8 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado3 == "assets/images/X.png" && !ocupado2 && !haJugadoCPU){
            cuadrado2 = "assets/images/O.png";
            ocupado2 = true;
            haJugadoCPU = true;
          }else if(cuadrado4 == "assets/images/X.png" && cuadrado6 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado8 && !haJugadoCPU){
            cuadrado8 = "assets/images/O.png";
            ocupado8 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado4 && !haJugadoCPU){
            cuadrado4 = "assets/images/O.png";
            ocupado4 = true;
            haJugadoCPU = true;
          }else if(cuadrado2 == "assets/images/X.png" && cuadrado8 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado6 && !haJugadoCPU){
            cuadrado6 = "assets/images/O.png";
            ocupado6 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado7 == "assets/images/X.png" && !ocupado5 && !haJugadoCPU){
            cuadrado5 = "assets/images/O.png";
            ocupado5 = true;
            haJugadoCPU = true;
          }else if(cuadrado1 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado9 && !haJugadoCPU){
            cuadrado9 = "assets/images/O.png";
            ocupado9 = true;
            haJugadoCPU = true;
          }else if(cuadrado3 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado7 && !haJugadoCPU){
            cuadrado7 = "assets/images/O.png";
            ocupado7 = true;
            haJugadoCPU = true;
          }else if(cuadrado7 == "assets/images/X.png" && cuadrado5 == "assets/images/X.png" && !ocupado3 && !haJugadoCPU){
            cuadrado3 = "assets/images/O.png";
            ocupado3 = true;
            haJugadoCPU = true;
          }else if(cuadrado5 == "assets/images/X.png" && cuadrado9 == "assets/images/X.png" && !ocupado1 && !haJugadoCPU){
            cuadrado1 = "assets/images/O.png";
            ocupado1 = true;
            haJugadoCPU = true;
          }
  }
}
