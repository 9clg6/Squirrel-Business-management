import 'package:squirrel/foundation/localizations/localizations.dart';

/// Extension on [DateTime]
extension DateTimeExtension on DateTime {
  /// To dd/mm/yyyy
  /// @return [String] dd/mm/yyyy
  ///
  String toDDMMYYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Get date without time
  /// @return [DateTime] date without time
  ///
  DateTime getDateWithoutTime() {
    return DateTime(year, month, day);
  }
}
