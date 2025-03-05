# MP Report

## Team

- Name: Ananya Menon
- AID: A20538657

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all
      that apply):
  - [ ] iOS simulator / MacOS
  - [X] Android emulator
  - [X] Google Chrome
- [X] The dice rolling mechanism works correctly
- [X] The scorecard works correctly
- [X] Scores are correctly calculated for all categories
- [X] The game end condition is correctly implemented, and the final score is
      correctly displayed
- [X] The game state is reset when the user dismisses the final score
- [X] The implementation separates layout from data, involving the use of data
      model classes separate from custom widgets

## Summary and Reflection

In this project, I focused on ensuring a consistent and stable UI for the scorecard, preventing layout shifts when scores were selected. I implemented fixed-width containers for score values and buttons to maintain alignment and avoid movement. Additionally, I addressed text overflow issues, ensuring the "Pick" button remained fully visible without truncation.

One challenge I encountered was handling dynamic UI updates while preserving layout stability, especially when toggling between selectable and assigned scores. I enjoyed refining the visual consistency and learning how to manage text constraints effectively in Flutter. If I had more time, I would have optimized the UI responsiveness further and explored additional animations to improve the user experience.
