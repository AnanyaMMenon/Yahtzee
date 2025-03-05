import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/dice.dart';
import 'models/scorecard.dart';
import 'views/yahtzee.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Dice(5)),
        ChangeNotifierProvider(create: (_) => ScoreCard()),
      ],
      child: const MaterialApp(
        title: 'Yahtzee',
        home: Scaffold(
        body: Yahtzee(),
      ),
    ),
    )
  );
}

