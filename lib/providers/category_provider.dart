import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryProvider extends StateNotifier<int> {
  CategoryProvider() : super(0);

  void changeCategory(int newIndex) => state = newIndex;
}

final categoryProvider = StateNotifierProvider<CategoryProvider, int>((ref) {
  return CategoryProvider();
});
