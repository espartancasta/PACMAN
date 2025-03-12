import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pacman/path.dart';
import 'package:pacman/pixel.dart';
import 'package:pacman/player.dart';
import 'package:pacman/ghost.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  //HomePage que extiende StatefulWidget
  //HomePage:pantalla principal
  //extends: herencia... lo que hace que HomePage se comporte como witged ...
  //....ya que home hereda directamente de StatefulWidget
  //StatefulWidget: tipo de witget que puede cambiar su estado ....
  // ...pero StatelesswWidgeet no puede
  HomePage({super.key});
  // Homepage, nombre de la clase dart
  // el super.key es un contructor que recibe
  // y key es el identificador
  @override
  //override te dice que sobrescribe un método.
  State<HomePage> createState() => _HomePageState();
  //almacena informacion que puede cambiar .....
  //...de mi witged principal que es  HomePage
  //CreateState vincula el widget con su estado  _HomPageState
}

class _HomePageState extends State<HomePage> {
  //definimos la clase privda de HomePageState
  // sucede una herencia con extends de _HomePageState.....
  ///.... ah State<HomePage>
  //
  static int numberInRow = 11;
  // Static es qu un objeto no se mueve
  //int,,, inicizalizamos numberInRow
  // Number in Row son los cuadros de una fila
  // para nuestro laberinto

  int numberOfSquares = numberInRow * 17;
  // init inicializa  Numero de elementos del cuadrado,,,
  // en este caso funciona como columnas aunque no signifca eso
  //lo igualamos a las filas y lo multiplicamos por 17
  // esto nos formaria una seria de cuadros como una libreta

  int player = numberInRow * 2 + 5;
  //int  la posicion del  jugador  que es la ubicacion del cuadro

  static List<int> barriers = [
    // aqui usamos static para hacer una murralla que no se
    //mueva en nuestros cuadros,,,
    // iniciamos una lista
    // y hacemos un camino de barreras
    // la serie de numeros abajo represeta
    // las casillas de los cuadros que son marcadas para
    // como murralas en la serie de cuadros que formamos anteriormente

    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,

    134, 140,

    156,
    129,

    162,
    103,
    114,
    125,
    105,
    116,
    127,

    158,
    160, 155, 157, 159, 161, 163
  ];

  List<int> food = [];
  //iniciamos food
  //la razon por la que List<int> se escribe de esa forma
  // es porque food funciona como una lista de enteros
  String direction = "down";
  //definimos la posicion inicial del jugador hacia la derecha

  bool preGame = true;
  // Indicamos que el juego aún no ha comenzado (estado previo al inicio).

  bool mouthClosed = false;
  // Variable booleana que representa si la boca del personaje está cerrada o no.

  int score = 0;
  // Inicializamos la puntuación en 0.

  int ghost = numberInRow * 5 + 5;
  // Calculamos la posición inicial del fantasma en función del
  //.... número de elementos en una fila.

  Timer? playerTimer;
  // Creamos un temporizador para controlar el movimiento del jugador.

  Timer? ghostTimer;
  // Creamos otro temporizador para manejar el movimiento del fantasma.

