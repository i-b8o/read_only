import 'package:flutter/material.dart';

class VoiceBtn extends StatelessWidget {
  const VoiceBtn({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.width * 0.12,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          true ? Icons.volume_off_outlined : Icons.volume_up_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
