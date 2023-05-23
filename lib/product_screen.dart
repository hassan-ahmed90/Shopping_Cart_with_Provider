import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';
import 'package:system_cart/cart_mod.dart';
import 'package:system_cart/cart_provide.dart';
import 'package:system_cart/cart_sccreen.dart';
import 'package:system_cart/d_helper.dart';
class ProductScree extends StatefulWidget {
  const ProductScree({Key? key}) : super(key: key);

  @override
  State<ProductScree> createState() => _ProductScreeState();
}
class _ProductScreeState extends State<ProductScree> {

  DbHelper? db = DbHelper();
  List<String> productName = ['Mango' , 'Orange' , 'Grapes' , 'Banana' , 'Chery' , 'Peach','Mixed Fruit Basket',] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'Dozen' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612' ,
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612' ,
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612' ,
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612' ,
  ] ;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Poducts"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));

            },
            child: Center(
              child: badge.Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context,value,child){
                    return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white),);
                  },),
                badgeAnimation: badge.BadgeAnimation.fade(
                 animationDuration:   Duration(milliseconds: 300),
                ),
                child: Icon(Icons.shopping_bag_outlined),

              ),
            ),
          ),
        SizedBox(
          width: 20 ,
        )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                child:ListView.builder(
                    itemCount: productName.length,
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
                                image: NetworkImage(productImage[index]),
                            ),
                            SizedBox(width: 15,),
                            Expanded(child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productName[index]),
                                SizedBox(height: 5,),
                                Text(productUnit[index]+"  "+productPrice[index].toString()+" Rs"),
                              ],

                            )),

                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: (){
                                  db!.insert(
                                      Cart(
                                      id: index,
                                      productId: index.toString(),
                                      productName: productName[index].toString(),
                                      productPrice: productPrice[index],
                                      image: productImage[index].toString(),
                                      unitTag: productUnit[index].toString(),
                                      initialPrice: productPrice[index],
                                      quantity: 1)).then((value) {
                                    print('Product list is added to cart');
                                    cart.addCtotalPrice(double.parse(productPrice[index].toString()));
                                    cart.addCounter();

                                      }).onError((error, stackTrace) {
                                    print(error.toString());
                                      });

                                },
                                child: Container(
                                  height: 40,
                                  width: 100,
                                  child: Center(child: Text("Add to Cart",style: TextStyle(color: Colors.white),)),
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
                }) ),

          ],
        ),
      ),
    );
}}

