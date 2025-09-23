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
  TextEditingController _petNameController = TextEditingController();

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

  @override
  void dispose() {
    _petNameController.dispose();
    super.dispose();
  }

  void _updatePetName() {
    setState(() {
      if (_petNameController.text.isNotEmpty) {
        petName = _petNameController.text;
        _petNameController.clear(); // Clear the text field after submitting
      }
    });
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
        backgroundColor: Colors.blue[700],
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
            // Pet name input section
            Container(
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: _getPetMoodColor(), width: 1.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _petNameController,
                      decoration: InputDecoration(
                        hintText: "Enter pet name...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12.0),
                      ),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _updatePetName,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                    ),
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Pet image with circular gradient background
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle, // Makes it perfectly round
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    _getPetMoodColor().withOpacity(0.6), // Center - more opaque
                    _getPetMoodColor().withOpacity(0.3), // Middle
                    _getPetMoodColor().withOpacity(
                      0.1,
                    ), // Edge - more transparent
                    Colors.transparent, // Completely transparent at edge
                  ],
                  stops: [0.0, 0.4, 0.7, 1.0], // Gradient positions
                ),
                boxShadow: [
                  BoxShadow(
                    color: _getPetMoodColor().withOpacity(0.3),
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ClipOval(
                // Clips image to circular shape
                child: Padding(
                  padding: EdgeInsets.all(20.0), // Space between image and edge
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
