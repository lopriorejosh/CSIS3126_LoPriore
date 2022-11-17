class WatchProviders {
  String country;
  String providerName;

  WatchProviders({
    required this.country,
    required this.providerName,
  });

//convert json data to watch providers to add to movie
  /*factory WatchProviders.fromJson(Map<String, dynamic> json) =>
      WatchProvidersFromJson(json);

  Map<String, dynamic> toJson() => _$WatchProvidersToJson(this);
*/
}
