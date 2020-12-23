import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

import 'package:wsb_dashboard/model/post.dart';

Future<Map<String, dynamic>> fetchPosts() async {
  final response = await http.get(
      'https://wall-street-bet-server.herokuapp.com/stats/gain_loss/post?interval=week');

  if (response.statusCode == 200) {
    final Map<String, dynamic> json = jsonDecode(response.body);
    return json;
  } else {
    throw Exception('Failed to fetch from Gain and Loss end point');
  }
}

Future<List<Post>> getPosts() async {
  final json = await fetchPosts();
  final raw_posts = json['data_used'];
  final posts = postsFromJson(raw_posts: raw_posts);

  return posts;
}

List<Post> postsFromJson({List<dynamic> raw_posts}) {
  final List<Post> posts = [];

  for (var post in raw_posts) {
    final newPost = Post.fromJson(json: post);
    posts.add(newPost);
  }
  return posts;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wall Street Bets Fools Index',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Wall Street Bets Fools Index'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = getPosts();
    print('posts is being fetched');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wall Street Bets')),
      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final firstPost = snapshot.data[0];
            final secondPost = snapshot.data[1];
            final thirdPost = snapshot.data[2];

            return ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: Center(child: Text(firstPost.title)),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[500],
                  child: Center(child: Text(secondPost.title)),
                ),
                Container(
                  height: 50,
                  color: Colors.amber[100],
                  child: Center(child: Text(thirdPost.title)),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
      //Text('Hello world'),
    );
  }
}
