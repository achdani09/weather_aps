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