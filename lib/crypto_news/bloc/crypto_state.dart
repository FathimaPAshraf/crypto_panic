part of 'crypto_bloc.dart';
// defining the states
abstract class CryptoState extends Equatable {
  const CryptoState();
}
//initial loading state
class CryptoLoadingState extends CryptoState {
  @override
  List<Object> get props => [];
}
// loaded state after fetching the data
class CryptoLoadedState extends CryptoState {
  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  CryptoLoadedState(this.count, this.next, this.previous, this.results);

  @override
  
  List<Object?> get props => [count, next, previous, results];
}
