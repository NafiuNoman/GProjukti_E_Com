import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:moible_app/data/remote/model/product_by_category.dart';

import '../controller/product_ctr.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({super.key});

  final ctr = Get.find<ProductCtr>();

  @override
  Widget build(BuildContext context) {
    Product product = ctr.loadProduct();

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
              'Product details',
              style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [

              product.images != null
                  ? Image.network(product.images!)
                  : Image.asset('assets/image/logo.jpg'),
              Text(product.name),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '৳${product.updated_selling_price}',
                      style: const TextStyle(color: Colors.deepOrange),
                    ),Gap(20), product.selling_price!=null?  Text(
                      '৳${product.selling_price}',
                      style: const TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),
                    ):Gap(10),

                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: product.stock_available? Colors.green:Colors.grey),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 3),
                        child: Text(product.stock_available?"Stock Avialable":"Out of Stock",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 8)),
                      ),
                    )
                  ],
                ),
              ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Gap(20),
              RatingBar.builder(
                initialRating: 3,
                direction: Axis.horizontal,
                allowHalfRating: true,

                itemCount: 5,
                itemSize: 25,
                //   ratingWidget: RatingWidget(
                //   full: Image.asset('assets/image/full_star.png'),
                //   half:  Image.asset('assets/image/half_star.png'),
                //   empty:  Image.asset('assets/image/empty_star.png'),
                // ),
                itemBuilder: (context,_)=>Icon(Icons.star,color: Colors.amber,),
                itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              InkWell(onTap: () {
                Fluttertoast.showToast(msg: "Added to Cart Successfully",backgroundColor: Colors.green);
              },
                child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange),borderRadius: BorderRadius.circular(8) ),child:const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_cart_rounded,color: Colors.deepOrange,),
                      Gap(20),
                      Text("Add to Cart",style: TextStyle(color: Colors.deepOrange,fontSize: 12),),
                    ],
                  ),
                ) ,),
              )
            ],

          ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  product.meta.description==null?Text("No description available right now"):  Html(
                      data: product.meta.description,
                      // style: {
                      //   '#': Style(
                      //     color: Colors.white,
                      //   ),
                      // },
                    ),
                  ],
                ),
              )

            ],),
          ),
        )
      ),
    );
  }
}
