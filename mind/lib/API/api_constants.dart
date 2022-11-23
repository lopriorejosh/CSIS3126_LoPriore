class ApiConstants {
//the movie db
  static String baseUrl = 'https://api.themoviedb.org/3';
  static String apiKey = '?api_key=ffd47d62f4e4b8d58336acf31f7c2550';
  static String popularMoviesEndpoint = '/movie/popular/';
  static String topRatedMoviesEndpoint = '/movie/top_rated';
  static String imageEndpoint = 'https://image.tmdb.org/t/p';
  static String originalImageEndpoint = '/original';
  static String getMovieDetailsEndpoint = "https://api.themoviedb.org/3/movie/";
  static String searchMovieEndpoint =
      "https://api.themoviedb.org/3/search/movie?api_key={$apiKey}&query="; // + name of movie to find(with + where spaces would be)

//firebase
  static String fireBaseAPIKey = "AIzaSyAHb9_0HtYGJmJs2KCTgkR4gEb4QXJYRuo";
  static String newUserEndpoint =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseAPIKey";

  static String signInUserEndpoint =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$fireBaseAPIKey";

  static String anonomousEndpoint =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseAPIKey";

  static String fireBaseDatabaseUrl =
      "https://mind-e9eba-default-rtdb.firebaseio.com/";

  static String dataBaseUsers = "/users";

  static String addFriend = "";
}
