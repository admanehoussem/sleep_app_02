import 'package:flutter/material.dart';

class SleepTipsScreen extends StatelessWidget {
  static const List<SleepTip> sleepTips = [
    SleepTip(
      title: 'Maintain a Sleep Schedule',
      description: 'Go to bed and wake up at the same time every day, even on weekends.',
      icon: Icons.schedule,
      color: Colors.blue,
    ),
    SleepTip(
      title: 'Create a Bedtime Routine',
      description: 'Develop a relaxing pre-sleep routine to signal your body it\'s time to wind down.',
      icon: Icons.self_improvement,
      color: Colors.purple,
    ),
    SleepTip(
      title: 'Optimize Your Sleep Environment',
      description: 'Keep your bedroom cool, dark, and quiet for the best sleep quality.',
      icon: Icons.bedroom_parent,
      color: Colors.indigo,
    ),
    SleepTip(
      title: 'Limit Screen Time',
      description: 'Avoid screens at least 1 hour before bedtime to reduce blue light exposure.',
      icon: Icons.phone_android,
      color: Colors.orange,
    ),
    SleepTip(
      title: 'Watch Your Diet',
      description: 'Avoid large meals, caffeine, and alcohol close to bedtime.',
      icon: Icons.restaurant,
      color: Colors.green,
    ),
    SleepTip(
      title: 'Exercise Regularly',
      description: 'Regular physical activity can help you fall asleep faster and enjoy deeper sleep.',
      icon: Icons.fitness_center,
      color: Colors.red,
    ),
    SleepTip(
      title: 'Manage Stress',
      description: 'Practice relaxation techniques like meditation or deep breathing.',
      icon: Icons.spa,
      color: Colors.teal,
    ),
    SleepTip(
      title: 'Get Natural Light',
      description: 'Expose yourself to bright light in the morning to help regulate your circadian rhythm.',
      icon: Icons.wb_sunny,
      color: Colors.amber,
    ),
  ];

  const SleepTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tips'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Improve Your Sleep Quality',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Follow these evidence-based tips for better sleep',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: sleepTips.length,
                itemBuilder: (context, index) {
                  final tip = sleepTips[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: tip.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              tip.icon,
                              color: tip.color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tip.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  tip.description,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SleepTip {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const SleepTip({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}