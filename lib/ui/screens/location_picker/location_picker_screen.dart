import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/services/location_service.dart';
import 'package:blablacar/ui/screens/location_picker/location_tile.dart';
import 'package:blablacar/ui/theme/theme.dart';
import 'package:blablacar/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Location> filteredLocation = LocationsService.availableLocations;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      final query = searchController.text.toLowerCase();

      setState(() {
        filteredLocation = LocationsService.availableLocations
            .where(
              (location) =>
                  location.name.toLowerCase().contains(query) ||
                  location.country.name.toLowerCase().contains(query),
            )
            .toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onLocationSelected(Location location) {
    Navigator.pop(context, location);
  }

  void onClose() {
    setState(() {
      Navigator.pop(context);
    });
  }

  void onClear() {
    searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextField(
              controller: searchController,
              style: BlaTextStyles.label,
              decoration: InputDecoration(
                hintText: "Search city or country",
                prefixIcon: IconButton(
                  onPressed: onClose,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: BlaColors.iconLight,
                  ),
                ),
                suffixIcon: searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: onClear,
                        icon: Icon(Icons.clear, color: BlaColors.iconLight),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.separated(
              itemCount: filteredLocation.length,
              itemBuilder: (context, index) {
                final location = filteredLocation[index];
                return LocationTile(
                  location: location,
                  onPressed: () => onLocationSelected(location),
                );
              },
              separatorBuilder: (context, index) => BlaDivider(),
            ),
          ),
        ],
      ),
    );
  }
}
