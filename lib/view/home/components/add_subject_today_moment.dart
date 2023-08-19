import 'package:flutter/material.dart';

class AddSubjectToDayMoment extends StatelessWidget {
  const AddSubjectToDayMoment({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text("اضافة موضوع")),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              color: Colors.white,
              child: TextFormField(
                obscureText: false,
                onSaved: (value){},
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "بحث المواضيع",
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            _sizedBox(height: 16),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (context, index){
                  return Column(
                    children: [
                      GestureDetector(
                        onTap:(){
                          // Close the screen and return "Nope." as the result.
                          Navigator.pop(context, 'Nope selected item.');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Image.asset("assets/images/item_image.png", fit: BoxFit.fill,),
                              ),
                              _sizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("نشاطات اللحظات في يلا", maxLines: 1,),
                                    _sizedBox(height: 6.0),
                                    Row(
                                      children: [
                                        _subjectCountInfo(Icon(Icons.person_outline, color: Colors.white, size: 15,), "506.6", theme),
                                        _sizedBox(width: 10.0),
                                        _subjectCountInfo(Icon(Icons.event_note, color: Colors.white, size: 15,), "251k", theme),
                                        _sizedBox(width: 10.0),
                                        _subjectCountInfo(Icon(Icons.card_giftcard, color: Colors.white, size: 15,), "17.9m", theme),
                                      ],
                                    ),
                                    _sizedBox(height: 4.0),
                                    Text(" نشاطات اللحظات في يل نشاطات اللحظات في يل نشاطات اللحظات في يل نشاطات اللحظات في يلا", maxLines: 1,style: theme.textTheme.bodyText2.copyWith(color: Colors.grey),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 100.0),
                        child: Divider(color: Colors.grey.shade600),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizedBox({double width, double height}){
    return SizedBox(
      width: width,
      height: height,
    );
  }

  Widget _subjectCountInfo(Icon icon, String countNum, ThemeData theme){
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: icon,
        ),
        _sizedBox(width: 3.0),
        Text(countNum, style: theme.textTheme.bodyText2,)
      ],
    );
  }
}
