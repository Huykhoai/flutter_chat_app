import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    return child
        .animate() // Bắt đầu chuỗi hoạt ảnh
        .fadeIn( // Hiệu ứng mờ dần
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: (delay * 1000).toInt()), // Thêm độ trễ trực tiếp ở đây
    )
        .moveY( // Di chuyển trên trục Y
      begin: -30,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      delay: Duration(milliseconds: (delay * 1000).toInt()), // Thêm độ trễ cho moveY
    );
  }
}
