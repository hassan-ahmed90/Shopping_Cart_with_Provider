import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_cart/cart_provide.dart';
import 'package:system_cart/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>CartProvider(),
    child: Builder(builder: (BuildContext context){
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductScree()
      );
    },),
    );
  }
}
