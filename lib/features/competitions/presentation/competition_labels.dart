import '../../../l10n/app_localizations.dart';

String competitionDisciplineLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'Powerlifting' => l10n.competitionDisciplinePowerlifting,
      'Bodybuilding' => l10n.competitionDisciplineBodybuilding,
      _ => value,
    };

String competitionEventStatusLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'Draft' => l10n.competitionStatusDraft,
      'Published' => l10n.competitionStatusPublished,
      'RegistrationClosed' => l10n.competitionStatusRegistrationClosed,
      'InProgress' => l10n.competitionStatusInProgress,
      'Completed' => l10n.competitionStatusCompleted,
      'Cancelled' => l10n.competitionStatusCancelled,
      _ => value,
    };

String competitionRegistrationStatusLabel(
  AppLocalizations l10n,
  String value,
) => switch (value) {
  'Submitted' => l10n.competitionRegistrationSubmitted,
  'Waitlisted' => l10n.competitionRegistrationWaitlisted,
  'Approved' => l10n.competitionRegistrationApproved,
  'Rejected' => l10n.competitionRegistrationRejected,
  'Withdrawn' => l10n.competitionRegistrationWithdrawn,
  _ => value,
};

String competitionPaymentStatusLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'NotRequired' => l10n.competitionPaymentNotRequired,
      'AwaitingReceipt' => l10n.competitionPaymentAwaitingReceipt,
      'UnderReview' => l10n.competitionPaymentUnderReview,
      'Paid' => l10n.competitionPaymentPaid,
      'ReceiptRejected' => l10n.competitionPaymentReceiptRejected,
      _ => value,
    };

String competitionResultStateLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'Finished' => l10n.competitionResultFinished,
      'Disqualified' => l10n.competitionResultDisqualified,
      'DidNotFinish' => l10n.competitionResultDidNotFinish,
      _ => value,
    };

String organizerStatusLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'Pending' => l10n.competitionOrganizerPending,
      'Approved' => l10n.competitionOrganizerApproved,
      'Rejected' => l10n.competitionOrganizerRejected,
      'Suspended' => l10n.competitionOrganizerSuspended,
      _ => value,
    };

String organizerPermissionLabel(AppLocalizations l10n, String value) =>
    switch (value) {
      'ManageEvent' => l10n.organizerPermissionManageEvent,
      'ManageCategories' => l10n.organizerPermissionManageCategories,
      'ReviewRegistrations' => l10n.organizerPermissionReviewRegistrations,
      'ReviewPayments' => l10n.organizerPermissionReviewPayments,
      'ManageResults' => l10n.organizerPermissionManageResults,
      'ManageStaff' => l10n.organizerPermissionManageStaff,
      _ => value,
    };
