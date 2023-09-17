import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'failures.freezed.dart';

@freezed
abstract class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.none() = NoError;
  const factory ValueFailure.incompleteForm() = IncompleteForm;
  const factory ValueFailure.empty({
    @required required T failedValue,
  }) = Empty<T>;
  const factory ValueFailure.negativeDouble({
    @required required T failedValue,
  }) = NegativeDouble<T>;
  const factory ValueFailure.invalidColor() = InvalidColor;
  // const factory ValueFailure.numberTooLarge({
  //   @required T failedValue,
  //   @required num max,
  // }) = NumberTooLarge<T>;
  // const factory ValueFailure.listTooLong({
  //   @required T failedValue,
  //   @required int max,
  // }) = ListTooLong<T>;
  // const factory ValueFailure.invalidEmail({
  //   @required T failedValue,
  // }) = InvalidEmail<T>;
  // const factory ValueFailure.shortPassword({
  //   @required T failedValue,
  // }) = ShortPassword<T>;
  const factory ValueFailure.invalidPhotoUrl({
    @required required T failedValue,
  }) = InvalidPhotoUrl<T>;
}
