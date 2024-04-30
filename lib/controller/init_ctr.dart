import 'package:get/get.dart';
import 'package:moible_app/controller/product_ctr.dart';

Future<void> init() async {

  //Common Controller
  Get.lazyPut(() => ProductCtr());



}
