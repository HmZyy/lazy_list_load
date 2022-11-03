import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_list_load/components/lazy_list_item.dart';

class LazyListLoad extends StatefulWidget {
  ScrollPhysics physics;
  List<LazyListItem> items;
  Function loadMore;
  Color loadingIndicatorColor;
  double loadingIndicatorRadius;
  Widget noMoreData;
  LazyListLoad({
    super.key,
    required this.items,
    required this.loadMore,
    this.loadingIndicatorColor = Colors.blue,
    this.loadingIndicatorRadius = 20,
    this.physics = const BouncingScrollPhysics(),
    this.noMoreData = const SizedBox(height: 20),
  });

  @override
  _LazyListLoadState createState() => _LazyListLoadState();
}

class _LazyListLoadState extends State<LazyListLoad> {
  final ScrollController _scrollController = ScrollController();
  bool noMoreItems = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.loadMore() == false) {
          setState(() {
            noMoreItems = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: widget.physics,
      controller: _scrollController,
      itemCount: widget.items.length + 1,
      itemBuilder: (context, index) => _buildListItem(context, index),
    );
  }

  _buildListItem(context, index) {
    if (index == widget.items.length && !noMoreItems) return _buildLoading();
    if (index == widget.items.length && noMoreItems) return _buildEndText();
    return widget.items[index];
  }

  _buildLoading() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 10,
      ),
      child: Center(
        child: CupertinoActivityIndicator(
          color: widget.loadingIndicatorColor,
          radius: widget.loadingIndicatorRadius,
        ),
      ),
    );
  }

  _buildEndText() {
    return Center(
      child: widget.noMoreData,
    );
  }
}
