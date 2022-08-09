import 'package:cryptoo/crypto_news/model/crypto.dart';
import 'package:http/http.dart';

class CryptoService {
   String url =
      "https://cryptopanic.com/api/v1/posts/?auth_token=d7678ae8edf6712690c242070f4a600cbde6e97d&public=true";


/// to fetch all data from api
  Future<Crypto> getCryptoNews() async {


/// get request to fetch details from the api
    final response = await get(Uri.parse(url));
    /// json data into string
    final cryptoNews = cryptoFromJson(response.body);
    return cryptoNews;
  }
}
