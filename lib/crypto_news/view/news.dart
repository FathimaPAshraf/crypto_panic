import 'package:cryptoo/crypto_news/model/crypto.dart';
import 'package:flutter/material.dart';


//crypto news description
class News extends StatelessWidget {
  final int index;
  final List<Result>? results;
  const News({
    Key? key,
    required this.index,
    required this.results,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Description'),
          ),
          backgroundColor: Colors.black,
          body: Column(
            children: [
              /// showing the News heading
              Text(
                '${results![index].slug}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.white38, fontSize: 20,fontStyle:FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
