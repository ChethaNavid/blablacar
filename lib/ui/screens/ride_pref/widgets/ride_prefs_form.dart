import 'package:blablacar/ui/widgets/inputs/location_picker/location_picker_screen.dart';
import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/actions/bla_button.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:blablacar/ui/widgets/inputs/date_picker_screen.dart';
import 'package:blablacar/ui/widgets/inputs/request_seat_screen.dart';
import 'package:blablacar/utils/date_time_utils.dart';
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
    departure = widget.initRidePref?.departure;
    arrival = widget.initRidePref?.arrival;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void onSearched() {}

  void onSelectDeparture() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        departure = selectedLocation;
      });
    }
  }

  void onSelectArrival() async {
    final selectedLocation = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );

    if (selectedLocation != null) {
      setState(() {
        arrival = selectedLocation;
      });
    }
  }

  void swapLocation() {
    setState(() {
      final temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  void onSelectDate() async {
    final selectedDate = await Navigator.push<DateTime>(
      context,
      MaterialPageRoute(builder: (context) => DatePickerScreen(selectedDate: departureDate)),
    );
    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void onRequestSeat() async {
    final requestedSeat = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RequestSeatScreen(requestedSeat: requestedSeats)),
    );
    if (requestedSeat != null) {
      setState(() {
        requestedSeats = requestedSeat;
      });
    }
  }

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
          trailing: (departure != null || arrival != null)
              ? IconButton(
                  onPressed: swapLocation,
                  icon: Icon(Icons.swap_vert),
                  color: BlaColors.primary,
                )
              : null,
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
          onPressed: onSelectDate,
          icon: Icons.calendar_month,
          value: DateTimeUtils.formatDateTime(departureDate),
        ),

        BlaDivider(),

        FormTile(
          onPressed: onRequestSeat,
          icon: Icons.person,
          value: requestedSeats,
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
  final Widget? trailing;

  const FormTile({
    super.key,
    required this.onPressed,
    required this.icon,
    this.value,
    this.hintText,
    this.trailing,
  });

  bool get isPlaceholder => value == null;

  String get displayText {
    if (isPlaceholder) return hintText!;
    return value.toString();
  }

  TextStyle get textStyle => BlaTextStyles.body.copyWith(
    color: isPlaceholder ? BlaColors.textLight : null,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: BlaColors.iconLight),
      title: Text(displayText, style: textStyle),
      trailing: trailing,
      onTap: onPressed,
    );
  }
}
