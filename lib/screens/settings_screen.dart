import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _sleepReminders = true;
  bool _dailyJournalReminder = false;
  bool _sleepSounds = true;
  bool _darkMode = false;
  String _language = 'English';
  String _notificationFrequency = 'Daily';
  TimeOfDay _reminderTime = const TimeOfDay(hour: 22, minute: 0);
  double _sleepGoal = 8.0;
  TimeOfDay _bedtime = const TimeOfDay(hour: 23, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  String _journalFormat = 'Text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Profile
          _sectionTitle('User Profile'),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: const Text('Edit Name / Email'),
            subtitle: const Text('John Doe\njohn@example.com'),
            isThreeLine: true,
            trailing: const Icon(Icons.edit),
            onTap: () => _showEditProfileDialog(),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('App Language'),
            subtitle: Text(_language),
            onTap: () => _showLanguageDialog(),
          ),
          const Divider(),

          // Notifications
          _sectionTitle('Notifications'),
          SwitchListTile(
            title: const Text('Enable Sleep Reminders'),
            value: _sleepReminders,
            onChanged: (val) => setState(() => _sleepReminders = val),
          ),
          ListTile(
            title: const Text('Notification Frequency'),
            subtitle: Text(_notificationFrequency),
            onTap: () => _showFrequencyDialog(),
          ),
          ListTile(
            title: const Text('Reminder Time'),
            subtitle: Text(_reminderTime.format(context)),
            onTap: () => _pickTime(context, _reminderTime,
                (t) => setState(() => _reminderTime = t)),
          ),
          const Divider(),

          // Sleep Preferences
          _sectionTitle('Sleep Preferences'),
          ListTile(
            title: const Text('Nightly Sleep Goal'),
            subtitle: Text('${_sleepGoal.toStringAsFixed(1)} hours'),
            onTap: () => _showSleepGoalDialog(),
          ),
          ListTile(
            title: const Text('Ideal Bedtime'),
            subtitle: Text(_bedtime.format(context)),
            onTap: () => _pickTime(
                context, _bedtime, (t) => setState(() => _bedtime = t)),
          ),
          ListTile(
            title: const Text('Ideal Wake-up Time'),
            subtitle: Text(_wakeTime.format(context)),
            onTap: () => _pickTime(
                context, _wakeTime, (t) => setState(() => _wakeTime = t)),
          ),
          SwitchListTile(
            title: const Text('Enable Sleep Sounds/Relaxation Audio'),
            value: _sleepSounds,
            onChanged: (val) => setState(() => _sleepSounds = val),
          ),
          const Divider(),

          // Dream Journal
          _sectionTitle('Dream Journal'),
          SwitchListTile(
            title: const Text('Enable Daily Journal Reminder'),
            value: _dailyJournalReminder,
            onChanged: (val) => setState(() => _dailyJournalReminder = val),
          ),
          ListTile(
            title: const Text('Input Format'),
            subtitle: Text(_journalFormat),
            onTap: () => _showJournalFormatDialog(),
          ),
          const Divider(),

          // Appearance
          _sectionTitle('Appearance'),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkMode,
            onChanged: (val) => setState(() => _darkMode = val),
          ),
          const Divider(),

          // Privacy & Security
          _sectionTitle('Privacy & Security'),
          ListTile(
            title: const Text('Manage Saved Data'),
            leading: const Icon(Icons.cloud),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Delete Account / Personal Data'),
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            onTap: () => _showDeleteAccountDialog(),
          ),
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.logout),
            onTap: () => _showLogoutDialog(),
          ),
          const Divider(),

          // About
          _sectionTitle('About'),
          ListTile(
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('Developer Credits'),
            subtitle: const Text('Developed by AMALU'),
            leading: const Icon(Icons.code),
          ),
          ListTile(
            title: const Text('Contact Support'),
            leading: const Icon(Icons.support_agent),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
      ),
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: const Text('Profile editing UI goes here.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'))
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Select Language'),
        children: [
          SimpleDialogOption(
              child: const Text('English'),
              onPressed: () {
                setState(() => _language = 'English');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('French'),
              onPressed: () {
                setState(() => _language = 'French');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('arabic'),
              onPressed: () {
                setState(() => _language = 'arabic');
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _showFrequencyDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Notification Frequency'),
        children: [
          SimpleDialogOption(
              child: const Text('Daily'),
              onPressed: () {
                setState(() => _notificationFrequency = 'Daily');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('Weekly'),
              onPressed: () {
                setState(() => _notificationFrequency = 'Weekly');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('Off'),
              onPressed: () {
                setState(() => _notificationFrequency = 'Off');
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _showSleepGoalDialog() {
    double tempGoal = _sleepGoal;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Sleep Goal'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: tempGoal,
                min: 4,
                max: 12,
                divisions: 16,
                label: '${tempGoal.toStringAsFixed(1)} h',
                onChanged: (v) => setState(() => tempGoal = v),
              ),
              Text('${tempGoal.toStringAsFixed(1)} hours'),
            ],
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                setState(() => _sleepGoal = tempGoal);
                Navigator.pop(context);
              },
              child: const Text('Save')),
        ],
      ),
    );
  }

  void _pickTime(BuildContext context, TimeOfDay initial,
      ValueChanged<TimeOfDay> onPicked) async {
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked != null) onPicked(picked);
  }

  void _showJournalFormatDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Input Format'),
        children: [
          SimpleDialogOption(
              child: const Text('Text'),
              onPressed: () {
                setState(() => _journalFormat = 'Text');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('Scale'),
              onPressed: () {
                setState(() => _journalFormat = 'Scale');
                Navigator.pop(context);
              }),
          SimpleDialogOption(
              child: const Text('Emojis'),
              onPressed: () {
                setState(() => _journalFormat = 'Emojis');
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(context); /* TODO: Implement delete logic */
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(context); /* TODO: Implement logout logic */
              },
              child: const Text('Log Out')),
        ],
      ),
    );
  }
}
