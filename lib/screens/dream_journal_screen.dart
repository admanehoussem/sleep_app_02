import 'package:flutter/material.dart';
import 'package:amalu/models/dream_entry.dart';

class DreamJournalScreen extends StatefulWidget {
  const DreamJournalScreen({super.key});

  @override
  _DreamJournalScreenState createState() => _DreamJournalScreenState();
}

class _DreamJournalScreenState extends State<DreamJournalScreen> {
  List<DreamEntry> dreams = [
    DreamEntry(
      id: '1',
      title: 'Flying Over Mountains',
      content: 'I was soaring through clouds above snow-capped mountains...',
      date: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['flying', 'nature', 'peaceful'],
      moodRating: 5,
    ),
    DreamEntry(
      id: '2',
      title: 'Meeting Old Friends',
      content: 'Reunited with childhood friends in my hometown...',
      date: DateTime.now().subtract(const Duration(days: 2)),
      tags: ['friends', 'nostalgia'],
      moodRating: 4,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dream Journal'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: dreams.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: dreams.length,
              itemBuilder: (context, index) {
                return _buildDreamCard(dreams[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDreamDialog(),
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.nights_stay,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No dreams recorded yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to record your first dream',
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDreamCard(DreamEntry dream) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () => _showDreamDetails(dream),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      dream.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildMoodRating(dream.moodRating),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                dream.content.length > 100
                    ? '${dream.content.substring(0, 100)}...'
                    : dream.content,
                style: TextStyle(
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    spacing: 4,
                    children: dream.tags
                        .take(3)
                        .map((tag) => Chip(
                              label: Text(
                                tag,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: Colors.purple[100],
                            ))
                        .toList(),
                  ),
                  Text(
                    _formatDate(dream.date),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodRating(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 16,
        );
      }),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    return '$difference days ago';
  }

  void _showAddDreamDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    int moodRating = 3;
    List<String> tags = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Record Dream'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Dream Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Dream Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Mood: '),
                    ...List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () => setState(() => moodRating = index + 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Icon(
                            index < moodRating ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 28,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  final newDream = DreamEntry(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    title: titleController.text,
                    content: contentController.text,
                    date: DateTime.now(),
                    moodRating: moodRating,
                  );
                  setState(() => dreams.insert(0, newDream));
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDreamDetails(DreamEntry dream) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(dream.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(dream.content),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Mood: '),
                  _buildMoodRating(dream.moodRating),
                ],
              ),
              const SizedBox(height: 8),
              Text('Date: ${_formatDate(dream.date)}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _editDream(dream);
            },
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }

  void _editDream(DreamEntry dream) {
    // Implementation for editing dreams
    print('Edit dream: ${dream.title}');
  }

  void _showSearchDialog() {
    // Implementation for searching dreams
    print('Search dreams');
  }
}