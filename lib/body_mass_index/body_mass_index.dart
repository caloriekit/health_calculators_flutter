/// Body Mass Index (BMI) is a simple index of weight-for-height that is commonly used to classify underweight, overweight and obesity in adults.
abstract class BodyMassIndex {
  /// BMI states based on the BMI value
  /// Source : https://www.cdc.gov/healthyweight/assessing/bmi/adult_bmi/index.html
  static final _massIndexToState = {
    18.5: 'Underweight',
    24.9: 'Normal',
    29.9: 'Overweight',
    34.9: 'Moderately Obese',
    39.9: 'Severely Obese',
  };

  /// BMI suggestions based on the BMI value
  static final _massIndexToSuggestion = {
    18.5: 'You are underweight. Consider consulting a doctor.',
    24.9: 'You have a normal body weight. Good job!',
    29.9: 'You are overweight. Losing some weight would be beneficial.',
    34.9: 'You are moderately obese. Exercise and diet are recommended.',
    39.9: 'You are severely obese. You must consider consulting a doctor.',
  };

  static double calculateKiloAndCentimeters({
    required double weight,
    required double height,
  }) {
    return weight / ((height / 100) * (height / 100));
  }

  /// Calculate the Body Mass Index (BMI) WEIGHT in kg and HEIGHT in meters
  /// Formula: BMI = weight / (height * height)
  /// Returns the BMI value as a double
  static double calculateKiloAndMeters({
    required double weight,
    required double height,
  }) {
    return weight / (height * height);
  }

  /// Calculate the Body Mass Index (BMI)
  /// WEIGHT in pounds and HEIGHT in inches
  /// Formula: BMI = (weight / (height * height)) * 703
  /// Returns the BMI value as a double
  static double calculatePoundsAndInches({
    required double weight,
    required double height,
  }) {
    return (weight / (height * height)) * 703;
  }

  /// Returns the state of the BMI based on the BMI value
  /// Returns a string eg 'Underweight', 'Normal', 'Overweight', 'Moderately Obese', 'Severely Obese', 'Dangerously Obese'
  static String getBodyStage(double bmi) {
    for (var key in _massIndexToState.keys) {
      if (bmi <= key) {
        return _massIndexToState[key]!;
      }
    }
    return 'Dangerously Obese';
  }

  /// Returns a suggestion based on the BMI value
  static String getBodySuggestion(double bmi) {
    for (var key in _massIndexToSuggestion.keys) {
      if (bmi <= key) {
        return _massIndexToSuggestion[key]!;
      }
    }
    return 'You are dangerously obese. You should consult a doctor.';
  }
}
