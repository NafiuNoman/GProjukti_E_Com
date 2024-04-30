import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moible_app/data/remote/model/product_by_category.dart';
import 'package:moible_app/page/product_details_page.dart';

import '../controller/product_ctr.dart';
import '../widget/simmer_loading.dart';
class ProductsPage extends StatelessWidget {
   ProductsPage({super.key});
  final ctr = Get.find<ProductCtr>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        leadingWidth: 30,
        backgroundColor: Colors.deepOrange.shade200,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
            )),
        title: Row(
          children: [
            Image.asset('assets/image/logo-removebg-preview.png',height: 35,width: 35,),
            Gap(10),
            Text(
              'Results',
              style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),

      body: SafeArea(child:
    FutureBuilder(
        future: ctr.getProductListByCategories(),
      builder: (ctx, snp) {
        if (snp.hasError) {
          return Text("Error ${snp.error}");
        } else if (snp.connectionState == ConnectionState.waiting) {
          return const SimmerLoading();
        } else if (snp.hasData) {
          if (snp.data!.isNotEmpty) {
            return buildList(snp.data!, context);
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/no_product.png',
                  height: 70,
                  width: 70,
                ),
                const Text('No Product Categories found'),
              ],
            );
          }
        } else {
          return const Text("Something  went wrong");
        }
      },
    )


    ),);
  }


  Widget buildList(List<Product> items, BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) {
                Product product = items.elementAt(index);

                return ListTile(
                  onTap: (){
                    ctr.selectedProductIndex=index;

                    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  ProductDetailsPage()),);

                  },
                  title: Text(product.name,maxLines: 2,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 12),),
                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('৳${product.updated_selling_price}',style: const TextStyle(color: Colors.deepOrange),),
                      InkWell(onTap: () {
                        Fluttertoast.showToast(msg: "Added to Cart Successfully",backgroundColor: Colors.green);
                      },
                        child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange),borderRadius: BorderRadius.circular(8) ),child:const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text("Add to Cart",style: TextStyle(color: Colors.deepOrange,fontSize: 10),),
                        ) ,),
                      )
                    ],
                  ),
                  leading: product.images != null
                      ? Image.network(product.images!)
                      : Image.asset('assets/image/logo.jpg'),
                );
              }),
        ),
      ],
    );
  }

}
