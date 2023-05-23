
class Cart{

  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final String? image;
  final String? unitTag;
  final int? initialPrice;
  final int? quantity;

  Cart({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.image,
    required this.unitTag,
    required this.initialPrice,
    required this.quantity,

  });

  Cart.fromMap(Map<dynamic,dynamic>res)
: id= res['id'],
  productId=res['productId'],
  productName=res['productName'],
  productPrice=res['productPrice'],
        image=res['image'],
  unitTag=res['uniTag'],
  initialPrice=res['initialPrice'],
  quantity=res['quantity'];

  Map<String,Object?> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productname': productName,
      'productPrice': productPrice,
      'image': image,
      'unitTag': unitTag,
      'initialPrice': initialPrice,
      'quantity': quantity,
    };
  }



}