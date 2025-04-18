# 🎯 Flutter Custom SpinWheel

A fully custom **Spin Wheel** built in Flutter using `CustomPainter` – no external packages, just pure Dart and creativity!  
Perfect for mini-games, lucky draws, quizzes, and other interactive UI elements.

![Spin Wheel Demo](https://github.com/itsdevzam/flutter-custom-spinwheel/blob/main/assets/spin.png)

## 🚀 Features

- Draws arcs dynamically with `Canvas` & `Paint`
- Built using Flutter's `CustomPainter` class
- Interactive Spin button with random stop logic
- Displays selected color from the wheel
- Clean and minimal UI


## 🛠️ How It Works

- The wheel is divided into colored sectors using `drawArc`
- A pointer is painted at the center using `Path`
- On tapping "Spin Now", a random angle is calculated and animated
- On stop, the selected sector's color is shown

## 📦 Getting Started

Clone the repository and run the app:

```bash
git clone https://github.com/itsdevzam/flutter-custom-spinwheel.git
cd flutter-custom-spinwheel
flutter run
