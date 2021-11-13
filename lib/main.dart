import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:makr_shakr_app/pages/homepage.dart';
import 'bloc/facts_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String title = 'Makr Shakr App';

  MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
            bottomAppBarColor: Colors.blueGrey
        ),
        routes: {
    '/home': (context) => BlocProvider(
    create: (context) => FactsBloc()..add(GetFacts()), child: MyHomePage(title:title)),
    },
        initialRoute: "/home"
    );
  }
}
