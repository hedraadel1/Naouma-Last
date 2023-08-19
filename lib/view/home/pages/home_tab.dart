import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/home_controller.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    // return Directionality(
    //     textDirection: TextDirection.rtl,
    //     child: Scaffold(
    //         body: CustomScrollView(
    //           slivers: <Widget>[
    //             SliverAppBar(
    //               floating: true,
    //               pinned: true,
    //               snap: false,
    //               flexibleSpace: FlexibleSpaceBar(
    //                   centerTitle: true,
    //                   title: DefaultTabController(
    //                     length: 2,
    //                     child: Scaffold(
    //                       appBar: AppBar(
    //                         bottom: TabBar(
    //                           tabs: [
    //                             Tab(icon: Icon(Icons.directions_car)),
    //                             Tab(icon: Icon(Icons.directions_transit)),
    //                             // Tab(icon: Icon(Icons.directions_bike)),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ), //Text
    //                   // background: Image.network(
    //                   //   "https://i.ibb.co/QpWGK5j/Geeksfor-Geeks.png",
    //                   //   fit: BoxFit.cover,
    //                   // ) //Images.network
    //               ), //FlexibleSpaceBar
    //               expandedHeight: 100,
    //             ), //SliverAppBar
    //             Expanded(
    //               child: SliverList(
    //                 delegate: SliverChildBuilderDelegate(
    //                       (context, index) => ListTile(
    //                     tileColor: (index % 2 == 0) ? Colors.white : Colors.green[50],
    //                     title: Center(
    //                       child: Text('$index',
    //                           style: TextStyle(
    //                               fontWeight: FontWeight.normal,
    //                               fontSize: 50,
    //                               color: Colors.greenAccent[400]) //TextStyle
    //                       ), //Text
    //                     ), //Center
    //                   ), //ListTile
    //                   childCount: 51,
    //                 ), //SliverChildBuildDelegate
    //               ),
    //             ) //SliverList
    //           ], //<Widget>[]
    //         ) //CustonScrollView
    //     ),);
    final List<String> _tabs = <String>["شائعة", "جديدة"];
    final size = MediaQuery.of(context).size;
    // return DefaultTabController(
    //   length: _tabs.length,
    //   child: Scaffold(
    //     body:
    //     NestedScrollView(
    //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //         return <Widget>[
    //           SliverOverlapAbsorber(
    //             handle:
    //                 NestedScrollView.sliverOverlapAbsorberHandleFor(context),
    //             sliver: SliverAppBar(
    //               expandedHeight: size.height * 0.22,
    //               floating: true,
    //               pinned: true,
    //               snap: false,
    //               backgroundColor: Colors.grey.shade300,
    //               forceElevated: innerBoxIsScrolled,
    //               flexibleSpace: Stack(
    //                 children: [
    //                   Container(
    //                     margin: const EdgeInsets.only(bottom: 60),
    //                     decoration: BoxDecoration(
    //                       color: kPrimaryColor,
    //                       // image: DecorationImage(
    //                       //   image: NetworkImage(
    //                       //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
    //                       //   //your image
    //                       //   fit: BoxFit.cover,
    //                       // ),
    //                       borderRadius: BorderRadius.only(
    //                         bottomLeft: Radius.circular(50),
    //                         bottomRight: Radius.circular(50),
    //                       ),
    //                     ),
    //                     // child: HomeSlide(),
    //                   ),
    //                   Align(
    //                     alignment: Alignment.center,
    //                     child: HomeSlide(),
    //                   ),
    //                 ],
    //               ),
    //               bottom: AppBar(
    //                 toolbarHeight: 50,
    //                 backgroundColor: Colors.white,
    //                 elevation: 4.0,
    //                 title: TabBar(
    //                   indicatorSize: TabBarIndicatorSize.label,
    //                   indicatorColor: kPrimaryColor,
    //                   indicatorWeight: 4.0,
    //                   tabs:
    //                       _tabs.map((String name) => Tab(text: name)).toList(),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ];
    //       },
    //       body: TabBarView(
    //         children: _tabs.map((String name) {
    //           print(name);
    //           return SafeArea(
    //             top: true,
    //             bottom: false,
    //             child: Builder(
    //               builder: (BuildContext context) {
    //                 return CustomScrollView(
    //                   key: PageStorageKey<String>(name),
    //                   physics: BouncingScrollPhysics(),
    //                   slivers: <Widget>[
    //                     SliverOverlapInjector(
    //                       handle:
    //                           NestedScrollView.sliverOverlapAbsorberHandleFor(
    //                               context),
    //                     ),
    //                     SliverPadding(
    //                       padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
    //                       sliver: SliverList(
    //                         delegate: SliverChildBuilderDelegate(
    //                           (BuildContext context, int index) {
    //                             return HomeListItem();
    //                           },
    //                           childCount: 6,
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ),
    //           );
    //         }).toList(),
    //       ),
    //     ),
    //   ),
    // );
    return GetBuilder<HomeController>(
      // init: HomeController(),
      builder: (controller) => Scaffold(
        body: controller.homeTabChildren[controller.appBarCurrentItem],
        // floatingActionButton: FloatingActionButton(
        //   // backgroundColor: Color(0xFFFFC117),
        //   child: Icon(Icons.add, color: Colors.white),
        //   onPressed: () {
        //     Navigator.pushReplacementNamed(context, "/home");
        //     print("add btn clicked..");
        //     // showDialog(context: context,
        //     //     builder: (BuildContext context){
        //     //       return DailyPrizeDialog();
        //     //     }
        //     // );
        //   },
        // ),
      ),
    );
  }
}
