import '../../domain/core/failures.dart';

class Helper {
  static List<String> getSubstrings(String s) {
    return s.split('_');
  }

  static String getErrorMessage(ValueFailure f) {
    return f.map(
        none: (_) => '',
        exceedingLength: (_) => 'String is exceeding max length.',
        empty: (_) => 'Empty Textfield',
        negativeDouble: (_) => 'Invalid Numeric Value Entered.',
        invalidPhotoUrl: (_) => '',
        invalidColor: (_) => 'Invalid Color selected.');
  }
}
