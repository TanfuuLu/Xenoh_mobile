import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/insights/domain/ai_response_models.dart';

void main() {
  group('AI response contracts', () {
    test('parses the expanded coach tip response', () {
      final response = TrainingCoachTipResponse.fromJson({
        'language': 'vi',
        'generatedAt': '2026-08-02T07:30:00Z',
        'cached': true,
        'headline': 'Giữ mức tạ tuần này',
        'category': 'Recovery',
        'insight': 'RPE trung bình đang tăng.',
        'evidence': ['RPE tăng từ 7 lên 8.5', 'Khối lượng tăng 18%'],
        'whyItMatters': 'Tăng tải tiếp có thể làm giảm chất lượng buổi tập.',
        'nextAction': 'Giữ tải và ngủ đủ trong ba ngày tới.',
        'confidence': 'high',
      });

      expect(response.cached, isTrue);
      expect(response.evidence, hasLength(2));
      expect(response.nextAction, contains('Giữ tải'));
      expect(response.generatedAt, DateTime.utc(2026, 8, 2, 7, 30));
    });

    test('parses the new plan review decisions and priorities', () {
      final response = AnalysisPlanReview.fromJson({
        'headline': 'Cần giảm tải có chủ đích',
        'dataSummary': 'Mức hoàn thành tốt nhưng RPE tăng.',
        'goalFit': 'Phù hợp mục tiêu sức mạnh.',
        'deload': {
          'verdict': 'recommended',
          'rationale': 'Mệt mỏi tích lũy cao.',
          'prescription': 'Giảm 30% số hiệp trong một tuần.',
        },
        'loadProgression': {
          'verdict': 'hold',
          'rationale': 'Chưa phục hồi hoàn toàn.',
          'prescription': 'Giữ nguyên mức tạ chính.',
        },
        'rpeGuidance': 'Giữ RPE 7-8.',
        'volumeGuidance': 'Giảm volume phụ trợ.',
        'priorities': ['Ngủ đủ', 'Theo dõi RPE'],
      });

      expect(response.deload.verdict, 'recommended');
      expect(response.loadProgression.prescription, 'Giữ nguyên mức tạ chính.');
      expect(response.priorities, ['Ngủ đủ', 'Theo dõi RPE']);
    });

    test('parses plan progress insight lists', () {
      final response = PlanProgressInsightResponse.fromJson({
        'language': 'en',
        'planName': 'Strength block',
        'generatedAt': '2026-08-02T08:00:00Z',
        'headline': 'Momentum is improving',
        'trajectory': 'improving',
        'summary': 'Completion and volume are trending upward.',
        'whatsWorking': ['Consistent main lifts'],
        'focusAreas': ['Sleep consistency'],
        'nextBlock': ['Add 2.5 kg to squat'],
      });

      expect(response.trajectory, 'improving');
      expect(response.whatsWorking.single, 'Consistent main lifts');
      expect(response.nextBlock.single, 'Add 2.5 kg to squat');
    });

    test('parses coach client brief including suggested message', () {
      final response = CoachClientAiBriefResponse.fromJson({
        'language': 'vi',
        'generatedAt': '2026-08-02T08:00:00Z',
        'cached': false,
        'headline': 'Cần theo dõi phục hồi',
        'attentionLevel': 'medium',
        'progressSummary': 'Tiến độ ổn định nhưng RPE tăng.',
        'risks': ['Thiếu ngủ'],
        'opportunities': ['Ổn định lịch tập'],
        'suggestedMessage': 'Tuần này em giữ nguyên mức tạ nhé.',
      });

      expect(response.attentionLevel, 'medium');
      expect(response.risks, ['Thiếu ngủ']);
      expect(response.suggestedMessage, contains('giữ nguyên mức tạ'));
    });
  });
}
