import 'package:flutter_ronanii/part2/lib/model/ride/locations.dart';
import 'package:flutter_ronanii/part2/lib/model/ride/ride.dart';
import 'package:flutter_ronanii/part2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter_ronanii/part2/lib/model/user/user.dart';
import 'package:flutter_ronanii/part2/lib/repository/RidesRepository.dart';
import 'package:flutter_ronanii/part2/lib/service/rides_service.dart';



class MockRidesRepository implements RidesRepository {
  final List<Ride> _rides = [
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 2)),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 4)),
      driver: User(
        firstName: 'Kannika',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: false,
        acceptsPets: false,  // Not accepting pets
      ),
      availableSeats: 2,
      pricePerSeat: 10.0,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 15)),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 17)),
      driver: User(
        firstName: 'Chaylim',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: false,
        acceptsPets: false,  // Not accepting pets
      ),
      availableSeats: 0,
      pricePerSeat: 12.0,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 1)),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 4)),
      driver: User(
        firstName: 'Mengtech',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: false,
        acceptsPets: false,  // Not accepting pets
      ),
      availableSeats: 1,
      pricePerSeat: 11.0,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 15)),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 17)),
      driver: User(
        firstName: 'Limhao',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: false,
        acceptsPets: true,  // Accepting pets
      ),
      availableSeats: 2,
      pricePerSeat: 14.0,
    ),
    Ride(
      departureLocation: Location(name: 'Battambang', country: Country.cambodia),
      departureDate: DateTime.now().add(Duration(hours: 1)),
      arrivalLocation: Location(name: 'SiemReap', country: Country.cambodia),
      arrivalDateTime: DateTime.now().add(Duration(hours: 4)),
      driver: User(
        firstName: 'Sovanda',
        lastName: '',
        email: '',
        phone: '',
        profilePicture: '',
        verifiedProfile: false,
        acceptsPets: false,  // Not accepting pets
      ),
      availableSeats: 1,
      pricePerSeat: 13.0,
    ),
  ];

  @override
  List<Ride> getRides(RidePreference preference, RidesFilter? filter) {
    var filteredRides = _rides.where((ride) {
      bool matchesPreference = ride.departureLocation == preference.departure &&
          ride.arrivalLocation == preference.arrival;

      // Apply pet filter if specified
      if (filter?.acceptPets != null) {
        if (filter!.acceptPets && ride.driver.acceptsPets) {
          return true;  // Pet is allowed
        }
        if (!filter.acceptPets && !ride.driver.acceptsPets) {
          return true;  // No pets allowed
        }
        return false;  // Pet acceptance doesn't match filter
      }

      return matchesPreference;
    }).toList();

    return filteredRides;
  }
}