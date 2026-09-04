import 'package:flutter/material.dart';

import "quest_data.dart";

void main() => runApp(const TrackQuestApp());

class TrackQuestApp extends StatelessWidget {
  const TrackQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrackQuest',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF07111F),
        fontFamily: 'sans-serif',
      ),
      home: const QuestListScreen(),
    );
  }
}

class QuestListScreen extends StatefulWidget {
  const QuestListScreen({super.key});

  @override
  State<QuestListScreen> createState() => _QuestListScreenState();
}

class _QuestListScreenState extends State<QuestListScreen> {
  final List<GamePlaythrough> playthroughs = [];

  void addPlaythrough(GamePlaythrough game) {
    setState(() => playthroughs.add(game));
  }

  Future<void> showGamePicker() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF0E1C2F),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Start a playthrough',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              ...premadeGameTemplates.map(
                (template) => ListTile(
                  leading: const Icon(Icons.bolt, color: Color(0xFF54B7FF)),
                  title: Text(template.name),
                  onTap: () {
                    addPlaythrough(template.createPlaythrough());
                    Navigator.pop(sheetContext);
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.add, color: Color(0xFF54B7FF)),
                title: const Text('Custom game'),
                subtitle: const Text('Start with an empty quest list'),
                onTap: () {
                  addPlaythrough(
                    GamePlaythrough(name: 'Custom Game', quests: []),
                  );
                  Navigator.pop(sheetContext);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TRACKQUEST',
                style: TextStyle(
                  color: Color(0xFF54B7FF),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'My Quests',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF2F7FF),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.separated(
                  itemCount: playthroughs.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final game = playthroughs[index];
                    return GameCard(
                      game: game,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EldenRingScreen(game: game),
                          ),
                        );
                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: showGamePicker,
                  icon: const Icon(Icons.add),
                  label: const Text('Add game'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final GamePlaythrough game;
  final VoidCallback onTap;

  const GameCard({super.key, required this.game, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF0E1C2F),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFF1D334D)),
        ),
        child: Row(
          children: [
            const QuestMarker(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${(game.progress * 100).round()}% complete',
                    style: const TextStyle(
                      color: Color(0xFF54B7FF),
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF526A84),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class QuestMarker extends StatelessWidget {
  const QuestMarker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFF112B45),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(Icons.bolt_rounded, color: Color(0xFF54B7FF)),
    );
  }
}

// ─────────────────────────────────────────────
// ELDEN RING SCREEN
// ─────────────────────────────────────────────

class EldenRingScreen extends StatefulWidget {
  final GamePlaythrough game;

  const EldenRingScreen({super.key, required this.game});

  @override
  State<EldenRingScreen> createState() => _EldenRingScreenState();
}

class _EldenRingScreenState extends State<EldenRingScreen> {
  String selectedRegion = 'All';

  final List<String> regions = [
    'All',
    'Limgrave',
    'Liurnia',
    'Caelid',
    'Siofra River',
    'Nokron',
    'Ainsel River',
    'Altus Plateau',
    'Leyndell',
    'Mountaintops of the Giants',
    'Crumbling Farum Azula',
    'Roundtable Hold',
    'Deeproot Depths',
  ];

  // Only show quests matching the selected region.
  List<QuestStep> get filteredQuests {
    if (selectedRegion == 'All') {
      return widget.game.quests;
    }

    return widget.game.quests
        .where((quest) => quest.region == selectedRegion)
        .toList();
  }

  // Count completed quests.
  int get completedCount {
    return widget.game.quests.where((quest) => quest.completed).length;
  }

  // Calculate percentage.
  double get progress {
    if (widget.game.quests.isEmpty) {
      return 0;
    }

    return completedCount / widget.game.quests.length;
  }

  // Complete / uncomplete a quest.
  void toggleQuest(QuestStep quest) {
    setState(() {
      quest.completed = !quest.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1C2F),
        title: Text(
          widget.game.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),

      body: Column(
        children: [
          // ─────────────────────────────────
          // PROGRESS
          // ─────────────────────────────────

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF0E1C2F),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quest Progress',
                  style: TextStyle(
                    color: Color(0xFFF2F7FF),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          backgroundColor: const Color(0xFF1D334D),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Color(0xFF54B7FF),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: Color(0xFF54B7FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  '$completedCount of ${widget.game.quests.length} steps completed',
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),

          // ─────────────────────────────────
          // REGION FILTER
          // ─────────────────────────────────
          SizedBox(
            height: 55,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];

                final selected = region == selectedRegion;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: FilterChip(
                    label: Text(region),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        selectedRegion = region;
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // ─────────────────────────────────
          // QUEST TIMELINE
          // ─────────────────────────────────
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredQuests.length,
              itemBuilder: (context, index) {
                final quest = filteredQuests[index];

                return QuestTimelineCard(
                  quest: quest,
                  allQuests: widget.game.quests,
                  onToggle: () {
                    toggleQuest(quest);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// QUEST TIMELINE CARD
// ─────────────────────────────────────────────
class QuestTimelineCard extends StatelessWidget {
  final QuestStep quest;
  final List<QuestStep> allQuests;
  final VoidCallback onToggle;

  const QuestTimelineCard({
    super.key,
    required this.quest,
    required this.allQuests,
    required this.onToggle,
  });

  QuestStep? findQuestById(String id) {
    for (final q in allQuests) {
      if (q.id == id) {
        return q;
      }
    }
    return null;
  }

  List<QuestStep> get missingRequirements {
    return quest.requires
        .map(findQuestById)
        .where((q) => q != null && !q.completed)
        .cast<QuestStep>()
        .toList();
  }

  bool get isLocked {
    return missingRequirements.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline marker
        SizedBox(
          width: 35,
          child: Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: quest.completed
                      ? const Color(0xFF54B7FF)
                      : isLocked
                      ? const Color(0xFF526A84)
                      : const Color(0xFF1D334D),
                  border: Border.all(
                    color: isLocked
                        ? const Color(0xFF526A84)
                        : const Color(0xFF54B7FF),
                    width: 2,
                  ),
                ),
                child: quest.completed
                    ? const Icon(Icons.check, size: 12, color: Colors.black)
                    : isLocked
                    ? const Icon(Icons.lock, size: 9, color: Colors.white70)
                    : null,
              ),
              Container(width: 2, height: 170, color: const Color(0xFF1D334D)),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Quest card
        Expanded(
          child: Card(
            color: isLocked ? const Color(0xFF0A1625) : const Color(0xFF0E1C2F),
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quest name
                  Text(
                    quest.quest.toUpperCase(),
                    style: const TextStyle(
                      color: Color(0xFF54B7FF),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Quest title
                  Text(
                    quest.title,
                    style: TextStyle(
                      color: quest.completed
                          ? Colors.white38
                          : isLocked
                          ? Colors.white54
                          : const Color(0xFFF2F7FF),
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: quest.completed
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: Color(0xFF54B7FF),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        quest.region,
                        style: const TextStyle(
                          color: Color(0xFF54B7FF),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    quest.description,
                    style: const TextStyle(color: Colors.white70, height: 1.4),
                  ),

                  // LOCKED / REQUIREMENTS
                  if (!quest.completed && isLocked) ...[
                    const SizedBox(height: 14),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.withOpacity(0.35)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                color: Colors.redAccent,
                                size: 19,
                              ),
                              SizedBox(width: 7),
                              Text(
                                'LOCKED',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'Complete these steps first:',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 6),

                          ...missingRequirements.map(
                            (requiredQuest) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '• ',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  Expanded(
                                    child: Text(
                                      requiredQuest.title,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // WARNING
                  if (quest.warnings.isNotEmpty) ...[
                    const SizedBox(height: 14),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.orange.withOpacity(0.4),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.orange,
                                size: 20,
                              ),
                              SizedBox(width: 7),
                              Text(
                                'WARNING',
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          ...quest.warnings.map(
                            (warning) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                '• $warning',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),

                          // Affected quests
                          if (quest.affects.isNotEmpty) ...[
                            const SizedBox(height: 8),

                            const Text(
                              'AFFECTED QUESTS',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: quest.affects
                                  .map(
                                    (affected) => Chip(
                                      label: Text(
                                        affected,
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 14),

                  // Complete button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: isLocked ? null : onToggle,
                      icon: Icon(quest.completed ? Icons.undo : Icons.check),
                      label: Text(
                        quest.completed
                            ? 'Mark Incomplete'
                            : isLocked
                            ? 'Locked'
                            : 'Mark Complete',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
