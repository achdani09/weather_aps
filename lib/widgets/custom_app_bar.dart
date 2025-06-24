import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onLocationPressed;
  final VoidCallback onRefreshPressed;
  final String title;

  const CustomAppBar({
    Key? key,
    required this.onMenuPressed,
    required this.onLocationPressed,
    required this.onRefreshPressed,
    this.title = 'Weather', // Default title
  }) : super(key: key);
    @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed,
      ),
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: onLocationPressed,
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: onRefreshPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}