# 🎲 Yahtzee (Single Player)

This is a simplified, single-player version of Yahtzee that I built. In this version, the player can roll the dice up to three times per turn and select a scoring category to end each turn. The game wraps up once all 13 categories on the scorecard have been used.

I’ve kept the gameplay straightforward by leaving out the **“Yahtzee bonus”** rule, so there are no extra points for multiple Yahtzees.

---

## 🧠 Game Behavior & Features

- Displays the most recently rolled dice faces for the current turn  
- Lets the player "hold" selected dice across rolls  
- Tracks which roll number the player is on (1 to 3 per turn)  
- Shows scores already used and updates the scorecard accordingly  
- Lists remaining categories the player can still use  
- Continuously updates the current total score  

---

## ⚙️ Tech Notes

I used **stateful widgets** and **state management techniques** in Flutter to keep track of game progress, dice states, and UI updates.

> ⚠️ The app must build successfully. If the code doesn’t compile, the game won’t run (obviously).
