import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/l10n/app_localizations_en.dart';

void main() {
  test('English feature card titles capitalize every word', () {
    final l10n = AppLocalizationsEn();
    final titles = [
      l10n.adminPlatformInsightsTitle,
      l10n.adminMarketingAnalyticsTitle,
      l10n.adminAiUsageTitle,
      l10n.adminBugReportsTitle,
      l10n.adminPlatformOperationsTitle,
      l10n.adminPaymentsTitle,
      l10n.adminPromotionsTitle,
      l10n.adminPlatformPlansTitle,
      l10n.adminPlanAnalyticsHeaderTitle,
      l10n.adminModerationQueueTitle,
      l10n.adminUserManagementTitle,
      l10n.adminUserDetailTitle,
      l10n.blocksBlockedUsersTitle,
      l10n.reportBugTitle,
      l10n.coachChatHeaderTitle,
      l10n.coachEnterCodeHeaderTitle,
      l10n.coachInviteCodesTitle,
      l10n.coachProfileTitle,
      l10n.insightsHeaderTitle,
      l10n.marketingBuiltForTitle,
      l10n.notificationsCenterTitle,
      l10n.nutritionInsightTitle,
      l10n.sharingPersonalRecordTitle,
      l10n.subscriptionCurrentPlanLabel,
      l10n.trainingAiBalanceCheckTitle,
      l10n.trainingPlanProgressInsightTitle,
    ];

    expect(l10n.insightsHeaderTitle, 'AI Coach Review');
    for (final title in titles) {
      final uncapitalizedWords = title.split(' ').where((word) {
        final lettersOnly = word.replaceAll(RegExp('[^A-Za-z]'), '');
        return lettersOnly.isNotEmpty &&
            lettersOnly[0] != lettersOnly[0].toUpperCase();
      });
      expect(
        uncapitalizedWords,
        isEmpty,
        reason: 'Every word in "$title" must start with a capital letter.',
      );
    }
  });
}
