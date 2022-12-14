class WatchProvider {
  String? country;
  String? providerName;
  String? logoPath;

  WatchProvider({this.country, this.providerName, this.logoPath});

//convert json data to watch providers to add to movie
  factory WatchProvider.fromJson(Map<String, dynamic> json) {
    return WatchProvider(
      providerName: json['provider_name'] ?? 'No Provider',
      logoPath: json['logo_path'] ??
          'https://st4.depositphotos.com/17828278/24401/v/600/depositphotos_244011872-stock-illustration-image-vector-symbol-missing-available.jpg',
      country: json['country'] ?? 'N/A',
    );
  }
}
