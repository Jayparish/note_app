import 'package:flutter/material.dart';
import 'package:note_app/Database/database.dart';
import 'package:note_app/screens/note_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(

      create:(context)=>AppDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            headline5: TextStyle(
              fontSize: 24,
          fontWeight: FontWeight.bold,

          ),
            bodyText2:  TextStyle(
                fontWeight: FontWeight.bold,

              fontSize: 20
            ),
            bodyText1: TextStyle(
                fontWeight: FontWeight.normal,

                fontSize: 18
            ),
            subtitle2: TextStyle(
                fontWeight: FontWeight.normal,

                fontSize: 14
            )
        ),

        ),
        home: const Notelist()
      ),
    );
  }
}


