import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moible_app/page/products_page.dart';

import '../controller/product_ctr.dart';
import '../data/remote/model/product_group_List_model.dart';

class SubCategoryPage extends StatelessWidget {
  SubCategoryPage({super.key});

  final ctr = Get.find<ProductCtr>();

  @override
  Widget build(BuildContext context) {
    ctr.loadSubCategoriesProduct();
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
              'Sub Categories',
              style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Expanded(
        child: Column(
          children: [
            ctr.subCategories.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        'assets/image/no_product.png',
                        height: 100,
                        width: 100,
                      ),
                      Gap(20),
                      Text(
                        "No item available for this category",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ],
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GridView.builder(
                        itemCount: ctr.subCategories.length,
                        itemBuilder: (ctx, index) {
                          ProductSubCategories sub =
                          ctr.subCategories.elementAt(index);

                          return InkWell(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  ProductsPage()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  // border: Border.all(width: 1.5, color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        blurRadius: 4.0,
                                        offset: Offset(3, 4),
                                        color: Colors.black12,
                                      ),
                                    ]),
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: sub.logo != null
                                          ? Image.network(sub.logo!)
                                          : Image.asset('assets/image/no_product.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        sub.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      )),
    );
  }
}
