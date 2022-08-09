import 'package:bloc/bloc.dart';
import 'package:cryptoo/crypto_news/model/crypto.dart';
import 'package:cryptoo/crypto_news/repository/crypto_services.dart';
import 'package:equatable/equatable.dart';


part 'crypto_event.dart';
part 'crypto_state.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoService _cryptoService;

  CryptoBloc(this._cryptoService) : super(CryptoLoadingState()) {
    on<LoadApiEvent>(
      (event, emit) async {
        //calls api function getCryptoNews to fetch data
        final cryptoNews = await _cryptoService.getCryptoNews();
        emit(CryptoLoadedState(cryptoNews.count, cryptoNews.next,
            cryptoNews.previous, cryptoNews.results));
      },
    );
  }
}
