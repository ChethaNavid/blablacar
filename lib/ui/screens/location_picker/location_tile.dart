import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onPressed;

  const LocationTile({
    super.key,
    required this.location,
    required this.onPressed,
  });

  String get title => location.name;

  String get subtitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //leading: Icon(Icons.access_time, color: BlaColors.iconLight),

      title: Text(title, style: BlaTextStyles.body),
      subtitle: Text(
        subtitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),

      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 16,
      ),

      onTap: onPressed,
    );
  }
}
