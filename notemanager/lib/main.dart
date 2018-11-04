import 'package:flutter/material.dart';

import './Dashboard/note_dashboard.dart';
import './Add/add_note.dart';

void main() => runApp(NoteManager());

class NoteManager extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:NoteDashboard(),
      routes: <String, WidgetBuilder>{
        '/addnote': (BuildContext context) => new AddNote(),
        '/dashboard': (BuildContext context) => new NoteDashboard()
      },
    );
  }
}