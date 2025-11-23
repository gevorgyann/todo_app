import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF007D88);
  static const Color primaryLight = Color(0xFFE3F2FF);

  static const Color background = Color(0xFFF9FAFA);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF5F5F5);

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFADB3BC);

  static const Color border = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFFD1D5DB);

  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFEBF8FF);

  static const Color statusToDo = Color(0xFF6B7280);
  static const Color statusToDoBackground = Color(0xFFF3F4F6);

  static const Color statusInProgress = Color(0xFF007D88);
  static const Color statusInProgressBackground = Color(0xFFE3F2FF);

  static const Color statusInReview = Color(0xFFF59E0B);
  static const Color statusInReviewBackground = Color(0xFFFEF3C7);

  static const Color statusCompleted = Color(0xFF10B981);
  static const Color statusCompletedBackground = Color(0xFFECFDF5);

  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityMedium = Color(0xFFF59E0B);
  static const Color priorityLow = Color(0xFF007D88);

  static const Color shadowLight = Color(0x0F000000);
  static const Color shadowMedium = Color(0x1A000000);

  static const Color buttonDisabled = Color(0xFFE5E7EB);
  static const Color textDisabled = Color(0xFF9CA3AF);

  static Color get primaryWithOpacity10 => primary.withValues(alpha: 0.1);
  static Color get primaryWithOpacity20 => primary.withValues(alpha: 0.2);
  static Color get primaryWithOpacity40 => primary.withValues(alpha: 0.4);

  static Color get errorWithOpacity10 => error.withValues(alpha: 0.1);
  static Color get errorWithOpacity20 => error.withValues(alpha: 0.2);

  static Color get warningWithOpacity10 => warning.withValues(alpha: 0.1);
  static Color get warningWithOpacity20 => warning.withValues(alpha: 0.2);

  static Color get successWithOpacity10 => success.withValues(alpha: 0.1);
  static Color get successWithOpacity20 => success.withValues(alpha: 0.2);

  static Color get infoWithOpacity10 => info.withValues(alpha: 0.1);
  static Color get infoWithOpacity20 => info.withValues(alpha: 0.2);
}