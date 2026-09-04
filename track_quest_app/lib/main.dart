import 'package:flutter/material.dart';

void main() {
  runApp(const EldenQuestApp());
}

// ─────────────────────────────────────────────
// DATA MODELS
// ─────────────────────────────────────────────

class QuestStep {
  final String id;
  final String quest;
  final String title;
  final String description;
  final String region;
  final List<String> warnings;
  final List<String> affectedQuests;

  bool completed;

  QuestStep({
    required this.id,
    required this.quest,
    required this.title,
    required this.description,
    required this.region,
    this.warnings = const [],
    this.affectedQuests = const [],
    this.completed = false,
  });
}

// ─────────────────────────────────────────────
// QUEST DATA
// ─────────────────────────────────────────────

final List<QuestStep> questSteps = [
  QuestStep(
    id: 'melina',
    quest: 'Main Story',
    title: 'Meet Melina',
    description: 'Rest at several Sites of Grace in Limgrave and meet Melina.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'renna',
    quest: 'Ranni',
    title: 'Meet Renna at the Church of Elleh',
    description: 'Return to the Church of Elleh at night and speak with Renna.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'blaidd',
    quest: 'Blaidd',
    title: 'Find Blaidd in Mistwood',
    description: 'Hear Blaidd howling in Mistwood and speak with him after learning the Finger Snap gesture.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'margit',
    quest: 'Main Story',
    title: 'Defeat Margit, the Fell Omen',
    description: 'Defeat Margit at the entrance to Stormveil Castle.',
    region: 'Limgrave',
    warnings: [
      'Progressing through Stormveil can advance several NPC questlines.',
    ],
    affectedQuests: [
      'Nepheli Loux',
      'Rogier',
    ],
  ),

  QuestStep(
    id: 'nepheli',
    quest: 'Nepheli Loux',
    title: 'Meet Nepheli in Stormveil Castle',
    description: 'Find Nepheli in the room near the Secluded Cell Site of Grace.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'rogier',
    quest: 'Rogier',
    title: 'Speak with Sorcerer Rogier',
    description: 'Speak with Rogier in Stormveil Castle.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'rennala',
    quest: 'Main Story',
    title: 'Defeat Rennala, Queen of the Full Moon',
    description: 'Defeat Rennala in the Academy of Raya Lucaria.',
    region: 'Liurnia',
    warnings: [
      'Major story progression.',
      'Make sure you have completed any desired early Liurnia quest steps.',
    ],
    affectedQuests: [
      'Ranni',
      'Sellen',
      'Boc',
    ],
  ),

  QuestStep(
    id: 'ranni',
    quest: 'Ranni',
    title: 'Meet Ranni at Ranni\'s Rise',
    description: 'Travel to the Three Sisters and speak with Ranni.',
    region: 'Liurnia',
  ),

  QuestStep(
    id: 'sellen',
    quest: 'Sellen',
    title: 'Meet Sorceress Sellen',
    description: 'Find Sellen at the Waypoint Ruins and begin her quest.',
    region: 'Limgrave',
  ),

  QuestStep(
    id: 'radahn',
    quest: 'Ranni',
    title: 'Defeat Starscourge Radahn',
    description: 'Travel to Redmane Castle and defeat Starscourge Radahn.',
    region: 'Caelid',
    warnings: [
      'This significantly advances Ranni\'s questline.',
      'The Radahn Festival changes the state of Redmane Castle.',
      'Several NPC questlines can be affected by this progression.',
    ],
    affectedQuests: [
      'Ranni',
      'Blaidd',
      'Alexander',
      'Redmane Castle',
    ],
  ),

  QuestStep(
    id: 'nokron',
    quest: 'Ranni',
    title: 'Enter Nokron, Eternal City',
    description: 'Enter the crater created after defeating Radahn.',
    region: 'Nokron',
    warnings: [
      'This continues Ranni\'s questline.',
      'Make sure you have completed any desired pre-Nokron dialogue.',
    ],
    affectedQuests: [
      'Ranni',
      'Blaidd',
    ],
  ),

  QuestStep(
    id: 'fingerslayer',
    quest: 'Ranni',
    title: 'Obtain the Fingerslayer Blade',
    description: 'Find the Fingerslayer Blade in Nokron and return it to Ranni.',
    region: 'Nokron',
  ),

  QuestStep(
    id: 'altus',
    quest: 'Main Story',
    title: 'Reach the Altus Plateau',
    description: 'Travel to the Altus Plateau.',
    region: 'Altus Plateau',
    warnings: [
      'Reaching certain areas can advance NPC questlines.',
      'Check your active quests before progressing further.',
    ],
    affectedQuests: [
      'Millicent',
      'Corhyn',
      'Goldmask',
    ],
  ),

  QuestStep(
    id: 'leyndell',
    quest: 'Main Story',
    title: 'Enter Leyndell',
    description: 'Enter the Royal Capital.',
    region: 'Leyndell',
    warnings: [
      'Major progression point.',
      'Some NPCs may move or change states after significant story progression.',
    ],
    affectedQuests: [
      'Corhyn',
      'Goldmask',
      'Dung Eater',
    ],
  ),
];

// ─────────────────────────────────────────────
// APP
// ─────────────────────────────────────────────

