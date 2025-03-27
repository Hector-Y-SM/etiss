import 'package:app/models/social_service.dart';
import 'package:flutter/material.dart';

ValueNotifier<SsFavorites> firebase_service_social = ValueNotifier(SsFavorites());

class SsFavorites extends ChangeNotifier {
  final List<SocialService> _list = [];

  List<SocialService> _userFav = [];
  List<SocialService> get list => _list;

  List<SocialService> get userFav => _userFav;

  void addItemToCart(SocialService item) {
    _userFav.add(item);
    notifyListeners();
  }

  void removeFromCart(SocialService item){
    _userFav.remove(item);
    notifyListeners();
  }
}