import '../model/ride/ride.dart';
import '../model/user/user.dart';
import '../model/ride/locations.dart';
import '../dummy_data/dummy_data.dart';

class RidesService {
  // Singleton pattern
  static final RidesService _instance = RidesService._internal();
  factory RidesService() => _instance;
  RidesService._internal();

  Future<List<Ride>> getAvailableRides() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Use fakeRides from dummy_data.dart
    return fakeRides.where((ride) => 
      ride.status == RideStatus.published && 
      ride.remainingSeats > 0
    ).toList();
  }

  Future<List<Ride>> searchRides({
    required Location departure,
    required Location arrival,
    required DateTime date,
    required int seats
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    return fakeRides.where((ride) =>
      ride.status == RideStatus.published &&
      ride.departureLocation == departure &&
      ride.arrivalLocation == arrival &&
      ride.departureDate.year == date.year &&
      ride.departureDate.month == date.month &&
      ride.departureDate.day == date.day &&
      ride.remainingSeats >= seats
    ).toList();
  }

  // Get rides created by a specific user
  Future<List<Ride>> getUserRides(User driver) async {
    await Future.delayed(const Duration(seconds: 1));
    return fakeRides.where((ride) => ride.driver == driver).toList();
  }
}