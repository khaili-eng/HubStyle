import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:untitled7/features/cart/data/model/cart_item_model.dart';
import 'package:untitled7/features/cart/presentation/manager/card_state.dart';
import 'package:untitled7/features/cart/repo/cart_repo.dart';
import 'package:untitled7/features/products/data/models/products_mdels.dart';

class CartCubit extends HydratedCubit<CartState>{
  final CartRepo cartRepo;
  CartCubit(this.cartRepo):super(const CartInitial());
  double _calculateItemTotal(CartItem item){
    final pro = item.product;
    final q = item.quantity;
    final discountPrice = pro.discountedPrice?? pro.price;
    final discountQty = q<=3? q :3;
    final normalQty = q>=3? q-3 :0;
    if(q<=3){
      return q * discountPrice;
    }else{
      return (discountQty*discountPrice)+(normalQty*pro.price);
    }
  }
  double itemSubtotal(String productId) {
    final index = state.items.indexWhere((i) => i.product.id == productId);
    if (index < 0) return 0.0;
    return _calculateItemTotal(state.items[index]);
  }


  void _emitUpdated(List<CartItem> updatedItems, {String? warnMessage}) {
    final total = updatedItems.fold(
      0.0,
          (sum, item) => sum + _calculateItemTotal(item),
    );

    final newState = CartUpdated(
      items: updatedItems,
      total: total,
      warnMessage: warnMessage,
    );

    emit(newState);
    cartRepo.saveCart(updatedItems);
  }


  void addProduct(ProductsModel product) {
    final items = [...state.items];
    final idx = items.indexWhere((e) => e.product.id == product.id);

    if (idx >= 0) {
      items[idx].quantity++;

      String? warn;
      if (items[idx].quantity > 3) {
        warn = "Any item beyond the first three will be charged at full price";
      }

      _emitUpdated(items, warnMessage: warn);
    } else {
      items.add(CartItem(product: product, quantity: 1));


      _emitUpdated(
        items,
        warnMessage: "${product.name} added to cart successfully!",
      );
    }
  }

  void increaseQuantity(String id) {
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i) => i.product.id == id);
    if (index < 0) return;

    if (items[index].quantity < items[index].product.maxStack) {
      items[index] = CartItem(
        product: items[index].product,
        quantity: items[index].quantity + 1,
      );

      String? warnMsg;


      if (items[index].quantity > 3) {
        warnMsg = "Only the first 3 items are discounted";
      }

      _emitUpdated(items, warnMessage: warnMsg);
    } else {
      _emitUpdated(items, warnMessage: "Reached max quantity for this product");
    }
  }

  void decreaseQuantity(String id){
    final items = List<CartItem>.from(state.items);
    final index = items.indexWhere((i)=>i.product.id==id);
    if(index<0) return;
    if(items[index].quantity>1){
      items[index].quantity--;
    }else{
      items.removeAt(index);
    }
    _emitUpdated(items);
  }
  void removeProduct(String id) {
    final items = state.items.where((e)=>e.product.id!=id).toList();
    _emitUpdated(items);
  }
  void clearWarning() {
    if (state is CartUpdated) {
      final s = state as CartUpdated;
      emit(s.copyWith(warnMessage: null));
    }
  }

  @override
  CartState?fromJson(Map<String,dynamic>json){
    switch(json["runtimeType"]){
      case "updated":
        return CartUpdated.fromMap(json);
    default:
      return const CartInitial();
    }
  }
  @override
  Map<String, dynamic>? toJson(CartState state) {
    return state.toMap();
  }
}
