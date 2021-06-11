import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  const SideButton(
      {Key key, this.route, this.label, this.icon, this.color, this.alignment})
      : super(key: key);

  final Function route;
  final String label;
  final Icon icon;
  final Color color;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment != null ? alignment : Alignment.center,
      child: TextButton.icon(
        icon: icon,
        onPressed: route,
        label: Text(label),
        style: TextButton.styleFrom(primary: color),
      ),
    );
  }
}
