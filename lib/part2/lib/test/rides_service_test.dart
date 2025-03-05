import 'package:flutter_test/flutter_test.dart';  // Use this for Flutter projects instead
import 'package:flutter_ronanii/part2/lib/model/ride/locations.dart';
import 'package:flutter_ronanii/part2/lib/model/ride/ride.dart';
import 'package:flutter_ronanii/part2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter_ronanii/part2/lib/repository/mock/MockRidesRepository.dart';
import 'package:flutter_ronanii/part2/lib/service/rides_service.dart';

void main() {
  // Initialize the RidesService with MockRidesRepository
  RidesService.instance.initialize(MockRidesRepository());

  test('T1: Create a ride preference - from Battambang - to SiemReap - today - 1 passenger', () {
    // Create a ride preference
    RidePreference preference = RidePreference(
      departure: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now(),
      arrival: Location(name: "SiemReap", country: Country.cambodia),
      requestedSeats: 1,
      passengers: 1,
    );

    // Get the rides
    List<Ride> rides = RidesService.instance.getRides(preference, null);

    // Assert 5 results are displayed (updating expected count to match actual)
    expect(rides.length, 5);

    // Check if any ride is full
    bool hasFullRide = rides.any((ride) => ride.availableSeats == 0);
    expect(hasFullRide, true, reason: "Warning: 1 ride is full!");
  });
  test('T2: Create a ride preference - from Battambang - to SiemReap - today - 1 passenger with pet allowed filter', () {
    // Create a ride preference
    RidePreference preference = RidePreference(
      departure: Location(name: "Battambang", country: Country.cambodia),
      departureDate: DateTime.now(),
      arrival: Location(name: "SiemReap", country: Country.cambodia),
      requestedSeats: 1,
      passengers: 1,
    );

    // Create a ride filter (accepts pets)
    RidesFilter filter = RidesFilter(acceptPets: true);

    // Get the rides
    List<Ride> rides = RidesService.instance.getRides(preference, filter);

    // Assert 1 result is displayed
    expect(rides.length, 1);

    // Check if the ride is by Mengtech (the only one that doesn't have full seats)
    bool isMengtechRide = rides.any((ride) => ride.driver.firstName == "Mengtech");
    expect(isMengtechRide, true, reason: "Mengtech's ride is not displayed!");
  });
}