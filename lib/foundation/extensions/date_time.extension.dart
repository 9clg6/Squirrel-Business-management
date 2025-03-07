import 'package:squirrel/foundation/localizations/localizations.dart';

extension DateTimeExtension on DateTime {
  String toDDMMYYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  DateTime getDateWithoutTime() {
    return DateTime(year, month, day);
  }
}
