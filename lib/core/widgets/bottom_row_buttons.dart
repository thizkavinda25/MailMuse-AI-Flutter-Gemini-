import 'package:flutter/material.dart';
import 'package:mail_muse/core/constants/app_colors.dart';

class BottomRowButtons extends StatefulWidget {
  final VoidCallback? onClear;
  final VoidCallback? onShare;
  const BottomRowButtons({super.key, this.onClear, this.onShare});

  @override
  State<BottomRowButtons> createState() => _BottomRowButtonsState();
}

class _BottomRowButtonsState extends State<BottomRowButtons> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallDevice = screenWidth < 360;
    final padding = isSmallDevice ? 12.0 : 16.0;
    final fontSize = isSmallDevice ? 14.0 : 16.0;
    final verticalPadding = isSmallDevice ? 12.0 : 16.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: widget.onClear,
              icon: const Icon(Icons.delete_outline, color: Color(0xFF4A5568)),
              label: Text(
                'Clear',
                style: TextStyle(
                  color: const Color(0xFF4A5568),
                  fontSize: fontSize,
                ),
              ),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: verticalPadding),
                side: const BorderSide(
                  color: Color.fromARGB(255, 207, 207, 212),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          SizedBox(width: padding),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton.icon(
                onPressed: widget.onShare,
                icon: const Icon(Icons.share, color: Colors.white),
                label: Text(
                  'Share',
                  style: TextStyle(color: Colors.white, fontSize: fontSize),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
