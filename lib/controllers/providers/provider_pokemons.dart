import 'package:flutter/material.dart';

class ProviderPokemonsId  with ChangeNotifier {
  int _id = 0; 

  int get id => _id;

  void increasePokemonsId(int id) {
    _id = id++;
    notifyListeners();
  }

}
  