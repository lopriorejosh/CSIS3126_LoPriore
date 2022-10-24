class ApiConstants {
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = '?api_key=ffd47d62f4e4b8d58336acf31f7c2550';
  static String popularMoviesEndpoint = '/movie/popular/';
  static String imageEndpoint = 'https://image.tmdb.org/t/p';
  static String originalImageEndpoint = '/original';

  static String fireBaseAPIKey = "AIzaSyAHb9_0HtYGJmJs2KCTgkR4gEb4QXJYRuo";
  static String newUserEndpoint =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseAPIKey";
  static String signInUserEndpoint =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$fireBaseAPIKey";
}
