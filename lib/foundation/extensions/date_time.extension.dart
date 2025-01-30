import 'package:init/foundation/localizations/localizations.dart';

extension DateTimeExtension on DateTime {
  String toDDMMYYYY() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}
