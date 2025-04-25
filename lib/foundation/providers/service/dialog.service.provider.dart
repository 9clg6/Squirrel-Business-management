import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:squirrel/domain/service/dialog.service.dart';

part 'dialog.service.provider.g.dart';

/// Dialog service provider
/// return [DialogService] dialog service
///
@riverpod
DialogService dialogService(_) => DialogService();
