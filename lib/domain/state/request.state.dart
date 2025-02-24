import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:squirrel/domain/entities/request.entity.dart';

part 'request.state.g.dart';

/// [RequestState]
@CopyWith()
class RequestState with EquatableMixin {
  /// Is request show
  final bool isRequestShow;

  /// Requests
  final List<Request> requests;

  /// Constructor
  /// @param isRequestShow
  ///
  RequestState({
    required this.isRequestShow,
    required this.requests,
  });

  /// Props
  @override
  List<Object?> get props => [
        isRequestShow,
        requests,
      ];

  /// Initial state
  ///
  factory RequestState.initial() {
    return RequestState(
      isRequestShow: false,
      requests: [],
    );
  }
}
