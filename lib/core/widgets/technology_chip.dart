import 'package:flutter/material.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../app/theme/app_radius.dart';

// ─────────────────────────────────────────────────────────────────────────────
// TECHNOLOGY CHIP — Technology badge with accent styling
// ─────────────────────────────────────────────────────────────────────────────

class TechnologyChip extends StatelessWidget {
  const TechnologyChip({
    super.key,
    required this.label,
    this.isDark = true,
    this.small = false,
    this.accentColor,
  });

  final String label;
  final bool isDark;
  final bool small;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.accent;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 10 : 12,
        vertical: small ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.radiusPill,
        border: Border.all(color: color.withOpacity(0.25), width: 1),
      ),
      child: Text(
        label,
        style: (small
                ? AppTextStyles.labelSm(isDark: isDark)
                : AppTextStyles.labelMd(isDark: isDark))
            .copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
