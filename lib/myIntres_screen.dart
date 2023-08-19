import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/utils/constants.dart';

import 'models/myBackground_model.dart';
import 'models/shop_background_mode.dart';

class MyIntersScreen extends StatefulWidget {
  const MyIntersScreen({Key key}) : super(key: key);

  @override
  State<MyIntersScreen> createState() => MyIntersScreenState();
}

class MyIntersScreenState extends State<MyIntersScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..myIntesData(),
      child: BlocConsumer<ShopCubit, ShopIntresStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).myIntresModel != null,
            builder: (context) =>
                getIntresItem(ShopCubit.get(context).myIntresModel),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getIntresItem(MyBackgroundModel model) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigator.pop();
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1.3,
                  children: List.generate(model.data.length,
                      (index) => buildGridleProduct(model.data[index])))),
        ),
        // bottomNavigationBar: BottomAppBar(
        //   child: Row(
        //     children: [
        //       IconButton(
        //           icon:
        //               Icon(Icons.monetization_on_rounded, color: Colors.orange),
        //           onPressed: () {}),
        //       Text("0"),
        //       Spacer(),
        //       Padding(
        //         padding: const EdgeInsets.all(10.0),
        //         child: TextButton(
        //             onPressed: () {},
        //             child: Text(
        //               "< الشحن",
        //               style: TextStyle(color: kPrimaryColor),
        //             )),
        //       )
        //     ],
        //   ),
        // ),
      );
  Widget buildGridleProduct(MyBackgroundData model) => Column(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(8.0)),
                  child: Image.network(
                    model.url,
                    height: 230,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData(
                          dialogBackgroundColor: Colors.grey.withOpacity(0.0)),
                      child: AlertDialog(
                        content: SingleChildScrollView(
                            child: Image.network(
                          model.url,
                        )),
                      ),
                    );
                  });
              setState(() {
                // image = model.url;
                // CacheHelper.saveData(key: 'image', value: model.url);
              });
            },
          ),
          // Container(child: Center(child: Text(model.price.toString()))),
          // Container(
          //   width: 180,
          //   color: KstorebuttonColor,
          //   child: Center(
          //     child: Text(
          //       "شراء",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      );
}