  // Cambiamos preGame a falso, indicando
  // que el juego ha comenzado.
  void startGame() {
    // `void`: Indica que esta función devuelve startgame para iniciar

    setState(() {
      // `setState`: Notifica a Flutter que se ha
      //cambiado el estado del juego
      // y que la interfaz debe redibujarse.
      preGame = false;
      // `preGame`: Variable booleana que indica si el juego aún no ha comenzado.

      score = 0;
      // Reiniciamos la puntuación a 0 al iniciar el juego.
      // `score`: Variable que almacena la puntuación del jugador.
      // `0`: Reinicia la puntuación al inicio del juego.
      // `=`: Asigna un valor.

      player = numberInRow * 2 +
          5; // Establecemos la posición inicial del jugador en la cuadrícula.

      // Establecemos la posición inicial del jugador en la cuadrícula.
      // `player`: Representa la posición del jugador en la cuadrícula.
// `=`: Asigna un valor a la variable.
      // `numberInRow * 2 + 5`: Calcula la posición inicial del jugador en el tablero.

      ghost = numberInRow * 5 +
          5; // Definimos la posición inicial del fantasma en la cuadrícula.

      // Definimos la posición inicial del fantasma en la cuadrícula.
// `ghost`: Variable que almacena la posición del fantasma en la cuadrícula.
      // `=`: Asigna un valor.
      // `numberInRow * 5 + 5`: Calcula la posición inicial del fantasma.
    });
    getFood();
    // Llamamos a la función que genera la comida en el juego.

    // Temporizador para mover al jugador
    playerTimer = Timer.periodic(Duration(milliseconds: 177), (timer) {
      // `playerTimer`: Variable que almacena el temporizador del jugador.
      // `=`: Asigna un nuevo valor a la variable.
      // `Timer.periodic`: Crea un temporizador que se ejecuta repetidamente.
      // `Duration(milliseconds: 177)`: Define que se ejecutará cada 177 ms.
      // `(timer) {}`: Bloque de código que se ejecuta en cada intervalo.
      setState(() {
        // `setState`: Notifica que se ha cambiado algo en el juego
        // y la interfaz debe actualizarse.
        if (food.contains(player)) {
          // Si la posición del jugador coincide con una posición de comida

          // `if`: Estructura de control que ejecuta el código dentro de `{}` si la condición es verdadera.
          // `food.contains(player)`: Verifica si la posición del jugador está en la lista de comida.

          food.remove(player);
          // Eliminamos la comida de la lista

          // `food.remove(player)`: Elimina la comida que el jugador ha recogido.

          score++;
          // Aumentamos la puntuación en 1

          // Solo suma si el jugador recoge comida
          // `score++`: Incrementa la puntuación en 1.
        }

        if (player == ghost) {
          // Si el jugador toca al fantasma

          // El jugador ha tocado al fantasma, reiniciar juego
          restartGame(); // Reiniciamos el juego

          // `restartGame()`: Llama a la función que reinicia el juego.
        }

        switch (direction) {
          // `switch`: Estructura de control que evalúa la variable `direction`.

          case "left": // Si la dirección es "izquierda", movemos al jugador a la izquierda

            // `case "left":`: Si la dirección es "left", mueve al jugador a la izquierda.

            moveLeft();
            // `moveLeft()`: Llama a la función que mueve al jugador a la izquierda.

            break;
          // `break`: Finaliza el caso y evita que se ejecuten otros casos.

          case "right":
            moveRight();
            break;
          case "up":
            moveUp();
            break;
          case "down":
            moveDown();
            break;
        }
      });
    });

    // Temporizador para mover al fantasma con menor velocidad
    ghostTimer = Timer.periodic(Duration(milliseconds: 777), (timer) {
      // `ghostTimer`: Variable que almacena el temporizador del fantasma.
      // `=`: Asigna un nuevo valor a la variable.
      // `Timer.periodic`: Crea un temporizador que se ejecuta repetidamente.
      // `Duration(milliseconds: 300)`: Define que se ejecutará cada 300 ms.

      setState(() {
        //actualiza pantalla
        // Movemos al fantasma en cada ejecución del temporizador

        moveGhost(); // El fantasma se mueve hacia el jugador
      });
    });
  }
  // Cambiamos preGame a falso, indicando que el juego ha comenzado.

