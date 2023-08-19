import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/utils/constants.dart';

import 'models/myBackground_model.dart';
import 'models/shop_background_mode.dart';

class MyBackgroundScreen extends StatefulWidget {
  const MyBackgroundScreen({Key key}) : super(key: key);

  @override
  State<MyBackgroundScreen> createState() => _MyBackgroundScreenState();
}

class _MyBackgroundScreenState extends State<MyBackgroundScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..myBackgroundData(),
      child: BlocConsumer<ShopCubit, ShopIntresStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).myBackgroundModel != null,
            builder: (context) =>
                getIntresItem(ShopCubit.get(context).myBackgroundModel),
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
          actions: [
            // TextButton(
            //   child: Text(
            //     "الخاص بي",
            //     style: TextStyle(color: Colors.white, fontSize: 15),
            //   ),
            //   onPressed: () {},
            // )
          ],
          centerTitle: true,
          title: Text(
            "الموضوعات",
            style: TextStyle(color: Colors.white),
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
