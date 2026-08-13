//! --- JSON KEYS (The names that Dio sends and receives) ---

class ApiKeys {
  ApiKeys._();

  //? --- Common Response & General Keys ---
  static const String data = 'data';
  static const String errors = 'errors';
  static const String error = 'error';
  static const String message = 'message';

  //? Auth Keys
  static const String authorization = 'Authorization';
}

//! --- API VALUES (Fixed values that the server expects inside the fields) ---

class ApiValues {
  ApiValues._();

  static const String bearer = 'Bearer';
}
