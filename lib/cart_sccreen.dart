import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_cart/d_helper.dart';

import 'cart_mod.dart';

import 'cart_provide.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    DbHelper? db =DbHelper();
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        centerTitle: true,
        actions: [
          // InkWell(
          //   onTap: (){
          //
          //   },
          //   child: Center(
          //     child: badge.Badge(
          //       badgeContent: Consumer<CartProvider>(
          //         builder: (context,value,child){
          //           return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
          //         },),
          //       badgeAnimation: badge.BadgeAnimation.fade(
          //         animationDuration:   Duration(milliseconds: 300),
          //       ),
          //       child: Icon(Icons.shopping_bag_outlined),
          //
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 20 ,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: cart.getData(),
              builder: (context ,AsyncSnapshot<List<Cart>> snapshot){
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Image(height:100,
                                  width: 100,
                                  image: NetworkImage(snapshot.data![index].image.toString()),
                                ),
                                SizedBox(width: 15,),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(snapshot.data![index].productName.toString()),
                                       InkWell(
                                           onTap: (){

                                             db.delete(snapshot.data![index].id!);
                                             cart.removeCounter();
                                             cart.removetotalPrice(double.parse(snapshot.data![index].productPrice.toString()));

                                           },
                                           child: Icon(Icons.delete))

                                     ],
                                   ),

                                    SizedBox(height: 5,width: 10,),
                                    Text(snapshot.data![index].unitTag.toString()+"  "+snapshot.data![index].productPrice.toString()+" Rs"),
                                  ],

                                )),

                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: InkWell(
                                    onTap: (){
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      child: Center(child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                              onTap:(){
                                                int quantity =  snapshot.data![index].quantity! ;
                                                int price = snapshot.data![index].initialPrice!;
                                                quantity--;
                                                int? newPrice = price * quantity ;

                                                if(quantity > 0){
                                                  db.updateQuantity(
                                                      Cart(
                                                          id: snapshot.data![index].id!,
                                                          productId: snapshot.data![index].id!.toString(),
                                                          productName: snapshot.data![index].productName!,
                                                          initialPrice: snapshot.data![index].initialPrice!,
                                                          productPrice: newPrice,
                                                          quantity: quantity,
                                                          unitTag: snapshot.data![index].unitTag.toString(),
                                                          image: snapshot.data![index].image.toString())
                                                  ).then((value){
                                                    newPrice = 0 ;
                                                    quantity = 0;
                                                    cart.removetotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                                  }).onError((error, stackTrace){
                                                    print(error.toString());
                                                  });
                                                }


                                              },
                                              child: Icon(Icons.remove)),
                                      Text(snapshot.data![index].productPrice.toString(),style: TextStyle(color: Colors.white),
                                      ),
                                          InkWell(
                                            onTap: (){

                                              int quantity =  snapshot.data![index].quantity! ;
                                              int price = snapshot.data![index].initialPrice!;
                                              quantity++;
                                              int? newPrice = price * quantity ;

                                              db.updateQuantity(
                                                  Cart(
                                                      id: snapshot.data![index].id!,
                                                      productId: snapshot.data![index].id!.toString(),
                                                      productName: snapshot.data![index].productName!,
                                                      initialPrice: snapshot.data![index].initialPrice!,
                                                      productPrice: newPrice,
                                                      quantity: quantity,
                                                      unitTag: snapshot.data![index].unitTag.toString(),
                                                      image: snapshot.data![index].image.toString())
                                              ).then((value){
                                                newPrice = 0 ;
                                                quantity = 0;
                                                cart.addCtotalPrice(double.parse(snapshot.data![index].initialPrice!.toString()));
                                              }).onError((error, stackTrace){
                                                print(error.toString());
                                              });

                                            },
                                              child: Icon(Icons.add))
                                        ],

                                      )
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                    ),
                                  ),
                                )

                              ],


                            )

                          ],
                        ),
                      );
                    }) );
          }),
          Consumer<CartProvider>(
              builder: (context,value,child){
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2)=="0.0" ? false :true,
                  child: Column(
                    children: [
                      Reusable(title: "Subtotal ", value: r'$'+value.getTotalPrice().toStringAsFixed(2))
                    ],
                  ),
                );
              })
        ],
      ),
    );
  }
}
class Reusable extends StatelessWidget {
  final String title,value;
  const Reusable({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title,style: Theme.of(context).textTheme.titleSmall,),
          Text(value.toString(),style: Theme.of(context).textTheme.titleSmall,)
        ],
      ),
    );
  }
}