  void restartGame() {
    // `void restartGame()`: Declara una función que reinicia el juego.

    setState(() {
      // `setState`: Indica que hay cambios en el estado del juego.

      preGame = true;
      // Volvemos a poner el estado en preGame, indicando que el juego ha terminado.

      // `preGame = true;`: Indica que el juego vuelve al estado inicial (antes de comenzar).

      score = 0;
      // Reiniciamos la puntuación a 0.

      // `score = 0;`: Reinicia la puntuación del jugador.

      player = numberInRow * 2 +
          5; // Establecemos la posición inicial del jugador en la cuadrícula.

      // `player = numberInRow * 2 + 5;`: Restaura la posición inicial del jugador.
      // Restauramos la posición inicial del fantasma.

      ghost = numberInRow * 5 +
          5; // Definimos la posición inicial del fantasma en la cuadrícula.

      // `ghost = numberInRow * 5 + 5;`: Restaura la posición inicial del fantasma.

      food.clear(); // Limpiar comida
      // `food.clear();`: Elimina toda la comida del tablero.
      // Eliminamos toda la comida del tablero.
    });

    // Detener los timers cuando se reinicia el juego
    playerTimer?.cancel();
    // `playerTimer?.cancel();`: Detiene el temporizador del jugador si está activo.
    // `playerTimer?`: Usa el operador `?` para evitar errores si el temporizador es `null`.
    // `.cancel();`: Llama al método `cancel()` para detener el temporizador.
    ghostTimer?.cancel();
    // `ghostTimer?.cancel();`: Detiene el temporizador del fantasma si está activo.
    // `ghostTimer?`: Usa `?` para verificar si `ghostTimer` no es `null` antes de cancelarlo.
  }

  void getFood() {
    // `void getFood()`: Declara una función que genera comida en el tablero.

    for (int i = 0; i < numberOfSquares; i++) {
      // `for (int i = 0; i < numberOfSquares; i++)`:
      // Bucle que recorre todas las posiciones del tablero.
      // `int i = 0;`: Inicializa `i` en 0.
      // `i < numberOfSquares;`: Se ejecuta mientras `i` sea menor que el total de casillas.
      // `i++`: Incrementa `i` en 1 en cada iteración.
      if (!barriers.contains(i)) {
        // `if (!barriers.contains(i))`: Verifica si la posición `i` no es una barrera.
        // `barriers.contains(i)`: Comprueba si `i` está en la lista de barreras.
        // `!`: Negación lógica, significa "si `i` no es una barrera".

        food.add(i);
        // `food.add(i);`: Agrega la posición `i` a la lista de comida.
      }
    }
  }

