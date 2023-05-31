# weather

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Weather App
This is a Flutter app that displays weather data fetched from an API. It allows users to view weather information for popular cities and search for weather data of specific cities.

## Implemented Features
Weather Data Display: The app fetches weather data from an API based on predefined popular cities (London, Paris, New York, Tokyo) and displays the city name, weather description, weather icon, and temperature in Celsius and Fahrenheit. The weather data is shown in separate sections for each city.

Search Functionality: The app includes a text field where users can enter the name of a city. Upon clicking the "Search" button, the app fetches the weather data for the entered city and displays it as a new section alongside the existing weather data.

UI Styling: The app uses the Flutter Material theme to style the user interface. The primary color is set to deep purple, and the app bar and button color scheme are customized accordingly. The temperature cards have a specific styling with a green background color.

Network Requests: The app utilizes the http package to make API requests for weather data. The DataService class contains methods to fetch weather data based on city names or coordinates.

## Planned Features
Error Handling: Implement error handling mechanisms to handle cases where the API request fails or returns an error. Display appropriate error messages to the user and handle exceptions gracefully.

Weather Forecast: Expand the app to display a multi-day weather forecast for each city. Fetch and display weather data for the upcoming days, including temperature, weather conditions, and icons.

City Suggestions/Autocomplete: Enhance the search functionality by implementing city suggestions or autocomplete functionality. As the user types, provide a list of suggested cities to choose from, making it easier and more efficient to search for specific locations.

Persistent Data: Implement a data persistence mechanism, such as local storage or a database, to store and retrieve previously searched cities or user preferences. This allows users to view their previously searched cities even after closing and reopening the app.

## Known Bugs
The analysis_options.yaml file contains an error. The include file 'package:flutter_lints/flutter.yaml' in 'C:\Users\Prasannakumar Bali\Downloads\Desktop' is causing the issue.
## References
Flutter Documentation: https://docs.flutter.dev/
OpenWeatherMap API: https://openweathermap.org/
Geolocator Package: https://pub.dev/packages/geolocator
HTTP Package: https://pub.dev/packages/http
Stack Overflow: https://stackoverflow.com/
## Design Tools Used
Adobe XD,
Figma
## My interest in UI/UX
I enjoy working on UI/UX design as it plays a crucial role in creating visually appealing and user-friendly Flutter apps. I strive to gather user feedback and continuously improve the UI/UX experience by incorporating features like night mode, reading mode colors, and more.

## App would look like:
https://drive.google.com/file/d/1CqxkXvKtlsACJj0z-FPDBXhVmT8f_SOY/view?usp=sharing


