class VehicleMake {
  final String vehicleMakeName;

  VehicleMake({required this.vehicleMakeName});

  factory VehicleMake.fromJson(Map<String, dynamic> json){
    return VehicleMake(
      vehicleMakeName: json['vehicleMakeName'] ?? '', // Provide a default empty string if 'vehicleName' is null
    );
  }
}
