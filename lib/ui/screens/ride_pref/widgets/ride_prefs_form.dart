import 'package:blablacar/ui/screens/location_picker/location_picker_screen.dart';
import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/actions/bla_button.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    // TODO
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onSearched() {}

  void onSelectDeparture() async {
    final selectedLocation = await Navigator.push<Location>(
      context, MaterialPageRoute(
        builder: (context) => LocationPickerScreen(),
      )
    );

    if(selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onSelectArrival() async {
    final selectedLocation = await Navigator.push<Location>(
      context, MaterialPageRoute(
        builder: (context) => LocationPickerScreen(),
      )
    );

    if(selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void pickDate() {}

  void pickSeats() {}

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormTile(
          onPressed: onSelectDeparture,
          icon: Icons.location_on,
          hintText: "Leaving from",
          value: departure,
        ),

        BlaDivider(),

        FormTile(
          onPressed: onSelectArrival,
          icon: Icons.location_on,
          hintText: "Going to",
          value: arrival,
        ),

        BlaDivider(),

        FormTile(
          onPressed: pickDate,
          icon: Icons.calendar_month,
          value: "departureDate",
        ),

        BlaDivider(),

        FormTile(
          onPressed: pickSeats,
          icon: Icons.person,
          value: "requestedSeats",
        ),

        BlaButton(
          onPressed: onSearched,
          buttonText: "Search",
          isPrimaryColor: true,
        ),
      ],
    );
  }
}

class FormTile<T> extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final T? value;
  final String? hintText;
  final String Function(T value)? labelBuilder;

  const FormTile({
    super.key,
    required this.onPressed,
    required this.icon,
    this.value,
    this.hintText,
    this.labelBuilder,
  });

  bool get isPlaceholder => value == null;

  String get displayText {
    if (isPlaceholder) return hintText!;
    if (labelBuilder != null) return labelBuilder!(value as T);
    return value.toString();
  }

  TextStyle get textStyle => BlaTextStyles.body.copyWith(
    color: isPlaceholder ? BlaColors.textLight : null,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: BlaColors.iconLight),
      ),
      title: Text(displayText, style: textStyle),
    );
  }
}