  void moveLeft() {
    // `void moveLeft()`: Declara la función que mueve al jugador a la izquierda.

    if (!barriers.contains(player - 1)) {
      // `if (!barriers.contains(player - 1))`:
      // Verifica si la posición a la izquierda del jugador no es una barrera.
      // `player - 1`: Calcula la posición a la izquierda del jugador.
      // `barriers.contains(player - 1)`: Comprueba si esa posición es una barrera.
      // `!`: Negación lógica, significa "si esa posición no es una barrera".

      setState(() {
        player--;
        // `player--;`: Reduce en 1 la posición del jugador, moviéndolo a la izquierda.
      });
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  void moveGhost() {
    // `dx`: Diferencia en la posición horizontal entre el jugador y el fantasma
    // El operador `%` se usa para obtener la columna en la que se encuentran
    // Calcula cuántas columnas hay de diferencia entre el jugador y el fantasma.
    int dx = (player % numberInRow) - (ghost % numberInRow);

    // `dy`: Diferencia en la posición vertical entre el jugador y el fantasma
    // El operador `~/` realiza una división entera, para obtener la fila en la que se encuentran.
    // Calcula cuántas filas hay de diferencia entre el jugador y el fantasma.
    int dy = (player ~/ numberInRow) - (ghost ~/ numberInRow);

    // Movimiento diagonal: si hay diferencias tanto en `dx` como en `dy`, mover en ambas direcciones

    // Si el jugador está a la derecha y abajo del fantasma, mover hacia la derecha y hacia abajo
    if (dx > 0 && dy > 0) {
      setState(() {
        ghost++; // Mueve el fantasma una casilla a la derecha (dx > 0)
        ghost +=
            numberInRow; // Mueve el fantasma una casilla hacia abajo (dy > 0)
      });
    }
    // Si el jugador está a la derecha y arriba del fantasma, mover hacia la derecha y hacia arriba
    else if (dx > 0 && dy < 0) {
      setState(() {
        ghost++; // Mueve el fantasma una casilla a la derecha (dx > 0)
        ghost -=
            numberInRow; // Mueve el fantasma una casilla hacia arriba (dy < 0)
      });
    }
    // Si el jugador está a la izquierda y abajo del fantasma, mover hacia la izquierda y hacia abajo
    else if (dx < 0 && dy > 0) {
      setState(() {
        ghost--; // Mueve el fantasma una casilla a la izquierda (dx < 0)
        ghost +=
            numberInRow; // Mueve el fantasma una casilla hacia abajo (dy > 0)
      });
    }
    // Si el jugador está a la izquierda y arriba del fantasma, mover hacia la izquierda y hacia arriba
    else if (dx < 0 && dy < 0) {
      setState(() {
        ghost--; // Mueve el fantasma una casilla a la izquierda (dx < 0)
        ghost -=
            numberInRow; // Mueve el fantasma una casilla hacia arriba (dy < 0)
      });
    }

    // Movimiento solo horizontal, si no hay movimiento vertical
    // Si el jugador está a la derecha del fantasma, mover solo hacia la derecha
    else if (dx > 0) {
      setState(() {
        ghost++; // Mueve el fantasma una casilla a la derecha
      });
    }
    // Si el jugador está a la izquierda del fantasma, mover solo hacia la izquierda
    else if (dx < 0) {
      setState(() {
        ghost--; // Mueve el fantasma una casilla a la izquierda
      });
    }

    // Movimiento solo vertical, si no hay movimiento horizontal
    // Si el jugador está abajo del fantasma, mover solo hacia abajo
    else if (dy > 0) {
      setState(() {
        ghost += numberInRow; // Mueve el fantasma una casilla hacia abajo
      });
    }
    // Si el jugador está arriba del fantasma, mover solo hacia arriba
    else if (dy < 0) {
      setState(() {
        ghost -= numberInRow; // Mueve el fantasma una casilla hacia arriba
      });
    }
  }

  @override
  // `@override`: Indica que esta función está sobrescribiendo el método `build()`
  // de la clase `StatefulWidget`. Es necesario en Flutter para actualizar la UI.

  Widget build(BuildContext context) {
    return Scaffold(
      // `Scaffold`: Proporciona la estructura básica de la pantalla,
      // incluyendo fondo, barras de navegación, y cuerpo principal.

      backgroundColor: Colors.black, // Fondo negro para la interfaz del juego.
      // `backgroundColor: Colors.black`: Establece el color de fondo en negro.

      body: Column(
        // `Column`: Organiza los elementos en una columna vertical.

        children: [
          Expanded(
            flex: 24, // Sección principal del juego.

            // `Expanded(flex: 24)`: Hace que esta sección ocupe 24 partes del espacio disponible.
            // Detecta los gestos del usuario para mover al jugador.

            child: GestureDetector(
              // `GestureDetector`: Detecta gestos del usuario, como deslizamientos.

              onVerticalDragUpdate: (details) {
                // `onVerticalDragUpdate`: Detecta deslizamientos verticales.

                if (details.delta.dy > 0) {
                  // `details.delta.dy > 0`: Si el usuario desliza hacia abajo.

                  direction =
                      "down"; // Deslizar hacia abajo mueve al jugador hacia abajo.
                } else if (details.delta.dy < 0) {
                  // `details.delta.dy < 0`: Si el usuario desliza hacia arriba.

                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                // `onHorizontalDragUpdate`: Detecta deslizamientos horizontales.

                if (details.delta.dx > 0) {
                  // `details.delta.dx > 0`: Si el usuario desliza a la derecha.

                  direction = "right"; // Cambia la dirección a "derecha".
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                // `Container()`: Contenedor visual para organizar elementos.

                child: GridView.builder(
                  // `GridView.builder`: Crea una cuadrícula de elementos dinámicamente.

                  physics:
                      const NeverScrollableScrollPhysics(), // Evita el desplazamiento de la cuadrícula.
                  // `NeverScrollableScrollPhysics()`: Desactiva el desplazamiento en la cuadrícula.

                  itemCount: numberOfSquares,
                  // `itemCount`: Define cuántos elementos habrá en la cuadrícula.
// Número total de celdas en el tablero.
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // `SliverGridDelegateWithFixedCrossAxisCount`: Define el diseño de la cuadrícula.

                    crossAxisCount: numberInRow,
                    // `crossAxisCount`: Define cuántas columnas tendrá la cuadrícula.
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    // `itemBuilder`: Función que construye cada celda de la cuadrícula.

                    if (player == index) {
                      // `if (player == index)`: Si la celda actual es la del jugador.

                      switch (direction) {
                        case "left":
                          return Transform.rotate(angle: pi, child: MyPlayer());
                        // `Transform.rotate(angle: pi)`: Rota el jugador 180° para que mire a la izquierda.

                        case "right":
                          return MyPlayer();
                        // `MyPlayer()`: Renderiza al jugador mirando a la derecha (posición por defecto).

                        case "up":
                          return Transform.rotate(
                              angle: pi / 2, child: MyPlayer());
                        // `angle: pi / 2`: Rota el jugador 90° para que mire hacia arriba.

                        case "down":
                          return Transform.rotate(
                              angle: 3 * pi / 2, child: MyPlayer());
                        // `angle: 3 * pi / 2`: Rota el jugador 270° para que mire hacia abajo.
                      }
                      return MyPlayer();
                      // Si el índice actual en la cuadrícula es la posición del jugador,
// se muestra el widget `MyPlayer()`, representando al jugador en pantalla.
                    } else if (ghost == index) {
                      // Si el índice actual en la cuadrícula es la posición del fantasma.

                      // Mostrar el fantasma en la posición correspondiente
                      return MyGhost();
                      // Se muestra el widget `MyGhost()`, representando al fantasma en pantalla.
                    } else if (barriers.contains(index)) {
                      // Si el índice actual está dentro de la lista `barriers` (paredes del laberinto).

                      return MyPixel(
                        innerColor: const Color.fromARGB(255, 35, 68, 95),
                        outerColor: Colors.blue,
                        // Se muestra un `MyPixel`, que representa una pared en el juego.
                        // Su color interior es azul oscuro y su borde es azul claro.
                      );
                    } else if (food.contains(index)) {
                      // Si el índice actual está dentro de la lista `food` (posiciones con comida).

                      return MyPath(
                        innerColor: Colors.yellow,
                        outerColor: Colors.black,
                        // Se muestra `MyPath`, un elemento amarillo que representa la comida.
                      );
                    } else {
                      return MyPath(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                        // Se muestra un `MyPath` completamente negro,
                        // representando un espacio vacío.
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // `Expanded`: Expande este contenedor para
              // ocupar todo el espacio disponible.

              child: Row(
                // `Row`: Organiza los elementos en una fila horizontal.

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // `mainAxisAlignment: SpaceEvenly`: Distribuye los elementos uniformemente en la fila.

                children: [
                  Text(
                    "Score: " + score.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 40),
                    // Muestra el puntaje del jugador en pantalla.
                    // Texto en color blanco con un tamaño de fuente de 40.
                  ),
                  GestureDetector(
                    // `GestureDetector`: Permite detectar toques sobre el texto "PLAY".

                    onTap: startGame,

                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 40),
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
