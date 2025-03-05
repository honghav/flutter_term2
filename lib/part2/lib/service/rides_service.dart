
import 'package:flutter_ronanii/part2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter_ronanii/part2/lib/repository/RidesRepository.dart';

import '../dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

////
///   This service handles:
///   - The list of available rides
///

class RidesFilter {
  final bool acceptPets;

  RidesFilter({this.acceptPets = false});
}

////
///   This service handles:
///   - The list of available rides
///
class RidesService {
  static RidesService? _instance;
  RidesRepository? _repository;

  // Private constructor to ensure singleton usage
  RidesService._internal();

  // Singleton instance
  static RidesService get instance {
    _instance ??= RidesService._internal();
    return _instance!;
  }

  // Initializer to set the repository
  void initialize(RidesRepository repository) {
    _repository = repository;
  }

  // Main service method to get rides based on preference and filter
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    if (_repository == null) {
      throw Exception("RidesService is not initialized with a repository.");
    }
    return _repository!.getRides(preference, filter);
  }

  static List<Ride> availableRides = fakeRides;  

  ///
  ///  Return the relevant rides, given the passenger preferences
  ///
  static List<Ride> getRidesFor(RidePreference preferences) {
 
    // For now, just a test
    return availableRides.where( (ride) => ride.departureLocation == preferences.departure && ride.arrivalLocation == preferences.arrival).toList();
  }
}
   