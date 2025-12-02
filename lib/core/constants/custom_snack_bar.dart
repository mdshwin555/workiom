import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'app_colors.dart';

class CustomSnackBar {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void show(BuildContext context,
      {required String message, bool isError = false}) {
    if (_overlayEntry != null) {
      _removeSnackBar();
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 14.h,
        left: 5.w,
        right: 5.w,
        child: Material(
          color: Colors.transparent,
          child: _TopSnackBarWidget(
            message: message,
            isError: isError,
            onDismiss: _removeSnackBar,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    _timer = Timer(const Duration(seconds: 3), () {
      _removeSnackBar();
    });
  }

  static void _removeSnackBar() {
    _timer?.cancel();
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _TopSnackBarWidget extends StatefulWidget {
  final String message;
  final bool isError;
  final VoidCallback onDismiss;

  const _TopSnackBarWidget({
    required this.message,
    required this.isError,
    required this.onDismiss,
  });

  @override
  State<_TopSnackBarWidget> createState() => _TopSnackBarWidgetState();
}

class _TopSnackBarWidgetState extends State<_TopSnackBarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: GestureDetector(
        onTap: () {
          widget.onDismiss();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 3.w),
          decoration: BoxDecoration(
            color: widget.isError ? AppColors.errorRed : AppColors.successGreen,
            borderRadius: BorderRadius.circular(15.sp),
            boxShadow: [
              BoxShadow(
                color: AppColors.textDark.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                widget.isError
                    ? Icons.error_outline
                    : Icons.check_circle_outline,
                color: AppColors.lightBackground,
                size: 20.sp,
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.lightBackground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
