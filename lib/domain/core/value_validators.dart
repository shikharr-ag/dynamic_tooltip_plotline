import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'failures.dart';

Either<ValueFailure<String>, String> validateMaxStringLength(
  String input,
  int maxLength,
) {
  if (input.length <= maxLength) {
    return right(input);
  } else {
    return left(ValueFailure.exceedingLength(
      failedValue: input,
      max: maxLength,
    ));
  }
}

Either<ValueFailure<String>, String> validateStringNotEmpty(String input) {
  if (input.isEmpty) {
    return left(ValueFailure.empty(failedValue: input));
  } else {
    return right(input);
  }
}

Either<ValueFailure<double>, double> validateMyDouble(String input) {
  try {
    double d = double.parse(input);
    if (d < 0) {
      return left(ValueFailure.negativeDouble(failedValue: d));
    } else {
      return right(d);
    }
  } catch (_) {
    return left(ValueFailure.negativeDouble(failedValue: -1));
  }
}

Either<ValueFailure<int>, int> validateMyColor(Color? input) {
  if (input == null) {
    return left(ValueFailure.invalidColor());
  } else {
    return right(input.value);
  }
}

// Either<ValueFailure<String>, String> validateSingleLine(String input) {
//   if (input.contains('\n')) {
//     return left(ValueFailure.multiline(failedValue: input));
//   } else {
//     return right(input);
//   }
// }

// Either<ValueFailure<KtList<T>>, KtList<T>> validateMaxListLength<T>(
//     KtList<T> input, int maxLength) {
//   if (input.size <= maxLength) {
//     return right(input);
//   } else {
//     return left(ValueFailure.listTooLong(
//       failedValue: input,
//       max: maxLength,
//     ));
//   }
// }

// Either<ValueFailure<String>, String> validateEmailAddress(String input) {
//   // Maybe not the most robust way of email validation but it's good enough
//   const emailRegex =
//       r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
//   if (RegExp(emailRegex).hasMatch(input)) {
//     return right(input);
//   } else {
//     return left(ValueFailure.invalidEmail(failedValue: input));
//   }
// }

// Either<ValueFailure<String>, String> validatePassword(String input) {
//   // You can also add some advanced password checks (uppercase/lowercase, at least 1 number, ...)
//   if (input.length >= 6) {
//     return right(input);
//   } else {
//     return left(ValueFailure.shortPassword(failedValue: input));
//   }
