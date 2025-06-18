import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/todo_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', ''), Locale('ko', '')],
      home: TodoScreen(), // 화면 부분을 따로 뺐어
    );
  }
}