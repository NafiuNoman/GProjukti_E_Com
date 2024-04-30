import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:moible_app/data/remote/model/product_group_List_model.dart';

import 'model/product_by_category.dart';

class ApiService
{

  static String baseUrl = "https://testapi.gprojukti.com/api/v1.0/";
  static String productGroupsEndPoint = "catalog/public/product-groups";
  static String productListByCategoryEndPoint = "products/public/product-list";


  static Future<ProductGroupList?> getProductCategories() async {

    final queryParameters = {
      'page_size': '0',
    };
    final headers = {

      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + productGroupsEndPoint)
          .replace(queryParameters: queryParameters);

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ProductGroupList model = ProductGroupList.fromJson(data);
        if (model.success == true) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");

        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }

  }
  static Future<ProductByCategory?> getProductListByCategory(String categorySlug) async {

    final queryParameters = {
      'page_size': '20',
      'page': '1',
      'category__slug': categorySlug,

    };
    final headers = {

      'Content-Type': 'application/json',
      'charset': 'utf-8',
    };

    try {
      final url = Uri.parse(baseUrl + productListByCategoryEndPoint)
          .replace(queryParameters: queryParameters);

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        ProductByCategory model = ProductByCategory.fromJson(data);
        if (model.success == true) {
          return model;
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong");
          return null;
        }
      } else {
        Fluttertoast.showToast(msg: "Something went wrong");

        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Exception:$e", toastLength: Toast.LENGTH_LONG);
      return null;
    }

  }



}