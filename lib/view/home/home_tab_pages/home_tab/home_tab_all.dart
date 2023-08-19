import 'package:flutter/material.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/components/home_slide.dart';

import 'common_rooms_view.dart';
import 'new_rooms_view.dart';

class HomeTabAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>["شائعة", "جديدة"];
    final size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  expandedHeight: size.height * 0.22,
                  floating: true,
                  pinned: true,
                  snap: false,
                  backgroundColor: Colors.transparent,
                  forceElevated: innerBoxIsScrolled,
                  flexibleSpace: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 60),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          // image: DecorationImage(
                          //   image: NetworkImage(
                          //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
                          //   //your image
                          //   fit: BoxFit.cover,
                          // ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        // child: HomeSlide(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: HomeSlide(),
                      ),
                    ],
                  ),
                  // bottom: AppBar(
                  //   toolbarHeight: 50,
                  //   backgroundColor: Colors.white,
                  //   elevation: 4.0,
                  //   title: TabBar(
                  //     indicatorSize: TabBarIndicatorSize.label,
                  //     indicatorColor: kPrimaryColor,
                  //     indicatorWeight: 5.0,
                  //     labelStyle: TextStyle(
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.w700), //For Selected tab
                  //     tabs: _tabs
                  //         .map((String name) => Tab(
                  //               text: name,
                  //             ))
                  //         .toList(),
                  //   ),
                  // ),
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            NewRoomsView(),
            CommonRoomsView(),
          ]

              // _tabs.map((String name) {
              //   print(name);
              //   return SafeArea(
              //     top: true,
              //     bottom: false,
              //     child: Builder(
              //       builder: (BuildContext context) {
              //         return CustomScrollView(
              //           key: PageStorageKey<String>(name),
              //           physics: BouncingScrollPhysics(),
              //           slivers: <Widget>[
              //             SliverOverlapInjector(
              //               handle:
              //                   NestedScrollView.sliverOverlapAbsorberHandleFor(
              //                       context),
              //             ),
              //             SliverPadding(
              //               padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              //               sliver: SliverList(
              //                 delegate: SliverChildBuilderDelegate(
              //                   (BuildContext context, int index) {
              //                     return HomeListItem();
              //                   },
              //                   childCount: 6,
              //                 ),
              //               ),
              //             ),
              //           ],
              //         );
              //       },
              //     ),
              //   );
              // }).toList(),
              ),
        ),
      ),
    );
  }
}
