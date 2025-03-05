import 'package:flutter_ronanii/part2/lib/repository/mock/MockLocationsRepository.dart';
import 'package:flutter_ronanii/part2/lib/service/locations_service.dart';

void main() {

  // 1- Intialize service
  LocationsService.initialize(MockLocationsRepository());

  //2 - Use service
  print(LocationsService.instance.getLocations());

}