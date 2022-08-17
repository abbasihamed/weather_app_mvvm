class CustomValidation {
 static emptyValidation({String? value}) {
    if (value == null || value.isEmpty) {
      return false;
    }
    return true;
  }
}
