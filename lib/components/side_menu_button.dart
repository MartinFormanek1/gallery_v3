import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  const SideButton({Key key, this.route, this.label, this.icon, this.color})
      : super(key: key);

  final Function route;
  final String label;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: icon,
      onPressed: route,
      label: Text(label),
      style: TextButton.styleFrom(primary: color),
    );
  }
}
