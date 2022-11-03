import 'package:flutter/material.dart';
import 'package:lazy_list_load/components/lazy_list_item.dart';
import 'package:lazy_list_load/components/lazy_list_load.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  List<LazyListItem> items = List.generate(
    20,
    (index) => LazyListItem(
      title: "$index",
      image: "https://picsum.photos/$index",
    ),
  ).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lazy List Example"),
        centerTitle: true,
      ),
      body: LazyListLoad(
        items: items,
        loadMore: _loadMore,
      ),
    );
  }

  _loadMore() {
    List<LazyListItem> newItems = List.generate(
      20,
      (index) => LazyListItem(
        title: "Image number ${index + items.length}",
        subTitle: "very bitufol",
        image: "https://picsum.photos/${index + items.length}",
        listItemImageSize: ListItemImageSize.LARGE,
      ),
    ).toList();

    setState(() {
      items = [...items, ...newItems];
    });
  }
}
