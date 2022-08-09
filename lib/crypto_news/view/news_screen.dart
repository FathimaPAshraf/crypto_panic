import 'package:cryptoo/crypto_news/bloc/crypto_bloc.dart';
import 'package:cryptoo/crypto_news/repository/crypto_services.dart';

import 'package:cryptoo/crypto_news/view/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CryptoBloc(
        RepositoryProvider.of<CryptoService>(context),
      )..add(
          LoadApiEvent(),
        ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<CryptoBloc, CryptoState>(
            builder: (context, state) {
              if (state is CryptoLoadingState) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              if (state is CryptoLoadedState) {
                return RefreshIndicator(
                  // when we scroll it refreshes the page and calls load api event which fetches new News data
                  onRefresh: () async {
                    context.read<CryptoBloc>().add(LoadApiEvent());
                  },
                  // building the news
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 20),
                    itemCount: state.results!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          //Navigate to news page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => News(
                                //pass index
                                results: state.results,
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: Text(
                                // using timeago package for formatting time
                                  '${timeago.format(state.results![index].publishedAt!.subtract(Duration(minutes: 1)), locale: 'en_short')} ',
                                  style: TextStyle(color: Colors.green)),
                              title: Wrap(
                                spacing: 20,
                                children: [
                                  //news text
                                  Text('${state.results![index].slug} '),
                                  InkWell(

                                    onTap: () async {
                                      final url = Uri.parse(
                                          'https://www.${state.results![index].domain}/');
                                      await launchUrl(url);
                                    },

                                    child: Text(
                                      '🔗 ${state.results![index].domain}',
                                      style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                //cryptoo coin name
                                '${state.results![index].currencies?[0].code ?? ''}',
                                style: TextStyle(color: Colors.orangeAccent),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 1,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
