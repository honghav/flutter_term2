import 'package:flutter_ronanii/part2/lib/model/ride/locations.dart';
import 'package:flutter_ronanii/part2/lib/repository/LocationsRepository%20.dart';

import '../../dummy_data/dummy_data.dart';

class  MockLocationsRepository extends LocationsRepository{

  final Location phnompenh = Location(name: "Phnom Penh", country: Country.cambodia );
  final Location siemreap =  Location(name: "Siem Reap", country: Country.cambodia );
  final Location battambang =Location(name: "Battambang", country: Country.cambodia );
  final Location sihanoukville = Location(name: "Sihanoukville", country: Country.cambodia );
  final Location kampot = Location(name: "Kampot", country: Country.cambodia );

  @override
  List<Location> getLocations() {
    return [phnompenh,siemreap,battambang,sihanoukville,kampot];
  }
}

