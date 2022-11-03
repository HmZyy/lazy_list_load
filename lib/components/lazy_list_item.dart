import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ListItemImageSize { LARGE, NORMAL }

class LazyListItem extends StatefulWidget {
  String title;
  String subTitle;
  String image;
  Function? onTap;
  Color loadingIndicatorColor;
  ListItemImageSize listItemImageSize;
  IconData? icon;

  LazyListItem({
    required this.title,
    required this.image,
    this.subTitle = "",
    this.onTap,
    this.loadingIndicatorColor = Colors.blue,
    this.listItemImageSize = ListItemImageSize.NORMAL,
    this.icon,
  });

  @override
  _LazyListItemState createState() => _LazyListItemState();
}

class _LazyListItemState extends State<LazyListItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.listItemImageSize == ListItemImageSize.LARGE) {
      return GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 15.0,
            left: 0.0,
          ),
          height: 220,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 3,
                child: ListItemThumbnail(
                  listItem: widget,
                ),
              ),
              Flexible(
                flex: 4,
                child: ListItemDetails(
                  listItem: widget,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        child: Card(
          margin: const EdgeInsets.only(
            top: 15.0,
            left: 5.0,
            right: 5.0,
          ),
          elevation: 7.0,
          shadowColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListItemThumbnail(
                listItem: widget,
              ),
              Flexible(
                flex: 4,
                child: ListItemDetails(
                  listItem: widget,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class ListItemDetails extends StatelessWidget {
  final LazyListItem listItem;

  static final BoxShadow _cardShadow = BoxShadow(
    offset: const Offset(2, 2),
    color: Colors.grey[300] ?? Colors.grey,
    blurRadius: 7.0,
    spreadRadius: 3.0,
  );

  const ListItemDetails({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listItem.listItemImageSize == ListItemImageSize.LARGE) {
      return Container(
        margin: const EdgeInsets.only(
          right: 3.0,
          top: 20.0,
          bottom: 20.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          ),
          boxShadow: [_cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              listItem.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (listItem.icon != null)
                  Icon(
                    listItem.icon!,
                    color: Colors.grey[600],
                    size: 17.0,
                  ),
                Flexible(
                  child: Text(
                    listItem.subTitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(
          right: 5.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18.0,
            ),
            Text(
              listItem.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (listItem.icon != null)
                  Icon(
                    listItem.icon!,
                    color: Colors.grey[600],
                    size: 17.0,
                  ),
                Flexible(
                  child: Text(
                    listItem.subTitle,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}

//Image widget
class ListItemThumbnail extends StatelessWidget {
  final LazyListItem listItem;

  const ListItemThumbnail({
    Key? key,
    required this.listItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (listItem.listItemImageSize == ListItemImageSize.LARGE) {
      return Container(
        height: 220,
        width: double.infinity,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: CachedNetworkImage(
          imageUrl: listItem.image,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    listItem.loadingIndicatorColor,
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        width: 120.0,
        height: 135.0,
        margin: const EdgeInsets.all(12.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: CachedNetworkImage(
          imageUrl: listItem.image,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    listItem.loadingIndicatorColor,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
