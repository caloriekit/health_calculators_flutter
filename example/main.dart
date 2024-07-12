import 'package:health_calculators/calorie_intake/calorie_intake.dart';

void main() {
  CalorieEstimationCalculator calculator = CalorieEstimationCalculator(
    bmr: 1600,
    bmi: 22,
    currentWeight: 70,
    targetWeight: 65,
    age: 30,
    goal: Goal.lose_weight,
  );

  Map<String, dynamic> result = calculator.calculateCaloriesAndTime();
  print('Daily Calories: ${result['dailyCalories']}');
  print('Days to Goal: ${result['daysToGoal']}');
}