class EldenQuestApp extends StatelessWidget {
  const EldenQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elden Ring Quest Tracker',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF11110F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC9A227),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const QuestHomePage(),
    );
  }
}

// ─────────────────────────────────────────────
// HOME PAGE
// ─────────────────────────────────────────────

class QuestHomePage extends StatefulWidget {
  const QuestHomePage({super.key});

  @override
  State<QuestHomePage> createState() => _QuestHomePageState();
}

class _QuestHomePageState extends State<QuestHomePage> {
  String selectedRegion = 'All';
  String searchText = '';

  final List<String> regions = [
    'All',
    'Limgrave',
    'Liurnia',
    'Caelid',
    'Nokron',
    'Altus Plateau',
    'Leyndell',
  ];

  List<QuestStep> get filteredSteps {
    return questSteps.where((step) {
      final regionMatches =
          selectedRegion == 'All' || step.region == selectedRegion;

      final searchMatches =
          searchText.isEmpty ||
          step.title.toLowerCase().contains(searchText.toLowerCase()) ||
          step.quest.toLowerCase().contains(searchText.toLowerCase());

      return regionMatches && searchMatches;
    }).toList();
  }

  int get completedCount {
    return questSteps.where((step) => step.completed).length;
  }

  double get progress {
    if (questSteps.isEmpty) return 0;
    return completedCount / questSteps.length;
  }

  void toggleQuest(QuestStep step) {
    setState(() {
      step.completed = !step.completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF191814),
        title: const Row(
          children: [
            Icon(
              Icons.shield,
              color: Color(0xFFC9A227),
            ),
            SizedBox(width: 10),
            Text(
              'Elden Ring Quest Tracker',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          // ─────────────────────────────────
          // PROGRESS HEADER
          // ─────────────────────────────────

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: const Color(0xFF191814),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quest Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 10,
                          backgroundColor: Colors.white12,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(
                            Color(0xFFC9A227),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Text(
                      '$completedCount / ${questSteps.length}',
                      style: const TextStyle(
                        color: Color(0xFFC9A227),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Text(
                  '${(progress * 100).round()}% complete',
                  style: const TextStyle(
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),

          // ─────────────────────────────────
          // SEARCH
          // ─────────────────────────────────

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search quests...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // ─────────────────────────────────
          // REGION FILTER
          // ─────────────────────────────────

          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                final selected = region == selectedRegion;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
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

          const SizedBox(height: 8),

          // ─────────────────────────────────
          // TIMELINE
          // ─────────────────────────────────

          Expanded(
            child: filteredSteps.isEmpty
                ? const Center(
                    child: Text(
                      'No quests found.',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredSteps.length,
                    itemBuilder: (context, index) {
                      final step = filteredSteps[index];

                      return QuestTimelineItem(
                        step: step,
                        isFirst: index == 0,
                        isLast: index == filteredSteps.length - 1,
                        onToggle: () => toggleQuest(step),
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
// TIMELINE ITEM
// ─────────────────────────────────────────────

class QuestTimelineItem extends StatelessWidget {
  final QuestStep step;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onToggle;

  const QuestTimelineItem({
    super.key,
    required this.step,
    required this.isFirst,
    required this.isLast,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline line
          SizedBox(
            width: 35,
            child: Column(
              children: [
                if (!isFirst)
                  Container(
                    width: 2,
                    height: 12,
                    color: Colors.white24,
                  ),

                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: step.completed
                        ? const Color(0xFFC9A227)
                        : Colors.white24,
                    border: Border.all(
                      color: step.completed
                          ? const Color(0xFFC9A227)
                          : Colors.white38,
                      width: 2,
                    ),
                  ),
                  child: step.completed
                      ? const Icon(
                          Icons.check,
                          size: 12,
                          color: Colors.black,
                        )
                      : null,
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: Colors.white24,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Quest card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                color: step.completed
                    ? const Color(0xFF181815)
                    : const Color(0xFF1D1C18),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Quest name
                      Text(
                        step.quest.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFC9A227),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Title
                      Text(
                        step.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: step.completed
                              ? TextDecoration.lineThrough
                              : null,
                          color: step.completed
                              ? Colors.white54
                              : Colors.white,
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Location
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 15,
                            color: Colors.white54,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            step.region,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        step.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),

                      // ─────────────────────
                      // WARNING
                      // ─────────────────────

                      if (step.warnings.isNotEmpty) ...[
                        const SizedBox(height: 15),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.35),
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
                                  SizedBox(width: 6),
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

                              ...step.warnings.map(
                                (warning) => Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '• ',
                                        style: TextStyle(
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          warning,
                                          style: const TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              if (step.affectedQuests.isNotEmpty) ...[
                                const SizedBox(height: 8),

                                const Text(
                                  'AFFECTED QUESTS',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Wrap(
                                  spacing: 6,
                                  runSpacing: 6,
                                  children: step.affectedQuests
                                      .map(
                                        (quest) => Chip(
                                          label: Text(
                                            quest,
                                            style: const TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                          visualDensity:
                                              VisualDensity.compact,
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 12),

                      // ─────────────────────
                      // COMPLETE BUTTON
                      // ─────────────────────

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: onToggle,
                          icon: Icon(
                            step.completed
                                ? Icons.undo
                                : Icons.check,
                          ),
                          label: Text(
                            step.completed
                                ? 'Mark Incomplete'
                                : 'Mark Complete',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}