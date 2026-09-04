import 'package:flutter/material.dart';

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

class QuestListScreen extends StatelessWidget {
  const QuestListScreen({super.key});

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
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E1C2F),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFF1D334D)),
                ),
                child: const Row(
                  children: [
                    QuestMarker(),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Game Title',
                            style: TextStyle(
                              color: Color(0xFFF2F7FF),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '0% complete',
                            style: TextStyle(
                              color: Color(0xFF54B7FF),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Color(0xFF526A84),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
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
