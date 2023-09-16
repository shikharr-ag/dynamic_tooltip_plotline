import 'dart:developer';

import 'failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explanation =
        'Encountered a ValueFailure at an unrecoverable point. Terminating.';
    return Error.safeToString('$explanation Failure was: $valueFailure');
  }
}

class ImageError extends Error {
  final Object er;

  ImageError(this.er);

  @override
  String toString() {
    if (er.toString().contains('SocketException')) {
      return Error.safeToString('There seems to be an internet issue');
    }
    if (er.toString().contains('Invalid argument')) {
      return Error.safeToString('Invalid Image Url.');
    }
    log('Error: ${er.toString()}');
    return Error.safeToString('Some Error Occured. :(');
  }
}
