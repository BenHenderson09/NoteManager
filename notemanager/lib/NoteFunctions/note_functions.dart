import 'package:flutter/material.dart';
import 'dart:convert';

class NoteFunctions{
  static List<Map<String,String>> parseNotes(var notes){
    List<Map<String,String>> parsed = new List<Map<String,String>>();

    if (notes != null){
       for (var note in json.decode(notes)){
        Map<String,String> data = Map<String,String>.from(note);
        parsed.add(data);
      }
    }
    
    return parsed;
  }
}