extension GetWeatherImage on String {
  String toImage() {
    switch (this) {
      case 'Clear':
        return 'assets/clear.png';
      case 'Clouds':
        return 'assets/cloudy.png';
      case 'Rainy':
        return 'assets/rainy.png';
      case 'Snow':
        return 'assets/snow.png';
      case 'Thunderstorm':
        return 'assets/thunderstorm.png';
      default:
        return 'assets/clear.png';
    }
  }
}
