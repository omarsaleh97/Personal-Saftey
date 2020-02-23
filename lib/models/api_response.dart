// T is a generic type parameter, it basically changes itself to match the type of the sent data.
class APIResponse<T> {
  T result;
  bool error;
  String errorMessages;

  APIResponse({this.result, this.errorMessages, this.error = false});
}
