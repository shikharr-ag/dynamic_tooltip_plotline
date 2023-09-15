import 'dart:ui';

import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../core/value_object.dart';
import '../core/value_validators.dart';

class MyColor extends ValueObject<int> {
  @override
  final Either<ValueFailure<int>, int> value;

  factory MyColor(Color? input) {
    return MyColor._(
      validateMyColor(input),
    );
  }

  int getVal(Color col) {
    return col.value;
  }

  Color fromValue(int val) {
    return Color(val);
  }

  const MyColor._(this.value);
}
