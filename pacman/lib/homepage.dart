import 'package:flutter/material.dart';
import 'package:pacman/pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  final int numberOfSquares = numberInRow * 17;
  List<int> barries = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: numberOfSquares,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberInRow,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (barries.contains(index)) {
                  MyPixel()
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      color: Colors.grey,
                      child: Center(
                        child: Text(index.toString()),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Score:",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
                Text(
                  "P L A Y",
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
