// ignore_for_file: one_member_abstracts, public_member_api_docs yess

abstract interface class BaseUseCase<R> {
  R execute();
}

/// Abstract interface for base use case with params
abstract interface class BaseUseCaseWithParams<R, P> {
  R execute(P params);
}
