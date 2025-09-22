import 'package:flutter/material.dart';

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

  // Color changing function based on happiness level
  Color _getPetMoodColor() {
    if (happinessLevel >= 80) {
      return const Color.fromARGB(255, 86, 175, 76); // Very happy - green
    } else if (happinessLevel >= 60) {
      return Colors.blue; // Happy - blue
    } else if (happinessLevel >= 40) {
      return Colors.orange; // Neutral - orange
    } else if (happinessLevel >= 20) {
      return Colors.red; // Sad - red
    } else {
      return Colors.grey; // Very sad - grey
    }
  }

  // Get text color based on mood
  Color _getTextColor() {
    return _getPetMoodColor().withOpacity(0.8);
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

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      if (happinessLevel > 100) happinessLevel = 100;
      _updateHunger();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      if (hungerLevel < 0) hungerLevel = 0;
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
    if (happinessLevel > 100) happinessLevel = 100;
    if (happinessLevel < 0) happinessLevel = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
        backgroundColor: _getPetMoodColor(),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white, // Remove colored background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Pet mood indicator
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: _getPetMoodColor().withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _getPetMoodColor(), width: 2.0),
              ),
              child: Text(
                _getPetMoodText(),
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(),
                ),
              ),
            ),
            Image.asset(
              'assets/images/cat.webp',
              width: 200,
              height: 200,
              color: Colors.transparent,
              colorBlendMode: BlendMode.multiply,
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0, color: _getTextColor()),
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
              onPressed: _playWithPet,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getPetMoodColor(),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getPetMoodColor(),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
