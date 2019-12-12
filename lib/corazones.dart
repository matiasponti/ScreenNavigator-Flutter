import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:toast/toast.dart';

import 'favorites.dart';

 class RandomWords extends StatefulWidget {
  RandomWords({ this.numero});
  int numero;



  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  // #enddocregion RWS-var
  void _pushSaved() {
    _saved.length == 0 || _saved == null
        ? Toast.show("No favorites", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM)
        : newpage();
  }

  newpage() {
    final Iterable<ListTile> tiles = _saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FavoritesWords(
                  tiles: tiles,
                )));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
  // #enddocregion _buildSuggestions

  // #docregion _buildRow
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        color: alreadySaved ? Colors.yellow : null,
      ),
      onTap: () {
        if ( _saved.length == widget.numero) {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              Toast.show("You can choose only "+ widget.numero.toString() , context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          });

        } else {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        }
      },
    );
  }
  // #enddocregion _buildRow

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }
}
// #enddocregion RWS-build
// #docregion RWS-var

// #enddocregion RWS-var
