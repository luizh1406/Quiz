import 'package:flutter/material.dart';
import 'quiz.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Homepage(),
        'Quiz': (context) => Quiz(),
      },
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red, // Defina a cor primária como vermelho
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Quiz De Pokemon')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/logo.png'),
              ElevatedButton(
                onPressed: () {
                  print('Pressionado');
                  Navigator.pushNamed(context, 'Quiz');
                },
                child: Text(
                  'Jogar',
                  style: TextStyle(fontSize: 40),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
