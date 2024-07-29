import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:totem/models/order_item.dart';
import 'package:totem/services/utils.dart';

class OrderProvider extends StateNotifier<OrderItem> {
  OrderProvider() : super(OrderItem(rows: []));

  void setOrder(OrderItem order) => state = order;

  void addItem(String productId) {
    final rows = state.clone().rows;
    rows.add(OrderRowItem(
        rowId: Utils.getUUID(), qty: 1, productId: productId, extras: []));
    state = OrderItem(rows: rows);
  }

  int getItemCount(String productId) {
    return state.rows.where((element) => element.productId == productId).length;
  }

  void removeItem(String productId) {
    if (state.rows.isEmpty) return;

    final rows = state.rows;
    final last = rows.where((el) => el.productId == productId);

    if (last.isEmpty) return;

    rows.remove(last.last);

    state = OrderItem(rows: rows);
  }

  void removeRow(OrderRowItem item) {
    final rows = state.rows;
    rows.remove(item);
    state = OrderItem(rows: rows);
  }

  void updateVariant(List<OrderRowItem> newRows) {
    final rows = state.rows;
    for (int i = 0; i < rows.length; i++) {
      for (final newRow in newRows) {
        if (rows[i].rowId == newRow.rowId) {
          rows[i].extras = newRow.extras;
        }
      }
    }
    state = OrderItem(rows: rows);
  }

  //METODI IMPLEMENTATI DA FRANCESCO CANNIZZO

  int getItemRowsCount(String productId) {
    return state!.rows
            .where((element) => element.productId == productId)
            .length ??
        0;
  }

  void removeOrder(String rowId) {
    var tempOrder = state?.clone() ?? OrderItem(rows: []);
    if (tempOrder.rows.isNotEmpty) {
      var itemToRemove =
          tempOrder.rows.where((e) => e.rowId == rowId).firstOrNull;
      if (itemToRemove != null) {
        tempOrder.rows.remove(itemToRemove);
      }
    }
    state = tempOrder;
  }
}

final orderProvider = StateNotifierProvider<OrderProvider, OrderItem>((ref) {
  return OrderProvider();
});
