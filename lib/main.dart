import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name Generator',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divident = tiles.isNotEmpty
              ? ListTile.divideTiles(tiles: tiles, context: context).toList()
              : <Widget>[];
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestion'),
            ),
            body: ListView(children: divident),
          );
        },
      ),
    );
  }

  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter_hello_flutter/src/pages/home_page.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: HomePage(),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   String _message = '';

//   _registerOnFirebase() {
//     _firebaseMessaging.subscribeToTopic('all');
//     _firebaseMessaging.getToken().then((token) => print(token));
//   }

//   @override
//   void initState() {
//     _registerOnFirebase();
//     getMessage();
//     super.initState();
//   }

//   void getMessage() {
//     _firebaseMessaging.configure(
//         onMessage: (Map<String, dynamic> message) async {
//       print('received message');
//       setState(() => _message = message["notification"]["body"]);
//     }, onResume: (Map<String, dynamic> message) async {
//       print('on resume $message');
//       setState(() => _message = message["notification"]["body"]);
//     }, onLaunch: (Map<String, dynamic> message) async {
//       print('on launch $message');
//       setState(() => _message = message["notification"]["body"]);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Push Notifications Test'),
//       ),
//       body: Container(
//           child: Center(
//         child: Text("Message: $_message"),
//       )),
//     );
//   }
// }
