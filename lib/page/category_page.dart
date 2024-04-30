import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moible_app/controller/product_ctr.dart';
import 'package:moible_app/page/sub_category_page.dart';

import '../data/remote/model/product_group_List_model.dart';
import '../widget/simmer_loading.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final ctr = Get.find<ProductCtr>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{ await ctr.getProductCategories();},
      child: Scaffold(
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
                'Featured Categories',
                style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: ctr.getProductCategories(),
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
        )),
      ),
    );
  }

  Widget buildList(List<ProductCategory> items, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        itemCount: items.length,
        itemBuilder: (ctx, index) {
          ProductCategory category = items.elementAt(index);

          return InkWell(
            onTap: () {
              ctr.selectedCategoryIndex = index;

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubCategoryPage()),
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
                      child: category.logo != null
                          ? Image.network(category.logo!)
                          : Image.asset('assets/image/no_product.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        category.name,
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
    );
  }
}
