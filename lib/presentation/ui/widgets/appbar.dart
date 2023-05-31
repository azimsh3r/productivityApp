import 'package:flutter/material.dart';
import 'package:productivityapp/presentation/ui/resources/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.lightPurple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 94,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
