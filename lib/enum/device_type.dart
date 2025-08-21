enum DeviceType {
  phone,
  tablet,
  web;

  /// - aspectRatio entre 0.59 e 0.8: tablet
  /// - aspectRatio menor que 0.59: phone
  /// - aspectRatio maior que 0.8: web
  static DeviceType fromDimensions(double width, double height) {
    final aspectRatio = width / height;
    
    if (aspectRatio < 0.59) {
      return DeviceType.phone;
    } else if (aspectRatio <= 0.8) {
      return DeviceType.tablet;
    } else {
      return DeviceType.web;
    }
  }

  bool get isPhone => this == DeviceType.phone;
  bool get isTablet => this == DeviceType.tablet;
  bool get isWeb => this == DeviceType.web;
}