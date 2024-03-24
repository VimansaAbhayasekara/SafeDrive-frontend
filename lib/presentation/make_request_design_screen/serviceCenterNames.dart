class ServiceCenterNames {
  final String serviceCenterNames;

  ServiceCenterNames({required this.serviceCenterNames});

  factory ServiceCenterNames.fromJson(Map<String, dynamic> json){
    return ServiceCenterNames(
      serviceCenterNames: json['names'] ?? '', // Provide a default empty string if 'vehicleName' is null
    );
  }
}
