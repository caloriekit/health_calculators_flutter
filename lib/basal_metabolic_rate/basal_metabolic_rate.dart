import 'package:health_calculators/health_calculators.dart';

enum Ethnicity {
  white,
  black,
  asian,
  hispanic,
  other,
}

abstract class BasalMetabolicRate {
  Future<double> calculateBMR({
    required double weight,
    required double height,
    required int age,
    required bool isMale,
    required double bodyFatPercentage,
    Ethnicity ethnicity = Ethnicity.white,
  });
}

class BMRCalculator extends BasalMetabolicRate {

  @override
  Future<double> calculateBMR({
    required double weight,
    required double height,
    required int age,
    required bool isMale,
    required double bodyFatPercentage,
    Ethnicity ethnicity = Ethnicity.white,
  }) async {
    // Validate inputs
    if (weight <= 0 ||
        height <= 0 ||
        age <= 0 ||
        bodyFatPercentage < 0 ||
        bodyFatPercentage > 100) {
      throw ArgumentError("Invalid input values.");
    }

    double bmi =
        BodyMassIndex.calculateKiloAndMeters(weight: weight, height: height);
    double fatFreeMass = weight * (1 - bodyFatPercentage / 100);

    if (age >= 60) {
      return _calculateCunningham(fatFreeMass);
    }

    double bmr = _calculateMifflinStJeor(weight, height, age, isMale);

    switch (ethnicity) {
      case Ethnicity.black:
        bmr = _calculateOwen(weight, isMale);
        break;
      case Ethnicity.asian:
        bmr = _calculateHenry(weight, height, age, isMale);
        break;
      case Ethnicity.hispanic:
        bmr *= 1.05; // Simple adjustment factor
        break;
      case Ethnicity.white:
      case Ethnicity.other:
      default:
        break;
    }

    if (bmi < 18.5) {
      bmr = _calculateOwen(weight, isMale);
    } else if (bmi >= 30) {
      bmr = _calculateMuller(weight, height, age, isMale);
    }

    return Future.value(bmr);
  }

  double _calculateCunningham(double fatFreeMass) {
    return 500 + 22 * fatFreeMass;
  }

  double _calculateMifflinStJeor(
      double weight, double height, int age, bool isMale) {
    if (isMale) {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double _calculateOwen(double weight, bool isMale) {
    if (isMale) {
      return 879 + 10.2 * weight;
    } else {
      return 795 + 7.18 * weight;
    }
  }

  double _calculateHenry(double weight, double height, int age, bool isMale) {
    if (isMale) {
      return 66.47 + 13.75 * weight + 5.003 * height - 6.75 * age;
    } else {
      return 655.1 + 9.563 * weight + 1.850 * height - 4.676 * age;
    }
  }

  double _calculateMuller(double weight, double height, int age, bool isMale) {
    if (isMale) {
      return 864 - 9.72 * age + 14.2 * weight + 503 * (height / 100);
    } else {
      return 387 - 7.31 * age + 10.9 * weight + 660 * (height / 100);
    }
  }
  
}
