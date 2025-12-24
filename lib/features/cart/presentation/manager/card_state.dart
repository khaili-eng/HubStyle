import 'package:equatable/equatable.dart';
import 'package:untitled7/features/cart/data/model/cart_item_model.dart';


abstract class CartState extends Equatable{
  final List<CartItem> items;
  final double total;
  final String? warnMessage;
 const  CartState({
    required this.items,
   required this.total,
   this.warnMessage,
});
 Map<String,dynamic> toMap();
}
class CartInitial extends CartState{
const CartInitial():super(items: const[],total: 0.0);
@override
  List<Object?> get props=>[items,total];

  @override
  Map<String, dynamic> toMap() {
   return {
     "runtimeType": "initial",
     "items": [],
     "total": 0.0,
   };
   }
  }
class CartUpdated extends CartState{
  const CartUpdated({
    required List<CartItem> items,
    required double total,

    String? warnMessage,
}):super(items: items,total: total,
    warnMessage: warnMessage,);
  @override
  List<Object?> get props => [items,total];
  CartUpdated copyWith({
    List<CartItem>?items,
    double?total,
    String? warnMessage,
}){
    return CartUpdated(
        items: items??this.items,
        total: total??this.total,
        warnMessage: warnMessage,);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "runtimeType": "updated",
      "items": items.map((e) => e.toMap()).toList(),
      "total": total,
      "warnMessage": warnMessage,
    };
  }
  factory CartUpdated.fromMap(Map<String, dynamic> map) {
    return CartUpdated(
      items: List<CartItem>.from(
        (map["items"] ?? []).map((x) => CartItem.fromMap(x)),
      ),
      total: (map["total"] ?? 0.0).toDouble(),
    );
  }
}
class CartLoading extends CartState {
  const CartLoading() : super(items: const [], total: 0.0);

  @override
  List<Object?> get props => [items, total];

  @override
  Map<String, dynamic> toMap() {
    return {
      "runtimeType": "loading",
      "items": [],
      "total": 0.0,
    };
  }
}
