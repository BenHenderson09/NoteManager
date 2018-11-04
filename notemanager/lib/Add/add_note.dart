import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Stateful because if the user hits the back button to hide the keyboard, the text
// controllers reset.
class AddNote extends StatefulWidget{                                  
  @override
  State<StatefulWidget> createState(){
    return AddNoteState();
  }
}

class AddNoteState extends State<AddNote>{
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _bodyController = new TextEditingController();

  @override
  void dispose(){
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _addNote() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String,String> note = {'title':_titleController.text,'body':_bodyController.text};

    List<Map<String,String>> notes = new List<Map<String,String>>();

    notes = _parseNotes(prefs.getString('notes'));

    notes.add(note);
    prefs.setString('notes', json.encode(notes));
  }

  List<Map<String,String>> _parseNotes(var notes){
    List<Map<String,String>> parsed = new List<Map<String,String>>();

    if (notes != null){
       for (var note in json.decode(notes)){
        Map<String,String> data = Map<String,String>.from(note);
        parsed.add(data);
      }
    }
    
    return parsed;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),

      body:ListView(
        children: <Widget>[
          Container(
            margin:EdgeInsets.all(10.0),
            child: Column(
              children:<Widget>[

                Container(
                  margin:EdgeInsets.symmetric(horizontal: 5.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: 'Title'
                    ),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                    ),
                    controller: _titleController,
                  ),
                ),
                 
                Container(
                  margin:EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child:TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      hintText: 'Body'
                    ),
                    controller: _bodyController,
                  ),
                ),

                Container(
                  width:double.infinity,
                  child:RaisedButton(
                    textColor: Colors.white,
                    color: Colors.lightBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: Text("Add Note"),
                    onPressed: (){
                      _addNote().then((result){                    
                        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
                      });
                    },
                  ),
                ),

              ]
            )
          ),
        ],
      )
    );
  }
}