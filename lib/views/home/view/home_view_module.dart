import 'package:bmi_calculator/views/home/controller/home_controller.dart';
import 'package:bmi_calculator/views/home/view/mobile/mb_home_view.dart';
import 'package:bmi_calculator/widgets/responsive_view_widget.dart';
import 'package:flutter/material.dart';

class HomeViewModule extends StatefulWidget {
  const HomeViewModule({super.key});

  @override
  State<HomeViewModule> createState() => _HomeViewModuleState();
}

class _HomeViewModuleState extends State<HomeViewModule> {
  final HomeController controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveViewWidget(
      phone: MbHomeView(controller: controller), 
      tablet: Center(
        child: Text(
          'Tablet view is not implemented yet.',
        ),
      ),
      web: Center(
        child: Text(
          'Web view is not implemented yet.',
        ),
      ),
    );
  }
}