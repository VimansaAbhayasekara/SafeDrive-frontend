class APIResponse {
  final bool status;
  final String message;
  final dynamic data;

  APIResponse(this.status, this.message, {this.data});
}
