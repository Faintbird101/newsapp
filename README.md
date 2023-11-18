# mohoro
1. Server in Go (Golang):
Go server acts as an intermediary between my Flutter app and the external News API. Here's a brief overview of how it works:

Fetching Data from News API:

In the Go server code, there's a function (fetchDataFromAPI(apiKey)) responsible for fetching data from the News API. This function is called periodically to keep the data updated.
Saving Data to SQLite Database:

After fetching data from the API, the Go server updates the in-memory data  and saves the data to an SQLite database using the saveDataToFile function. This ensures that the server has the latest data locally.
Serving Data via HTTP:

The Go server exposes an HTTP endpoint (/getData) to serve the data. The getData endpoint sends the locally stored data in response to HTTP requests from my Flutter app.


2. Flutter App:
The Flutter app interacts with the Go server and SQLite database as follows:

Bloc for Fetching Data:

In my Flutter app, you have a Bloc pattern implemented using the GetHotNewsBloc class. This class is responsible for handling data fetching and updating the UI.
Fetching Data from Server:

When the getHotNews method in GetHotNewsBloc is called, it sends a request to the Go server. This request triggers the server to fetch the latest data from the News API, update its local storage (SQLite database), and respond with the updated data.
Displaying Data in Flutter UI:

The Flutter app uses a StreamBuilder to listen for changes in the data stream. When new data is received from the Go server, the UI is updated accordingly. The _buildHotNews method displays the articles in a GridView.


3. Connection Flow:
App Initialization:

The Flutter app initializes the GetHotNewsBloc and calls getHotNews(selectedValue) in its initState. This triggers the Bloc to fetch data from the Go server.
Bloc Requests Data:

The GetHotNewsBloc sends a request to the Go server by calling the getHotNews method. This request contains the selected query, such as "General News."
Go Server Fetches and Updates Data:

The Go server receives the request, fetches the latest data from the News API, and updates its local storage (SQLite database).
Go Server Responds to Flutter App:

After updating the data, the Go server responds to the Flutter app with the updated data.
Flutter App Updates UI:

The StreamBuilder in the Flutter app detects changes in the data stream and rebuilds the UI with the new data.


Summary:
In summary, my Flutter app triggers the Go server to fetch and update data from the News API. The Go server stores the data locally in an SQLite database. The Flutter app listens for changes in the data stream and updates the UI accordingly, providing a seamless user experience with fresh news articles. This architecture ensures that my app remains functional even if the News API is unavailable, and it also reduces the frequency of API requests by storing data locally.
