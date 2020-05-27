import 'package:bot_toast/bot_toast.dart';
import 'package:covid19india/repo/repo.dart';
import 'package:covid19india/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/bloc/cloud_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final Repo repo = Repo();
  runApp(App(repo: repo));
}

class App extends StatelessWidget {
  final Repo repo;
  App({@required this.repo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Covid19India',
      theme: ThemeData(
        fontFamily: GoogleFonts.archivo().fontFamily,
        textTheme: TextTheme(
            button:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CloudBloc(repo: repo),
        child: HomeScreen(),
      ),
    );
  }
}
