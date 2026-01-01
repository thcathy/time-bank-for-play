import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/theme/colors.dart';
import '../l10n/app_localizations.dart';
import '../utils/time_utils.dart';

/// Displays the current balance with status indicator
class BalanceDisplay extends StatelessWidget {
  final int balance;
  final bool canPlay;
  final bool isWarning;
  final bool isOverdraft;

  const BalanceDisplay({
    super.key,
    required this.balance,
    required this.canPlay,
    required this.isWarning,
    required this.isOverdraft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    // Determine colors based on status
    Color statusColor;
    IconData statusIcon;
    String statusText;

    if (isOverdraft) {
      statusColor = AppColors.error;
      statusIcon = LucideIcons.alertTriangle;
      statusText = l10n?.noPlayTime ?? 'Overdraft – focus to unlock play time';
    } else if (isWarning) {
      statusColor = AppColors.warning;
      statusIcon = LucideIcons.alertCircle;
      statusText = l10n?.lowBalance ?? 'Running low – keep focusing!';
    } else {
      statusColor = isDark ? AppColors.focusDark : AppColors.focusLight;
      statusIcon = LucideIcons.checkCircle;
      statusText = l10n?.youCanPlay ?? 'Ready to play!';
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Balance label
          Text(
            l10n?.balance ?? 'Current Balance',
            style: theme.textTheme.titleSmall?.copyWith(
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 8),

          // Balance amount
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: balance),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Text(
                TimeUtils.formatMinutesWithSign(value),
                style: theme.textTheme.displayMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isOverdraft
                      ? AppColors.error
                      : (isDark ? AppColors.focusDark : AppColors.focusLight),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          // Status indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  statusIcon,
                  size: 16,
                  color: statusColor.withOpacity(0.8),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    statusText,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
