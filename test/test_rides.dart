import 'package:blablacar/model/ride/locations.dart';
import 'package:blablacar/model/ride/ride.dart';
import 'package:blablacar/services/rides_service.dart';

void main() {
  Location dijon = Location(country: Country.france, name: "Dijon");

  List<Ride> filteredRide = RidesService.filterBy(departure: Location(country: Country.france, name: "Dijon"), seatRequested: 2);
  List<Ride> filterBySeatRequested = RidesService.filterBySeatRequested(2);
  List<Ride> filterByDeparture = RidesService.filterByDeparture(dijon);

  for (Ride ride in filteredRide) {
    print(ride);

  }
  for (Ride ride in filterByDeparture) {
    print(ride);
  }

  for (Ride ride in filterBySeatRequested) {
    print(ride);
  }
}
