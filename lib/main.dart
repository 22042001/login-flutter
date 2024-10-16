import 'package:flutter/material.dart';
import 'quejas.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 25, 1, 1)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Principal'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('ir al formu'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuejasPage()),
            );
          },
        ),
      ),
    );
  }
}