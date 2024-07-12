enum Goal {
  lose_weight,
  maintain_weight,
  gain_weight,
}

class CalorieEstimationCalculator {
  final double bmr;
  final double bmi;
  final double currentWeight;
  final double targetWeight;
  final int age;
  final Goal goal;

  CalorieEstimationCalculator({
    required this.bmr,
    required this.bmi,
    required this.currentWeight,
    required this.targetWeight,
    required this.age,
    required this.goal,
  });

  Map<String, dynamic> calculateCaloriesAndTime() {
    final int caloriesToLoseOrGain;
    final double weightDifference = targetWeight - currentWeight;
    int daysToGoal = 0;
    int dailyCalories;

    if (goal == Goal.lose_weight) {
      caloriesToLoseOrGain = -500; // Safe deficit
      daysToGoal =
          ((weightDifference.abs() * 7700) / caloriesToLoseOrGain.abs())
              .ceil(); // 1 kg = 7700 kcal
      dailyCalories = (bmr + caloriesToLoseOrGain).toInt();
      if (dailyCalories < 1200) {
        // Don't go below 1200 kcal/day
        dailyCalories = 1200;
      }
    } else if (goal == Goal.gain_weight) {
      caloriesToLoseOrGain = 500; // Safe surplus
      daysToGoal = ((weightDifference.abs() * 7700) / caloriesToLoseOrGain)
          .ceil(); // 1 kg = 7700 kcal
      dailyCalories = (bmr + caloriesToLoseOrGain).toInt();
      if (dailyCalories > 3500) {
        // Don't go above 3500 kcal/day
        dailyCalories = 3500;
      }
    } else {
      caloriesToLoseOrGain = 0;
      dailyCalories = bmr.toInt();
    }

    return {
      'calories': dailyCalories,
      'timeTaken': daysToGoal,
    };
  }
}

// // Example usage:
// void main() {
//   CalorieEstimationCalculator calculator = CalorieEstimationCalculator(
//     bmr: 1600,
//     bmi: 22,
//     currentWeight: 70,
//     targetWeight: 65,
//     age: 30,
//     goal: Goal.lose_weight,
//   );

//   Map<String, dynamic> result = calculator.calculateCaloriesAndTime();
//   print('Daily Calories: ${result['calories']}');
//   print('Days to Goal: ${result['timeTaken']}');
// }
