class QuestStep {
  final String id;
  final String quest;
  final String title;
  final String region;
  final String description;
  final List<String> warnings;
  final List<String> affects;
  final List<String> requires;
  bool completed;

  QuestStep({
    required this.id,
    required this.quest,
    required this.title,
    required this.region,
    required this.description,
    this.warnings = const [],
    this.affects = const [],
    this.requires = const [],
    this.completed = false,
  });

  QuestStep copyForNewPlaythrough() {
    return QuestStep(
      id: id,
      quest: quest,
      title: title,
      region: region,
      description: description,
      warnings: List.of(warnings),
      affects: List.of(affects),
      requires: List.of(requires),
    );
  }
}

class GameTemplate {
  final String id;
  final String name;
  final List<QuestStep> quests;

  const GameTemplate({
    required this.id,
    required this.name,
    required this.quests,
  });

  GamePlaythrough createPlaythrough({String? name}) {
    return GamePlaythrough(
      name: name ?? this.name,
      templateId: id,
      quests: quests.map((quest) => quest.copyForNewPlaythrough()).toList(),
    );
  }
}

class GamePlaythrough {
  final String name;
  final String? templateId;
  final List<QuestStep> quests;

  GamePlaythrough({required this.name, required this.quests, this.templateId});

  int get completedCount => quests.where((quest) => quest.completed).length;
  double get progress => quests.isEmpty ? 0 : completedCount / quests.length;
}

final List<QuestStep> eldenRingQuests = [
  QuestStep(
    id: 'meet_melina',
    quest: 'Main Story',
    title: 'Meet Melina',
    region: 'Limgrave',
    description:
        'Rest at several Sites of Grace in Limgrave until Melina appears.',
    warnings: [],
    affects: ['Main Story'],
  ),

  QuestStep(
    id: 'meet_ranni',
    quest: 'Ranni',
    title: 'Meet Ranni',
    region: 'Liurnia',
    description:
        'Travel to Ranni\'s Rise and speak with Ranni to begin her questline.',
    warnings: [],
    affects: ['Ranni', 'Blaidd', 'Seluvis'],
    requires: ['meet_melina'],
  ),

  QuestStep(
    id: 'defeat_margit',
    quest: 'Main Story',
    title: 'Defeat Margit, the Fell Omen',
    region: 'Limgrave',
    description: 'Defeat Margit at the entrance to Stormveil Castle.',
    warnings: [],
    affects: ['Main Story'],
    requires: ['meet_melina'],
  ),

  QuestStep(
    id: 'defeat_godrick',
    quest: 'Main Story',
    title: 'Defeat Godrick the Grafted',
    region: 'Limgrave',
    description: 'Defeat Godrick inside Stormveil Castle.',
    warnings: [],
    affects: ['Main Story', 'Nepheli'],
    requires: ['defeat_margit'],
  ),

  QuestStep(
    id: 'meet_blaidd',
    quest: 'Blaidd',
    title: 'Meet Blaidd in Mistwood',
    region: 'Limgrave',
    description: 'Hear Blaidd\'s howl in Mistwood and speak with him after learning how to call him down.',
    warnings: [],
    affects: ['Blaidd', 'Ranni'],
    requires: ['meet_melina'],
  ),

  QuestStep(
    id: 'defeat_radahn',
    quest: 'Ranni',
    title: 'Defeat Starscourge Radahn',
    region: 'Caelid',
    description: 'Travel to Redmane Castle and defeat Starscourge Radahn.',
    warnings: [
      'Defeating Radahn changes the world and opens the path to Nokron.',
    ],
    affects: ['Ranni', 'Blaidd'],
    requires: ['meet_ranni', 'meet_blaidd'],
  ),

  QuestStep(
    id: 'enter_nokron',
    quest: 'Ranni',
    title: 'Enter Nokron',
    region: 'Nokron',
    description: 'Enter the newly accessible underground city of Nokron.',
    warnings: [],
    affects: ['Ranni', 'Blaidd'],
    requires: ['defeat_radahn'],
  ),

  QuestStep(
    id: 'fingerslayer_blade',
    quest: 'Ranni',
    title: 'Give Ranni the Fingerslayer Blade',
    region: 'Nokron',
    description:
        'Find the Fingerslayer Blade in Nokron and return it to Ranni.',
    warnings: ['Giving Ranni the Fingerslayer Blade advances her questline.'],
    affects: ['Ranni', 'Blaidd', 'Seluvis'],
    requires: ['enter_nokron'],
  ),

  QuestStep(
    id: 'defeat_morgott',
    quest: 'Main Story',
    title: 'Defeat Morgott, the Omen King',
    region: 'Leyndell',
    description: 'Reach the Elden Throne and defeat Morgott.',
    warnings: [
      'Progressing beyond Leyndell can affect access to some areas and quests.',
    ],
    affects: ['Main Story'],
    requires: ['defeat_godrick'],
  ),

  QuestStep(
    id: 'defeat_fire_giant',
    quest: 'Main Story',
    title: 'Defeat the Fire Giant',
    region: 'Mountaintops of the Giants',
    description:
        'Travel to the Mountaintops of the Giants and defeat the Fire Giant.',
    warnings: [
      'This is a major story progression point.',
      'Some questlines and areas can become unavailable after later story progression.',
    ],
    affects: ['Main Story'],
    requires: ['defeat_morgott'],
  ),
];

final GameTemplate eldenRingTemplate = GameTemplate(
  id: 'elden_ring',
  name: 'Elden Ring',
  quests: eldenRingQuests,
);

final List<GameTemplate> premadeGameTemplates = [eldenRingTemplate];
