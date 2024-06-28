

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipes_app/models/data_model.dart';
import 'package:recipes_app/services/api_services.dart';

final recipeDataProvider = FutureProvider<List<DataModel>>((ref) async {
  return ref.watch(dataProvider).getRecipeDatas();
});
