import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  final TextEditingController _petNameController = TextEditingController();
  Timer? _hungerTimer; // Timer for automatic hunger increase
  Timer? _winTimer;
  bool _gameWon = false;
  bool _gameLost = false;
  int _winCountdown = 180; // 3 minutes = 180 seconds

  @override
  void initState() {
    super.initState();
    _startHungerTimer(); // Start the automatic hunger timer
  }

  // Start the timer for automatic hunger increase
  void _startHungerTimer() {
    _hungerTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      // Changed to 10 seconds for testing
      _automaticHungerIncrease();
    });
  }

  // Automatic hunger increase function
  void _automaticHungerIncrease() {
    setState(() {
      // Increase hunger over time
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
      }

      // Decrease happiness over time
      happinessLevel -= 2;

      // Extra happiness penalty if pet is very hungry
      if (hungerLevel > 70) {
        happinessLevel -= 5;
      }


      if (happinessLevel < 0) happinessLevel = 0;
      if (happinessLevel > 100) happinessLevel = 100;
    });

    // Check win condition - helper function
    _checkWinCondition();

    // Check loss condition - helper function
    _checkLossCondition();
  }

  void _startWinTimer() {
    _winTimer?.cancel();
    _winCountdown = 180;
    _winTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (happinessLevel >= 80 && !_gameWon && !_gameLost) {
          _winCountdown--;
          if (_winCountdown <= 0) {
            _gameWon = true;
            _winTimer?.cancel();
          }
        } else {
          _winTimer?.cancel();
        }
      });
    });
  }

  void _stopWinTimer() {
    _winTimer?.cancel();
    _winCountdown = 180;
  }

  // Check for loss condition
  void _checkLossCondition() {
    if (hungerLevel >= 100 && happinessLevel <= 10 && !_gameWon && !_gameLost) {
      setState(() {
        _gameLost = true;
        _hungerTimer?.cancel(); // Stop all timers
        _winTimer?.cancel();
      });
    }
  }

  // Color changing function based on happiness level
  Color _getPetMoodColor() {
    if (happinessLevel >= 80) {
      return const Color.fromARGB(255, 86, 175, 76);
    } else if (happinessLevel >= 60) {
      return const Color.fromARGB(255, 110, 190, 243);
    } else if (happinessLevel >= 40) {
      return const Color.fromARGB(255, 239, 138, 29);
    } else if (happinessLevel >= 20) {
      return const Color.fromARGB(255, 255, 17, 0);
    } else {
      return Colors.grey;
    }
  }

  // Get text color based on mood
  Color _getTextColor() {
    return _getPetMoodColor().withValues(alpha: 0.8);
  }

  // Get mood text based on happiness level
  String _getPetMoodText() {
    if (happinessLevel >= 80) {
      return "😄 Extremely Happy!";
    } else if (happinessLevel >= 60) {
      return "😊 Happy";
    } else if (happinessLevel >= 40) {
      return "😐 Neutral";
    } else if (happinessLevel >= 20) {
      return "😢 Sad";
    } else {
      return "😭 Very Sad";
    }
  }

  // Helper function to check and manage win timer
  void _checkWinCondition() {
    if (happinessLevel >= 80 && !_gameWon && !_gameLost) {
      if (_winTimer == null || !_winTimer!.isActive) {
        _startWinTimer();
      }
    } else if (happinessLevel < 80) {
      _stopWinTimer();
    }
  }

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      if (happinessLevel > 100) happinessLevel = 100;
      _updateHunger();
      _checkWinCondition();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      if (hungerLevel < 0) hungerLevel = 0;
      _updateHappiness();
      _checkWinCondition();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 50) {
      happinessLevel += 4; // Reward for keeping pet well-fed
    } else {
      happinessLevel += 2; // Small boost for feeding
    }

    if (happinessLevel > 100) happinessLevel = 100;
    if (happinessLevel < 0) happinessLevel = 0;
  }

  @override
  void dispose() {
    _petNameController.dispose();
    _hungerTimer?.cancel();
    _winTimer?.cancel();
    super.dispose();
  }

  void _updatePetName() {
    setState(() {
      if (_petNameController.text.isNotEmpty) {
        petName = _petNameController.text;
        _petNameController.clear(); // Clear the text field after submitting
      }
    });
    // Check win condition after state change
    _checkWinCondition();
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
    });
  }

  // Restart the game
  void _restartGame() {
    setState(() {
      petName = "Your Pet";
      happinessLevel = 50;
      hungerLevel = 50;
      _gameWon = false;
      _gameLost = false;
      _winCountdown = 180;
      _petNameController.clear();
    });

    // Restart timers
    _hungerTimer?.cancel();
    _winTimer?.cancel();
    _startHungerTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Pet name input section
              Container(
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.symmetric(
                  horizontal: 60.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: _getPetMoodColor(), width: 0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _petNameController,
                        decoration: InputDecoration(
                          hintText: "Enter pet name...",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                          ),
                        ),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(width: 4.0),
                    ElevatedButton(
                      onPressed: _updatePetName,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                      ),
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Colors.grey[400]!, width: 2.0),
                ),
                child: Text(
                  _getPetMoodText(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              // Win/Loss status display
              if (_gameWon)
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.green, width: 3.0),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.celebration, size: 50, color: Colors.green),
                      Text(
                        "🎉 YOU WIN! 🎉",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                      Text(
                        "Your pet stayed happy for 3 minutes!",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),

              if (_gameLost)
                Container(
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.red, width: 3.0),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sentiment_very_dissatisfied,
                        size: 50,
                        color: Colors.red,
                      ),
                      Text(
                        "💀 GAME OVER 💀",
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[800],
                        ),
                      ),
                      Text(
                        "Your pet is too hungry and sad!",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ),

              // Win countdown display (only show when close to winning)
              if (happinessLevel >= 80 &&
                  _winCountdown < 180 &&
                  !_gameWon &&
                  !_gameLost)
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.yellow[100],
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.orange, width: 2.0),
                  ),
                  child: Text(
                    "Keep happiness above 80 for ${_winCountdown}s to WIN!",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[800],
                    ),
                  ),
                ),

              // Pet name input section
              SizedBox(height: 16.0),
              // Pet image with circular gradient background
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1,
                    colors: [
                      _getPetMoodColor().withValues(
                        alpha: 0.6,
                      ),
                      _getPetMoodColor().withValues(alpha: 0.3),
                      _getPetMoodColor().withValues(
                        alpha: 0.04,
                      ),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.4, 0.7, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _getPetMoodColor().withValues(alpha: 0.3),
                      spreadRadius: 4,
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Padding(
                    padding: EdgeInsets.all(
                      20.0,
                    ),
                    child: Image.asset(
                      'assets/images/cat.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Name: $petName',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              SizedBox(height: 16.0),
              Text(
                'Happiness Level: $happinessLevel',
                style: TextStyle(fontSize: 20.0, color: _getTextColor()),
              ),
              SizedBox(height: 16.0),
              Text(
                'Hunger Level: $hungerLevel',
                style: TextStyle(fontSize: 20.0, color: _getTextColor()),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: (_gameWon || _gameLost) ? null : _playWithPet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getPetMoodColor(),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text('Play with Your Pet'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: (_gameWon || _gameLost) ? null : _feedPet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getPetMoodColor(),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text('Feed Your Pet'),
              ),

              // Restart button - only show when game is won or lost
              if (_gameWon || _gameLost) SizedBox(height: 16.0),
              if (_gameWon || _gameLost)
                ElevatedButton(
                  onPressed: _restartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: Text('Play Again'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
