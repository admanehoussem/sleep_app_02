import 'package:flutter/material.dart';
import 'dart:async';

class RelaxationScreen extends StatefulWidget {
  const RelaxationScreen({super.key});

  @override
  _RelaxationScreenState createState() => _RelaxationScreenState();
}

class _RelaxationScreenState extends State<RelaxationScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  Timer? _meditationTimer;
  int _meditationSeconds = 0;
  bool _isBreathingActive = false;
  bool _isMeditationActive = false;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _breathingAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _breathingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _meditationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relaxation'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBreathingExerciseCard(),
            const SizedBox(height: 20),
            _buildMeditationCard(),
            const SizedBox(height: 20),
            _buildSoundscapesCard(),
            const SizedBox(height: 20),
            _buildSleepStoriesCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildBreathingExerciseCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Breathing Exercise',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _breathingAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _breathingAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.blue[300]!,
                          Colors.blue[600]!,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _isBreathingActive
                            ? (_breathingController.value < 0.5 ? 'Inhale' : 'Exhale')
                            : 'Breathe',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleBreathing,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(
                _isBreathingActive ? 'Stop' : 'Start Breathing',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Meditation Timer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _formatTime(_meditationSeconds),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimerButton('5 min', 300),
                _buildTimerButton('10 min', 600),
                _buildTimerButton('15 min', 900),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: _toggleMeditation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  _isMeditationActive ? 'Stop' : 'Start Meditation',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerButton(String label, int seconds) {
    return OutlinedButton(
      onPressed: () => setState(() => _meditationSeconds = seconds),
      child: Text(label),
    );
  }

  Widget _buildSoundscapesCard() {
    final soundscapes = [
      {'name': 'Rain', 'icon': Icons.grain},
      {'name': 'Ocean', 'icon': Icons.waves},
      {'name': 'Forest', 'icon': Icons.park},
      {'name': 'White Noise', 'icon': Icons.volume_up},
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Relaxing Soundscapes',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2,
              ),
              itemCount: soundscapes.length,
              itemBuilder: (context, index) {
                final soundscape = soundscapes[index];
                return Card(
                  child: InkWell(
                    onTap: () => _playSoundscape(soundscape['name'] as String),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            soundscape['icon'] as IconData,
                            size: 24,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            soundscape['name'] as String,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStoriesCard() {
    final stories = [
      'Peaceful Mountain Journey',
      'Ocean Waves at Sunset',
      'Forest Walk in Autumn',
      'Stargazing Adventure',
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sleep Stories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...stories.map((story) => ListTile(
                  leading: const Icon(Icons.book, color: Colors.purple),
                  title: Text(story),
                  trailing: const Icon(Icons.play_arrow),
                  onTap: () => _playStory(story),
                )),
          ],
        ),
      ),
    );
  }

  void _toggleBreathing() {
    setState(() {
      _isBreathingActive = !_isBreathingActive;
    });

    if (_isBreathingActive) {
      _breathingController.repeat();
    } else {
      _breathingController.stop();
      _breathingController.reset();
    }
  }

  void _toggleMeditation() {
    setState(() {
      _isMeditationActive = !_isMeditationActive;
    });

    if (_isMeditationActive) {
      _meditationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_meditationSeconds > 0) {
            _meditationSeconds--;
          } else {
            _isMeditationActive = false;
            timer.cancel();
            _showMeditationComplete();
          }
        });
      });
    } else {
      _meditationTimer?.cancel();
    }
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _playSoundscape(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playing $name soundscape')),
    );
  }

  void _playStory(String story) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Playing: $story')),
    );
  }

  void _showMeditationComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Meditation Complete'),
        content: const Text('Great job! You\'ve completed your meditation session.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}