part of 'place_bloc.dart';

sealed class PlaceEvent extends Equatable {
  const PlaceEvent();

  @override
  List<Object> get props => [];
}

class SetLoadingEvent extends PlaceEvent{}

class SetPlaceEvent extends PlaceEvent{
    final String country;
    final String state;
    final String city;
    final String address;
    final String zip;
    const SetPlaceEvent(this.country, this.state, this.city, this.address, this.zip);

    @override
    List<Object> get props => [country, state, city, address, zip];
}

class SetErrorPlaceEvent extends PlaceEvent{
    final String message;
    const SetErrorPlaceEvent(this.message);

    @override
    List<Object> get props => [message];
}

class SetErrorLocationEvent extends PlaceEvent{
    final String message;
    const SetErrorLocationEvent(this.message);

    @override
    List<Object> get props => [message];
}