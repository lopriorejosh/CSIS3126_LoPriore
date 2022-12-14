Recreating this project:

Install the necessary packages/dependencies found inside the pubspec.yaml file

Install a working emulator/connect to an android phone to run

Additional firebase command line interface may be required to run in testing enviornment. This is used for firebase settings inside flutter but may not be required unless changing any of the code. firebase_options.dart holds to configuration settings for firebase. 

Firebase database uses http get/post/streams to add and retrieve data from the database. The firebase configuration file adds the bridge from your project to firebase.

For the movie information, I used themoviedb.org(TMDB) and their api. The api requires an api key that can be found inside the api_constants.dart file. This file also includes numerous endpoints that is used to make specific api calls. This api key is unique and can be used by as many connections as needed so all users can use the same api key.