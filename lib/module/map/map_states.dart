
abstract class MapStates{}

class MapInitialState extends MapStates{}
class MapLoadingState extends MapStates{}

class MapSuccessState extends MapStates{}
class MapErrorState extends MapStates{
  final String error;
  MapErrorState(this.error);
}

class MapSuccessNearbyWorkState extends MapStates{}
class MapErrorNearbyWorkState extends MapStates{
  final String error;
  MapErrorNearbyWorkState(this.error);
}

class MapSuccessOpenGPSState extends MapStates{}
class MapErrorOpenGPSState extends MapStates{
  final String error;
  MapErrorOpenGPSState(this.error);
}


