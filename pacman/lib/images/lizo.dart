import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pacman/path.dart';
import 'package:pacman/pixel.dart';
import 'package:pacman/player.dart';
import 'package:pacman/ghost.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  //override te dice que sobrescribe un método.
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 2 + 5;
  static List<int> barriers = [
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
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160
  ];

  List<int> food = [];
  String direction = "left";
  bool preGame = true;
  bool mouthClosed = false;
  int score = 0;
  int ghost = numberInRow * 5 + 5;
  Timer? playerTimer;
  Timer? ghostTimer;

  void startGame() {
    setState(() {
      preGame = false;
      score = 0;
      player = numberInRow * 2 + 5;
      ghost = numberInRow * 5 + 5;
    });
    getFood();

    playerTimer = Timer.periodic(Duration(milliseconds: 177), (timer) {
      setState(() {
        if (food.contains(player)) {
          food.remove(player);
          score++;
        }

        if (player == ghost) {
          restartGame();
        }

        switch (direction) {
          case "left":
            moveLeft();
            break;
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

    ghostTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      setState(() {
        moveGhost();
      });
    });
  }

  void restartGame() {
    setState(() {
      preGame = true;
      score = 0;
      player = numberInRow * 2 + 5;
      ghost = numberInRow * 5 + 5;
      food.clear();
    });

    playerTimer?.cancel();
    ghostTimer?.cancel();
  }

  void getFood() {
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
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
    int dx = (player % numberInRow) - (ghost % numberInRow);
    int dy = (player ~/ numberInRow) - (ghost ~/ numberInRow);

    if (dx.abs() > dy.abs()) {
      if (dx > 0 && !barriers.contains(ghost + 1)) {
        setState(() {
          ghost++;
        });
      } else if (dx < 0 && !barriers.contains(ghost - 1)) {
        setState(() {
          ghost--;
        });
      } else {
        if (dy > 0 && !barriers.contains(ghost + numberInRow)) {
          setState(() {
            ghost += numberInRow;
          });
        } else if (dy < 0 && !barriers.contains(ghost - numberInRow)) {
          setState(() {
            ghost -= numberInRow;
          });
        }
      }
    } else {
      if (dy > 0 && !barriers.contains(ghost + numberInRow)) {
        setState(() {
          ghost += numberInRow;
        });
      } else if (dy < 0 && !barriers.contains(ghost - numberInRow)) {
        setState(() {
          ghost -= numberInRow;
        });
      } else {
        if (dx > 0 && !barriers.contains(ghost + 1)) {
          setState(() {
            ghost++;
          });
        } else if (dx < 0 && !barriers.contains(ghost - 1)) {
          setState(() {
            ghost--;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 24,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: Container(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (player == index) {
                      switch (direction) {
                        case "left":
                          return Transform.rotate(angle: pi, child: MyPlayer());
                        case "right":
                          return MyPlayer();
                        case "up":
                          return Transform.rotate(
                              angle: pi / 2, child: MyPlayer());
                        case "down":
                          return Transform.rotate(
                              angle: 3 * pi / 2, child: MyPlayer());
                      }
                      return MyPlayer();
                    } else if (ghost == index) {
                      return MyGhost();
                    } else if (barriers.contains(index)) {
                      return MyPixel(
                        innerColor: const Color.fromARGB(255, 35, 68, 95),
                        outerColor: Colors.blue,
                      );
                    } else if (food.contains(index)) {
                      return MyPath(
                        innerColor: Colors.yellow,
                        outerColor: Colors.black,
                      );
                    } else {
                      return MyPath(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score: " + score.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  GestureDetector(
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
