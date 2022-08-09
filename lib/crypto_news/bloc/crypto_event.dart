part of 'crypto_bloc.dart';

abstract class CryptoEvent extends Equatable {
  const CryptoEvent();
}
// loads to fetch data from api
class LoadApiEvent extends CryptoEvent {
  @override
  List<Object?> get props => [];
}
