import 'package:bench_boost_program/provider/model/datamodel.dart';
import 'package:bench_boost_program/provider/services/Services.dart';
import 'package:flutter/material.dart';


class DataProvider with ChangeNotifier {
  late DataModel data;

  bool loading = false;
  Services services = Services();

  getPostData(context) async {
    loading = true;
    data = await services.getData(context);
    loading = false;

    notifyListeners();
  }
}