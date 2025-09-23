# 🐱 Digital Pet App

A fun and interactive Flutter app where you take care of your virtual pet! Keep your pet happy, fed, and well-rested to win the game.

## 📱 Features

### Pet Care System
- **Happiness Level**: Keep your pet happy by playing with them
- **Hunger Level**: Feed your pet when they get hungry
- **Energy Level**: Make sure your pet gets enough rest

## 🎮 How to Play

1. **Name Your Pet**: Enter a custom name for your virtual companion
2. **Monitor Stats**: Keep an eye on happiness, hunger, and energy levels
3. **Take Action**:
   - 🎮 **Play** to increase happiness (costs energy)
   - 🍽️ **Feed** to reduce hunger (restores some energy)
   - 😴 **Rest** to restore energy (slight happiness boost)
4. **Strategic Care**: Plan your actions - buttons disable when not needed
5. **Win the Game**: Maintain happiness ≥80 for 180 seconds

## 🎯 Game Strategy

- **Balance is Key**: Manage all three stats simultaneously
- **Watch the Clock**: Stats decrease automatically over time
- **Plan Ahead**: Some actions are more efficient at certain times
- **Smart Actions**: Disabled buttons save you from wasting moves

## 🛠️ Technical Details

- **Framework**: Flutter
- **Language**: Dart
- **Platforms**: iOS, Android, Web, Desktop
- **Architecture**: StatefulWidget with real-time updates
- **UI Components**: Custom widgets with responsive design

## 📋 Requirements

- Flutter SDK
- Dart SDK
- Compatible device/emulator

## 🚀 Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/sseid4/real_pet_app.git
   ```

2. **Navigate to project directory**:
   ```bash
   cd real_pet_app
   ```

3. **Install dependencies**:
   ```bash
   flutter pub get
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📁 Project Structure

```
lib/
├── main.dart          # Main app file with all game logic
assets/
├── images/
    └── cat.png        # Pet image asset
```

## 🔄 Game Stats

| Stat | Range | Effects |
|------|-------|---------|
| Happiness | 0-100 | Win condition, affects pet mood color |
| Hunger | 0-100 | Affects happiness, loss condition |
| Energy | 0-100 | Required for playing, restored by rest/food |

## 🏆 Win/Loss Conditions

### 🎉 **Victory**
- Maintain happiness ≥80 for 180 consecutive seconds
- Celebration screen with restart option

### 💀 **Game Over**
- Pet reaches 100 hunger AND ≤10 happiness
- Game over screen with restart option

## 🎭 Pet Moods

- **😄 Extremely Happy** (80-100): Green UI theme
- **😊 Happy** (60-79): Yellow UI theme
- **😐 Neutral** (40-59): Orange UI theme
- **😢 Sad** (20-39): Red UI theme
- **😭 Very Sad** (0-19): Grey UI theme

## 🔧 Customization

The app uses a modular design making it easy to:
- Add new pet types
- Modify stat balance
- Change UI themes
- Add new actions
- Implement save/load features

## 🤝 Contributing

Feel free to fork this project and submit pull requests for improvements!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

**Have fun taking care of your digital pet! 🐾**
