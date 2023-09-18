import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_object.dart';
import '../core/value_validators.dart';

class MyDouble extends ValueObject<double> {
  @override
  final Either<ValueFailure<double>, double> value;

  factory MyDouble(String input) {
    return MyDouble._(
      validateMyDouble(input),
    );
  }

  static String getPrecisionDouble(String s) {
    try {
      double? x = double.tryParse(s);
      return x!.toStringAsFixed(0);
    } catch (er) {
      return '';
    }
  }

  const MyDouble._(this.value);
}
