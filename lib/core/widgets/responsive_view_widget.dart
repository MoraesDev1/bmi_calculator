import 'package:flutter/material.dart';

import '../enum/device_type.dart';

class ResponsiveViewWidget extends StatelessWidget {
  final Widget phone;
  final Widget tablet;
  final Widget web;

  const ResponsiveViewWidget({
    super.key,
    required this.phone,
    required this.tablet,
    required this.web,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final DeviceType deviceType = DeviceType.fromDimensions(constraints.maxWidth, constraints.maxHeight);
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: switch (deviceType) {
                DeviceType.phone => phone,
                DeviceType.tablet => tablet,
                DeviceType.web => web,
              },
            );
          },
        ),
      ),
    );
  }
}