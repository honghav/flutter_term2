import 'package:flutter_ronanii/part2/lib/model/ride/ride.dart';
import 'package:flutter_ronanii/part2/lib/model/ride_pref/ride_pref.dart';
import 'package:flutter_ronanii/part2/lib/service/rides_service.dart';

abstract class RidesRepository {
  List<Ride> getRides(RidePreference preference, RidesFilter? filter);
}