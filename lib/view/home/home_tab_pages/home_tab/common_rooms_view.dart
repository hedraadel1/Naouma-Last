import 'package:flutter/material.dart';
import 'package:project/models/room_data_model.dart';
import 'package:project/widgets/home_list_item.dart';

class CommonRoomsView extends StatelessWidget {
  const CommonRoomsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>("common"),
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverPadding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return HomeListItem(roomData: roomsList[index]);
                    },
                    childCount: roomsList.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
