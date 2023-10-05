import 'package:geolocator/geolocator.dart';

abstract class ILocationService {
  Future<Position> getPosition();

  Future<void> requestPermission();
}
