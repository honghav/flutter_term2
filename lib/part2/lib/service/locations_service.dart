
import 'package:flutter_ronanii/part2/lib/model/ride/locations.dart';
import 'package:flutter_ronanii/part2/lib/repository/LocationsRepository%20.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static  LocationsService? _instance;
  final LocationsRepository repository;


  LocationsService._internal(this.repository){}


  static const List<Location> availableLocations = fakeLocations;
  List<Location> getLocations() {
    return repository.getLocations();
  }
  static void initialize(LocationsRepository repository) {
    if (_instance == null) {
      _instance = LocationsService._internal(repository);
    }
  }

  static LocationsService get instance {
    if (_instance == null) {
      throw Exception("You should initialize your service first. Please call the initialize");
    }
    return _instance!;
  }
 
}