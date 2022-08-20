extension ToCelsius on double {
  String unit() {
    return (this - 273.15).toStringAsFixed(2);
  }
}
