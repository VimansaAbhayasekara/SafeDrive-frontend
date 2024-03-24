class ServiceRequests {
  final String vehicleMake;
  final String vehicleModel;
  final String serviceCenter;
  final String specificServices;
  final String dateTime;
  final String timeSlot;
  final String userEmail;
  final String status;

  ServiceRequests({
    required this.vehicleMake,
    required this.vehicleModel,
    required this.serviceCenter,
    required this.specificServices,
    required this.dateTime,
    required this.timeSlot,
    required this.userEmail,
    required this.status,
  });

  factory ServiceRequests.fromJson(Map<String, dynamic> json) {
    return ServiceRequests(
      vehicleMake: json['vehicleMake'] ?? '', // Provide a default empty string if 'vehicleMake' is null
      vehicleModel: json['vehicleModel'] ?? '', // Provide a default empty string if 'vehicleModel' is null
      serviceCenter: json['serviceCenter'] ?? '', // Provide a default empty string if 'serviceCenter' is null
      specificServices: json['specificServices'] ?? '', // Provide a default empty string if 'specificServices' is null
      dateTime: json['dateTime'] ?? '', // Provide a default empty string if 'dateTime' is null
      timeSlot: json['timeSlot'] ?? '', // Provide a default empty string if 'timeSlot' is null
      userEmail: json['userEmail'] ?? '',
      status: json['status']??'',
    );
  }
}
