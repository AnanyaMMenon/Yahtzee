import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/dice.dart';
import '../models/scorecard.dart';

class Yahtzee extends StatelessWidget {
  const Yahtzee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yahtzee'),
        centerTitle: true, // Centering title
        backgroundColor: Colors.white,
        elevation: 4, 
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 205, 131, 147), Color.fromARGB(255, 222, 216, 216)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DiceDisplay(),
              const SizedBox(height: 10),
              const RollButton(),
              const SizedBox(height: 10), 
              const ScorecardDisplay(),
              const SizedBox(height: 10), 
              const TotalScoreDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}

class DiceDisplay extends StatelessWidget {
  const DiceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final dice = context.watch<Dice>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final value = dice[index];
        final isHeld = dice.isHeld(index);
        
        return GestureDetector(
          onTap: () => dice.toggleHold(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isHeld ? const Color.fromARGB(255, 0, 57, 100) : const Color.fromARGB(255, 195, 110, 216), 
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isHeld ? 0.2 : 0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), 
                ),
              ],
            ),
            child: Text(
              value?.toString() ?? '-',
              style: const TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        );
      }),
    );
  }
}

class RollButton extends StatelessWidget {
  const RollButton({super.key});

  @override
  Widget build(BuildContext context) {
    final dice = context.watch<Dice>();
    final scoreCard = context.read<ScoreCard>();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), 
      child: ElevatedButton(
        onPressed: (dice.rollCount < 3 && !scoreCard.completed)
            ? () {
                dice.roll();
                if (dice.rollCount >= 3) {
                  _showOutOfRollsDialog(context);
                }
              }
            : null, 
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5A6771),
          foregroundColor: Colors.white, 
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text('Roll Dice (${3 - dice.rollCount} rolls left)', style: const TextStyle(fontSize: 16)),
      ),
    );
  }

  void _showOutOfRollsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Out of Rolls!"),
          content: const Text("You have used all your rolls for this turn."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}

class ScorecardDisplay extends StatelessWidget {
  const ScorecardDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final scoreCard = context.watch<ScoreCard>();

    final leftCategories = [
      ScoreCategory.ones,
      ScoreCategory.twos,
      ScoreCategory.threes,
      ScoreCategory.fours,
      ScoreCategory.fives,
      ScoreCategory.sixes
    ];

    final rightCategories = [
      ScoreCategory.threeOfAKind,
      ScoreCategory.fourOfAKind,
      ScoreCategory.fullHouse,
      ScoreCategory.smallStraight,
      ScoreCategory.largeStraight,
      ScoreCategory.yahtzee,
      ScoreCategory.chance
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            const Text(
              "Scorecard",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: leftCategories.map((category) {
                    return _buildScoreOption(context, category, scoreCard[category]);
                  }).toList(),
                ),
                const SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: rightCategories.map((category) {
                    return _buildScoreOption(context, category, scoreCard[category]);
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }



Widget _buildScoreOption(BuildContext context, ScoreCategory category, int? score) {
  bool isDisabled = score != null; // If score is already assigned, disable selection

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Keep elements aligned
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey : const Color(0xFF5A6771), // Change color when disabled
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            category.name,
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 40, // Fixed width for score column
          child: Center(
            child: Text(
              score != null ? score.toString() : "0", // Show 0 if unassigned
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ),
        SizedBox(
          width: 55, // Increased width to fully fit "Pick"
          child: score == null
              ? TextButton(
                  onPressed: () => _selectScoreCategory(context, category),
                  child: const Text(
                    "Pick",
                    style: TextStyle(color: Colors.blue, fontSize: 16),
                    maxLines: 1, // Ensures "Pick" stays on one line
                    softWrap: false, // Prevents wrapping
                  ),
                )
              : const SizedBox(), // Keep space reserved
        ),
      ],
    ),
  );
}

  void _selectScoreCategory(BuildContext context, ScoreCategory category) {
    final dice = context.read<Dice>();
    final scoreCard = context.read<ScoreCard>();

    try {
      scoreCard.registerScore(category, dice.values);
      dice.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }
}

class TotalScoreDisplay extends StatelessWidget {
  const TotalScoreDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    final totalScore = context.watch<ScoreCard>().total;

    return Padding(
      padding: const EdgeInsets.all(10.0), 
      child: Text(
        'Total Score: $totalScore',
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333), 
        ),
      ),
    );
  }
}
