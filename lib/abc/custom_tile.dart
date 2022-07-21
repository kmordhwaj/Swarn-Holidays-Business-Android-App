
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? icon;
  final Widget subtitle;
  final Widget? trailing;
  final EdgeInsets margin;
  final bool mini;
  final GestureTapCallback onTap;
  final GestureLongPressCallback? onLongPress;

  const CustomTile(
      {Key? key,
      required this.leading,
      required this.title,
      this.icon,
      required this.subtitle,
      this.trailing,
      this.margin = const EdgeInsets.all(0),
      required this.onTap,
      this.onLongPress,
      this.mini = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 8 : 0),
        margin: margin,
        child: Row(
          children: [
            leading,
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: mini ? 8 : 12),
              padding: EdgeInsets.symmetric(vertical: mini ? 3 : 17),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                width: 1,
                //  color: UniversalVariable.separatorcolor
              ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      const SizedBox(height: 4),
                      Row(
                        children: [icon ?? Container(), subtitle],
                      )
                    ],
                  ),
                  trailing ?? Container()
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
