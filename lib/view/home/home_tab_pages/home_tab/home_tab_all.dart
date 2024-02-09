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
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: HomeSlide(),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: HomeSlide(),
                      ),
                    ],
                  ),
                  bottom: AppBar(
                    toolbarHeight: 50,
                    backgroundColor: Colors.white,
                    elevation: 4.0,
                    title: TabBar(
                      labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: kPrimaryColor,
                      indicatorWeight: 5.0,
                      labelStyle: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w700),
                      //For Selected tab
                      tabs: _tabs
                          .map((String name) => Tab(
                                text: name,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(children: [
            NewRoomsView(),
            CommonRoomsView(),
          ]),
        ),
      ),
    );
  }
}
