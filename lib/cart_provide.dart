import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_cart/d_helper.dart';

import 'cart_mod.dart';

class CartProvider with ChangeNotifier{
  int _counter =0;
  int get counter => _counter;
  DbHelper db =  DbHelper();

  double _totalPrice =0.0;
  double get totalPrice => _totalPrice;
  late Future<List<Cart>> _cart;
Future<List<Cart>> get cart=>_cart;
Future<List<Cart>> getData() async{
_cart =db.getCartList();
return _cart;

}

  void setPrefItems()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }
  void _getPrefItems()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    _counter=prefs.getInt('cart_item') ?? 0;
    _totalPrice=prefs.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter()async{
    _counter++;
    setPrefItems();
    notifyListeners();
  }
  void removeCounter()async{
    _counter--;
    setPrefItems();
    notifyListeners();
  }
  int getCounter (){
    _getPrefItems();
    return _counter;
  }


  void addCtotalPrice(double productPrice)async{
    _totalPrice=_totalPrice+productPrice;
    setPrefItems();
    notifyListeners();
  }
  void removetotalPrice(double productPrice)async{
    _totalPrice=_totalPrice-productPrice;
    setPrefItems();
    notifyListeners();
  }
  double getTotalPrice (){
    _getPrefItems();
    return _totalPrice;
  }
}