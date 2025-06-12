import 'package:flutter/material.dart';

class SleepTrackingScreen extends StatefulWidget {
  const SleepTrackingScreen({super.key});

  @override
  _SleepTrackingScreenState createState() => _SleepTrackingScreenState();
}

class _SleepTrackingScreenState extends State<SleepTrackingScreen> {
  bool _isTracking = false;
  DateTime? _bedtime;
  DateTime? _wakeTime;
  int _sleepQuality = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Tracking'),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTrackingCard(),
            const SizedBox(height: 20),
            _buildSleepStatsCard(),
            const SizedBox(height: 20),
            _buildWeeklyTrendCard(),
            const SizedBox(height: 20),
            _buildSleepTipsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(
              _isTracking ? Icons.bedtime : Icons.bedtime_off,
              size: 64,
              color: _isTracking ? Colors.indigo : Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _isTracking ? 'Sleep Tracking Active' : 'Ready to Track Sleep',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _isTracking
                  ? 'Started at ${_formatTime(_bedtime!)}'
                  : 'Tap to start tracking your sleep',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _toggleSleepTracking,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isTracking ? Colors.red : Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text(
                _isTracking ? 'Stop Tracking' : 'Start Tracking',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepStatsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Last Night\'s Sleep',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Bedtime', '10:30 PM', Icons.bedtime),
                _buildStatItem('Wake Time', '6:45 AM', Icons.wb_sunny),
                _buildStatItem('Duration', '7h 32m', Icons.access_time),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Sleep Phases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildSleepPhaseBar(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPhaseItem('Deep', '2h 15m', Colors.indigo),
                _buildPhaseItem('Light', '4h 20m', Colors.blue),
                _buildPhaseItem('REM', '57m', Colors.purple),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.indigo, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSleepPhaseBar() {
    return Container(
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 30,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 57,
            child: Container(color: Colors.blue),
          ),
          Expanded(
            flex: 13,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseItem(String label, String duration, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeeklyTrendCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Weekly Trend',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTrendBar('Mon', 0.8),
                  _buildTrendBar('Tue', 0.6),
                  _buildTrendBar('Wed', 0.9),
                  _buildTrendBar('Thu', 0.7),
                  _buildTrendBar('Fri', 0.5),
                  _buildTrendBar('Sat', 0.95),
                  _buildTrendBar('Sun', 0.85),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Average: 7h 24m',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendBar(String day, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: 80 * height,
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          day,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSleepTipsCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sleep Tips',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTipItem(
              'Keep a consistent sleep schedule',
              Icons.schedule,
            ),
            _buildTipItem(
              'Avoid screens 1 hour before bed',
              Icons.phone_android,
            ),
            _buildTipItem(
              'Keep your bedroom cool and dark',
              Icons.ac_unit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(String tip, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleSleepTracking() {
    setState(() {
      _isTracking = !_isTracking;
      if (_isTracking) {
        _bedtime = DateTime.now();
      } else {
        _wakeTime = DateTime.now();
        _showSleepSummary();
      }
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _showSleepSummary() {
    if (_bedtime != null && _wakeTime != null) {
      final duration = _wakeTime!.difference(_bedtime!);
      int localSleepQuality = _sleepQuality;
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Sleep Summary'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bedtime: ${_formatTime(_bedtime!)}'),
                Text('Wake Time: ${_formatTime(_wakeTime!)}'),
                Text('Duration: ${duration.inHours}h ${duration.inMinutes % 60}m'),
                const SizedBox(height: 16),
                const Text('How was your sleep quality?'),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    return IconButton(
                      onPressed: () => setState(() => localSleepQuality = index + 1),
                      icon: Icon(
                        index < localSleepQuality ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() => _sleepQuality = localSleepQuality);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      );
    }
  }
}