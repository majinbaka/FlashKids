import 'package:flutter/material.dart';

@immutable
class LessonRecommendation {
  const LessonRecommendation({
    required this.moduleId,
    required this.activityId,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String moduleId;
  final String activityId;
  final String title;
  final String description;
  final IconData icon;
}

class RecommendedLessonList extends StatelessWidget {
  const RecommendedLessonList({
    required this.recommendations,
    required this.onSelected,
    super.key,
  });

  final List<LessonRecommendation> recommendations;
  final ValueChanged<LessonRecommendation> onSelected;

  @override
  Widget build(BuildContext context) {
    if (recommendations.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bài học phù hợp hôm nay',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (final recommendation in recommendations) ...[
          Semantics(
            button: true,
            label: '${recommendation.title}. ${recommendation.description}',
            child: Card(
              child: ListTile(
                minVerticalPadding: 12,
                leading: Icon(recommendation.icon),
                title: Text(recommendation.title),
                subtitle: Text(recommendation.description),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap: () => onSelected(recommendation),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }
}
