import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final progress = GameProgress();
  await progress.load();
  runApp(DetectiveGame(progress: progress));
}

const gold = Color(0xFFD8B15A);
const navy = Color(0xFF101827);
const panel = Color(0xFF1B2638);
const muted = Color(0xFF9EABC0);

class Suspect {
  final String id;
  final String name;
  final String role;
  final String motive;
  final String alibi;
  final String secret;
  final IconData icon;
  const Suspect({
    required this.id,
    required this.name,
    required this.role,
    required this.motive,
    required this.alibi,
    required this.secret,
    required this.icon,
  });
}

class Clue {
  final String id;
  final String title;
  final String location;
  final String description;
  final IconData icon;
  const Clue(this.id, this.title, this.location, this.description, this.icon);
}

class CaseFile {
  final String id;
  final String title;
  final String subtitle;
  final String briefing;
  final String solution;
  final String explanation;
  final String culpritId;
  final List<Suspect> suspects;
  final List<Clue> clues;
  final List<String> locations;
  const CaseFile({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.briefing,
    required this.solution,
    required this.explanation,
    required this.culpritId,
    required this.suspects,
    required this.clues,
    required this.locations,
  });
}

const missingDiamond = CaseFile(
  id: 'diamond',
  title: 'The Missing Diamond',
  subtitle: 'CASE 001 • GRAND ROYALE HOTEL',
  briefing:
  'At 9:30 PM, the priceless Star of Ethiopia diamond vanished from a locked display case during a private hotel party. Five people were nearby. Investigate the suite, question the suspects, and decide who took it.',
  solution: 'Sophia Bennett',
  explanation:
  'Sophia used her manager access card to enter the display room before the party. The blue cleaning cloth carried a trace of display-case polish, and the service log shows the case alarm was briefly disabled with a manager code. Her claim that she never entered the room contradicts the access record.',
  culpritId: 'sophia',
  locations: ['Display Room', 'Hotel Office', 'Security Desk', 'Grand Hall'],
  suspects: [
    Suspect(
      id: 'richard',
      name: 'Richard Hayes',
      role: 'Hotel Owner',
      motive: 'The hotel is in serious debt, and the diamond was insured for a huge amount.',
      alibi: 'He says he was greeting guests in the Grand Hall.',
      secret: 'He recently increased the insurance policy on the diamond.',
      icon: Icons.business_center,
    ),
    Suspect(
      id: 'isabella',
      name: 'Isabella Moore',
      role: 'Diamond Collector',
      motive: 'She has wanted to own the Star of Ethiopia for years.',
      alibi: 'She says she was on a phone call near the balcony.',
      secret: 'She offered to buy the diamond several times, but was refused.',
      icon: Icons.diamond,
    ),
    Suspect(
      id: 'daniel',
      name: 'Daniel Brooks',
      role: 'Security Guard',
      motive: 'He has unpaid debts and knows the hotel's security system.',
    alibi: 'He says he was watching the camera monitors.',
      secret: 'One camera feed went dark for two minutes during his shift.',
      icon: Icons.security,
    ),
    Suspect(
      id: 'sophia',
      name: 'Sophia Bennett',
      role: 'Hotel Manager',
      motive: 'She has access to staff-only areas and the manager alarm code.',
      alibi: 'She insists she was arranging chairs in the Grand Hall all evening.',
      secret: 'The access log records her card at the display room shortly before the theft.',
      icon: Icons.badge,
    ),
    Suspect(
      id: 'marcus',
      name: 'Marcus Reed',
      role: 'Business Partner',
      motive: 'He and Richard recently argued over a failed investment.',
      alibi: 'He says he left the suite to make a private call.',
      secret: 'He was seen near the service corridor, but says he was looking for a restroom.',
      icon: Icons.person,
    ),
  ],
  clues: [
    Clue(
      'access_log',
      'Manager Access Log',
      'Security Desk',
      'The record shows Sophia Bennett’s manager card opened the display room at 9:12 PM, shortly before the diamond disappeared.',
      Icons.badge,
    ),
    Clue(
      'blue_cloth',
      'Blue Cleaning Cloth',
      'Display Room',
      'A blue cloth is tucked behind the display pedestal. It carries the same polish used to clean the diamond case.',
      Icons.cleaning_services,
    ),
    Clue(
      'alarm_record',
      'Alarm Service Record',
      'Hotel Office',
      'The display alarm was disabled for 90 seconds using a manager code. The guard’s console does not show a manual override.',
      Icons.receipt_long,
    ),
    Clue(
      'camera_gap',
      'Camera Blind Spot',
      'Security Desk',
      'A camera feed is missing for two minutes. The system log shows the feed was paused from the manager terminal.',
      Icons.videocam_off,
    ),
    Clue(
      'guest_photo',
      'Party Photograph',
      'Grand Hall',
      'A guest photo taken at 9:15 PM shows Richard and Isabella in the hall. Daniel appears at the security desk. Sophia is absent.',
      Icons.photo_camera,
    ),
  ],
);

const secondCase = CaseFile(
  id: 'painting',
  title: 'The Vanishing Portrait',
  subtitle: 'CASE 002 • ASHFORD MANSION',
  briefing:
  'A rare portrait disappears during a storm at Ashford Mansion. The doors were locked, and only a few guests had access to the gallery. Solve the first case to unlock this investigation.',
  solution: 'Oliver Grant',
  explanation:
  'The gallery key was signed out under Oliver’s name, and a streak of fresh paint on his glove matches the frame repair work. His claim that he never entered the gallery is contradicted by the key register.',
  culpritId: 'oliver',
  locations: ['Art Gallery', 'Library', 'Front Hall', 'Workshop'],
  suspects: [
    Suspect(
      id: 'oliver',
      name: 'Oliver Grant',
      role: 'Art Restorer',
      motive: 'He is secretly selling valuable art to cover his debts.',
      alibi: 'He claims he stayed in the workshop all night.',
      secret: 'The gallery key register has his signature.',
      icon: Icons.brush,
    ),
    Suspect(
      id: 'clara',
      name: 'Clara Ashford',
      role: 'Mansion Owner',
      motive: 'The mansion is facing financial trouble.',
      alibi: 'She says she was reading in the library.',
      secret: 'She recently discussed selling several paintings.',
      icon: Icons.home,
    ),
    Suspect(
      id: 'henry',
      name: 'Henry Cole',
      role: 'Family Lawyer',
      motive: 'The portrait is mentioned in a disputed inheritance.',
      alibi: 'He says he was making a call in the front hall.',
      secret: 'He has a copy of the disputed will.',
      icon: Icons.gavel,
    ),
  ],
  clues: [
    Clue(
      'key_register',
      'Gallery Key Register',
      'Front Hall',
      'Oliver Grant signed out the gallery key at 8:40 PM, despite claiming he stayed in the workshop.',
      Icons.key,
    ),
    Clue(
      'paint_glove',
      'Paint-Stained Glove',
      'Workshop',
      'A glove has fresh gold paint matching the repaired portrait frame.',
      Icons.back_hand,
    ),
    Clue(
      'wet_footprints',
      'Wet Footprints',
      'Art Gallery',
      'Footprints lead from the gallery toward the workshop. The storm makes the trail fresh.',
      Icons.footprint,
    ),
  ],
);

class GameProgress extends ChangeNotifier {
  final Set<String> collected = {};
  final Set<String> interviewed = {};
  final Set<String> solved = {};
  late SharedPreferences _prefs;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    collected.addAll(_prefs.getStringList('collected') ?? []);
    interviewed.addAll(_prefs.getStringList('interviewed') ?? []);
    solved.addAll(_prefs.getStringList('solved') ?? []);
  }

  bool hasClue(String id) => collected.contains(id);
  bool hasInterview(String id) => interviewed.contains(id);
  bool isSolved(String id) => solved.contains(id);
  bool isUnlocked(CaseFile file) => file.id == 'diamond' || isSolved('diamond');

  Future<void> collect(Clue clue) async {
    collected.add(clue.id);
    await _save();
    notifyListeners();
  }

  Future<void> interview(String id) async {
    interviewed.add(id);
    await _save();
    notifyListeners();
  }

  Future<void> solve(String id) async {
    solved.add(id);
    await _save();
    notifyListeners();
  }

  Future<void> reset() async {
    collected.clear();
    interviewed.clear();
    solved.clear();
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    await _prefs.setStringList('collected', collected.toList());
    await _prefs.setStringList('interviewed', interviewed.toList());
    await _prefs.setStringList('solved', solved.toList());
  }
}

class DetectiveGame extends StatelessWidget {
  final GameProgress progress;
  const DetectiveGame({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Detective: The Missing Diamond',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: navy,
          colorScheme: ColorScheme.fromSeed(
            seedColor: gold,
            brightness: Brightness.dark,
            surface: panel,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: navy,
            foregroundColor: Colors.white,
            centerTitle: false,
          ),
          cardTheme: CardThemeData(
            color: panel,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: const BorderSide(color: Color(0xFF303D51)),
            ),
          ),
          useMaterial3: true,
        ),
        home: MainScreen(progress: progress),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final GameProgress progress;
  const MainScreen({super.key, required this.progress});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  CaseFile selectedCase = missingDiamond;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        progress: widget.progress,
        onOpenCase: (file) => setState(() {
          selectedCase = file;
          index = 1;
        }),
        onContinue: () => setState(() => index = 1),
      ),
      InvestigationPage(
        file: selectedCase,
        progress: widget.progress,
        onChooseCase: (file) => setState(() => selectedCase = file),
      ),
      EvidencePage(file: selectedCase, progress: widget.progress),
      SuspectsPage(file: selectedCase, progress: widget.progress),
      DeductionPage(file: selectedCase, progress: widget.progress),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.manage_search, color: gold, size: 28),
            SizedBox(width: 9),
            Flexible(
              child: Text(
                'DETECTIVE FILES',
                style: TextStyle(fontSize: 16, letterSpacing: 2, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Reset game progress',
            onPressed: () => _confirmReset(context),
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        backgroundColor: const Color(0xFF141F30),
        indicatorColor: gold.withValues(alpha: 0.18),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.travel_explore), label: 'Investigate'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), label: 'Evidence'),
          NavigationDestination(icon: Icon(Icons.people_outline), label: 'Suspects'),
          NavigationDestination(icon: Icon(Icons.psychology_alt_outlined), label: 'Deduction'),
        ],
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context) async {
    final answer = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset all progress?'),
        content: const Text('This removes collected clues, interviews, and solved cases from this device.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: const Text('Reset')),
        ],
      ),
    );
    if (answer == true) {
      await widget.progress.reset();
      if (mounted) {
        setState(() {
          selectedCase = missingDiamond;
          index = 0;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Progress reset.')));
      }
    }
  }
}

class HomePage extends StatelessWidget {
  final GameProgress progress;
  final ValueChanged<CaseFile> onOpenCase;
  final VoidCallback onContinue;
  const HomePage({super.key, required this.progress, required this.onOpenCase, required this.onContinue});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xFF29384D), Color(0xFF171F2E), Color(0xFF332B1C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: gold.withValues(alpha: 0.45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.diamond, color: gold, size: 44),
              const SizedBox(height: 18),
              const Text('EVERY CLUE\nTELLS A STORY', style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900, height: 1.1)),
              const SizedBox(height: 10),
              const Text('Observe carefully. Ask the right questions. Trust the evidence.', style: TextStyle(color: muted, height: 1.5)),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: onContinue,
                icon: const Icon(Icons.search),
                label: const Text('Continue investigation'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const SectionHeading(title: 'YOUR CASE FILES', subtitle: 'Choose a mystery to investigate'),
        const SizedBox(height: 10),
        _CaseCard(
          file: missingDiamond,
          unlocked: true,
          solved: progress.isSolved('diamond'),
          onTap: () => onOpenCase(missingDiamond),
        ),
        const SizedBox(height: 12),
        _CaseCard(
          file: secondCase,
          unlocked: progress.isUnlocked(secondCase),
          solved: progress.isSolved('painting'),
          onTap: () {
            if (progress.isUnlocked(secondCase)) {
              onOpenCase(secondCase);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Solve The Missing Diamond to unlock this case.')),
              );
            }
          },
        ),
        const SizedBox(height: 22),
        const SectionHeading(title: 'DETECTIVE RECORD', subtitle: 'Your progress on this device'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _StatCard(icon: Icons.search, value: '${progress.collected.length}', label: 'Clues found')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.forum_outlined, value: '${progress.interviewed.length}', label: 'Interviews')),
            const SizedBox(width: 10),
            Expanded(child: _StatCard(icon: Icons.verified_outlined, value: '${progress.solved.length}', label: 'Cases solved')),
          ],
        ),
      ],
    );
  }
}

class _CaseCard extends StatelessWidget {
  final CaseFile file;
  final bool unlocked;
  final bool solved;
  final VoidCallback onTap;
  const _CaseCard({required this.file, required this.unlocked, required this.solved, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(color: gold.withValues(alpha: 0.13), borderRadius: BorderRadius.circular(16)),
                child: Icon(unlocked ? Icons.folder_open : Icons.lock_outline, color: gold, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(file.subtitle, style: const TextStyle(color: gold, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(file.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(unlocked ? (solved ? 'Case solved • Replay available' : 'Available • Investigation open') : 'Locked • Solve Case 001 first',
                      style: const TextStyle(color: muted, fontSize: 12)),
                ]),
              ),
              Icon(solved ? Icons.check_circle : Icons.chevron_right, color: solved ? Colors.greenAccent : muted),
            ],
          ),
        ),
      ),
    );
  }
}

class InvestigationPage extends StatelessWidget {
  final CaseFile file;
  final GameProgress progress;
  final ValueChanged<CaseFile> onChooseCase;
  const InvestigationPage({super.key, required this.file, required this.progress, required this.onChooseCase});

  @override
  Widget build(BuildContext context) {
    final cluesFound = file.clues.where((c) => progress.hasClue(c.id)).length;
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(title: 'ACTIVE INVESTIGATION', subtitle: 'Search each location for evidence'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF303D51)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.folder_special, color: gold, size: 32),
            const SizedBox(height: 12),
            Text(file.title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(file.briefing, style: const TextStyle(color: muted, height: 1.55)),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(child: Text('$cluesFound of ${file.clues.length} clues discovered', style: const TextStyle(fontWeight: FontWeight.w600))),
              Text('${(cluesFound / file.clues.length * 100).round()}%', style: const TextStyle(color: gold, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: cluesFound / file.clues.length, color: gold, backgroundColor: navy, minHeight: 7),
          ]),
        ),
        const SizedBox(height: 22),
        const SectionHeading(title: 'INVESTIGATE LOCATIONS', subtitle: 'Tap a place and inspect its evidence'),
        const SizedBox(height: 10),
        ...file.locations.map((location) {
          final locationClues = file.clues.where((c) => c.location == location).toList();
          final found = locationClues.where((c) => progress.hasClue(c.id)).length;
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              leading: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(color: gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(_locationIcon(location), color: gold),
              ),
              title: Text(location, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(locationClues.isEmpty ? 'No evidence reported yet' : '$found of ${locationClues.length} clue(s) found'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => _openLocation(context, location, locationClues),
            ),
          );
        }),
        const SizedBox(height: 18),
        const SectionHeading(title: 'CASE SWITCHER', subtitle: 'Change the case you are working on'),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: file.id,
          decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Selected case'),
          items: [
            const DropdownMenuItem(value: 'diamond', child: Text('The Missing Diamond')),
            DropdownMenuItem(
              value: 'painting',
              enabled: progress.isUnlocked(secondCase),
              child: Text(progress.isUnlocked(secondCase) ? 'The Vanishing Portrait' : 'The Vanishing Portrait (locked)'),
            ),
          ],
          onChanged: (value) {
            if (value == 'diamond') onChooseCase(missingDiamond);
            if (value == 'painting' && progress.isUnlocked(secondCase)) onChooseCase(secondCase);
          },
        ),
      ],
    );
  }

  IconData _locationIcon(String location) {
    final value = location.toLowerCase();
    if (value.contains('security')) return Icons.videocam_outlined;
    if (value.contains('office') || value.contains('library')) return Icons.desk_outlined;
    if (value.contains('hall')) return Icons.meeting_room_outlined;
    if (value.contains('gallery') || value.contains('display')) return Icons.diamond_outlined;
    if (value.contains('workshop')) return Icons.handyman_outlined;
    return Icons.location_on_outlined;
  }

  void _openLocation(BuildContext context, String location, List<Clue> clues) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: panel,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(child: Container(width: 42, height: 4, decoration: BoxDecoration(color: muted, borderRadius: BorderRadius.circular(4)))),
            const SizedBox(height: 18),
            Text(location.toUpperCase(), style: const TextStyle(color: gold, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Look closely. Every detail might matter.', style: TextStyle(color: muted)),
            const SizedBox(height: 14),
            if (clues.isEmpty) const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text('You find no obvious evidence here. Consider questioning the suspects.'),
            ),
            ...clues.map((clue) {
              final found = progress.hasClue(clue.id);
              return Card(
                child: ListTile(
                  leading: Icon(clue.icon, color: found ? Colors.greenAccent : gold),
                  title: Text(clue.title),
                  subtitle: Text(found ? 'Already collected' : 'Unexamined evidence'),
                  trailing: found ? const Icon(Icons.check_circle, color: Colors.greenAccent) : const Icon(Icons.search, color: gold),
                  onTap: found ? null : () async {
                    await progress.collect(clue);
                    if (context.mounted) {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
                          icon: const Icon(Icons.assignment_turned_in, color: gold, size: 38),
                          title: Text(clue.title),
                          content: Text(clue.description),
                          actions: [FilledButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Add to evidence locker'))],
                        ),
                      );
                    }
                  },
                ),
              );
            }),
          ]),
        ),
      ),
    );
  }
}

class EvidencePage extends StatelessWidget {
  final CaseFile file;
  final GameProgress progress;
  const EvidencePage({super.key, required this.file, required this.progress});

  @override
  Widget build(BuildContext context) {
    final clues = file.clues.where((clue) => progress.hasClue(clue.id)).toList();
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(title: 'EVIDENCE LOCKER', subtitle: 'Every clue you collect is saved here'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: gold.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
          child: Row(children: [
            const Icon(Icons.inventory_2, color: gold, size: 30),
            const SizedBox(width: 12),
            Expanded(child: Text('${clues.length} / ${file.clues.length} pieces of evidence for ${file.title}', style: const TextStyle(fontWeight: FontWeight.w600))),
          ]),
        ),
        const SizedBox(height: 14),
        if (clues.isEmpty)
          const EmptyState(icon: Icons.search, title: 'No evidence collected yet', message: 'Open Investigate, choose a location, and inspect anything suspicious.')
        else
          ...clues.map((clue) => Card(
            child: ExpansionTile(
              leading: Icon(clue.icon, color: gold),
              title: Text(clue.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(clue.location, style: const TextStyle(color: muted)),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              children: [Align(alignment: Alignment.centerLeft, child: Text(clue.description, style: const TextStyle(height: 1.5)))],
            ),
          )),
        const SizedBox(height: 14),
        const Text('Tip: use the Deduction tab when you are ready to accuse a suspect.', style: TextStyle(color: muted, height: 1.5)),
      ],
    );
  }
}

class SuspectsPage extends StatelessWidget {
  final CaseFile file;
  final GameProgress progress;
  const SuspectsPage({super.key, required this.file, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(title: 'SUSPECT INTERVIEWS', subtitle: 'Everyone has something to hide'),
        const SizedBox(height: 12),
        ...file.suspects.map((suspect) {
          final interviewed = progress.hasInterview('${file.id}_${suspect.id}');
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),
              leading: CircleAvatar(
                radius: 27,
                backgroundColor: gold.withValues(alpha: 0.13),
                child: Icon(suspect.icon, color: gold, size: 27),
              ),
              title: Text(suspect.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('${suspect.role}${interviewed ? ' • Interviewed' : ''}', style: const TextStyle(color: muted)),
              ),
              trailing: Icon(interviewed ? Icons.check_circle : Icons.chat_bubble_outline, color: interviewed ? Colors.greenAccent : gold),
              onTap: () => _interview(context, suspect),
            ),
          );
        }),
      ],
    );
  }

  void _interview(BuildContext context, Suspect suspect) {
    final already = progress.hasInterview('${file.id}_${suspect.id}');
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(suspect.icon, color: gold, size: 38),
        title: Text(suspect.name),
        content: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(suspect.role.toUpperCase(), style: const TextStyle(color: gold, letterSpacing: 1.2, fontSize: 11, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            const Text('POSSIBLE MOTIVE', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(suspect.motive, style: const TextStyle(color: muted, height: 1.4)),
            const SizedBox(height: 12),
            const Text('THEIR STATEMENT', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(suspect.alibi, style: const TextStyle(color: muted, height: 1.4)),
            const SizedBox(height: 12),
            const Text('ADDITIONAL INFORMATION', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(suspect.secret, style: const TextStyle(color: muted, height: 1.4)),
            const SizedBox(height: 12),
            const Text('Detective note: compare this statement with the evidence before making an accusation.', style: TextStyle(fontStyle: FontStyle.italic, height: 1.4)),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Close')),
          if (!already)
            FilledButton(
              onPressed: () async {
                await progress.interview('${file.id}_${suspect.id}');
                if (dialogContext.mounted) Navigator.pop(dialogContext);
                if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${suspect.name} added to interview record.')));
              },
              child: const Text('Record interview'),
            )
          else
            const Padding(padding: EdgeInsets.all(8), child: Text('Interview recorded', style: TextStyle(color: Colors.greenAccent))),
        ],
      ),
    );
  }
}

class DeductionPage extends StatefulWidget {
  final CaseFile file;
  final GameProgress progress;
  const DeductionPage({super.key, required this.file, required this.progress});

  @override
  State<DeductionPage> createState() => _DeductionPageState();
}

class _DeductionPageState extends State<DeductionPage> {
  String? selectedSuspect;

  @override
  void didUpdateWidget(covariant DeductionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.file.id != widget.file.id) selectedSuspect = null;
  }

  @override
  Widget build(BuildContext context) {
    final file = widget.file;
    final found = file.clues.where((c) => widget.progress.hasClue(c.id)).length;
    final interviewed = file.suspects.where((s) => widget.progress.hasInterview('${file.id}_${s.id}')).length;
    final solved = widget.progress.isSolved(file.id);
    final enoughEvidence = found >= (file.id == 'diamond' ? 3 : 2);
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const SectionHeading(title: 'THE DEDUCTION ROOM', subtitle: 'Connect your evidence and make your decision'),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: panel,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: gold.withValues(alpha: 0.35)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(Icons.psychology, color: gold, size: 36),
            const SizedBox(height: 10),
            const Text('Before you accuse...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('A good detective checks evidence, interviews suspects, and looks for contradictions. You need at least ${3} clues for Case 001 or 2 clues for Case 002 to make an accusation.', style: TextStyle(color: muted, height: 1.5)),
            const SizedBox(height: 16),
            _ChecklistLine(label: 'Evidence collected', value: '$found / ${file.clues.length}', complete: enoughEvidence),
            const SizedBox(height: 8),
            _ChecklistLine(label: 'Suspects interviewed', value: '$interviewed / ${file.suspects.length}', complete: interviewed >= 2),
          ]),
        ),
        const SizedBox(height: 20),
        const Text('WHO IS RESPONSIBLE?', style: TextStyle(color: gold, fontWeight: FontWeight.bold, letterSpacing: 1.4)),
        const SizedBox(height: 10),
        ...file.suspects.map((suspect) => RadioListTile<String>(
          value: suspect.id,
          groupValue: selectedSuspect,
          onChanged: solved ? null : (value) => setState(() => selectedSuspect = value),
          activeColor: gold,
          tileColor: panel,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          title: Text(suspect.name, style: const TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(suspect.role, style: const TextStyle(color: muted)),
          secondary: Icon(suspect.icon, color: gold),
        )),
        const SizedBox(height: 14),
        if (solved)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                const Icon(Icons.verified, color: Colors.greenAccent, size: 32),
                const SizedBox(width: 12),
                Expanded(child: Text('Case solved! You can replay the case, review clues, or open the next unlocked case.', style: const TextStyle(height: 1.4))),
              ]),
            ),
          )
        else
          FilledButton.icon(
            onPressed: selectedSuspect == null ? null : () => _accuse(context, selectedSuspect!),
            icon: const Icon(Icons.gavel),
            label: const Text('Make final accusation'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
          ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () => _showSolutionHint(context, file),
          icon: const Icon(Icons.lightbulb_outline),
          label: const Text('Need a hint?'),
        ),
        const SizedBox(height: 8),
        const Text('Warning: a wrong accusation ends this attempt, but you can investigate more and try again.', style: TextStyle(color: muted, fontSize: 12, height: 1.4)),
      ],
    );
  }

  Future<void> _accuse(BuildContext context, String suspectId) async {
    final suspect = widget.file.suspects.firstWhere((s) => s.id == suspectId);
    final correct = suspectId == widget.file.culpritId;
    final found = widget.file.clues.where((c) => widget.progress.hasClue(c.id)).length;
    final enoughEvidence = found >= (widget.file.id == 'diamond' ? 3 : 2);
    if (!enoughEvidence) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Collect more evidence before making an accusation.')));
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(correct ? Icons.verified : Icons.warning_amber_rounded, color: correct ? Colors.greenAccent : Colors.orangeAccent, size: 44),
        title: Text(correct ? 'CASE SOLVED!' : 'WRONG ACCUSATION'),
        content: SingleChildScrollView(
          child: Text(
            correct
                ? 'You correctly identified ${suspect.name}.\n\n${widget.file.explanation}\n\nYou collected $found clues and interviewed ${widget.file.suspects.where((s) => widget.progress.hasInterview('${widget.file.id}_${s.id}')).length} suspects.'
                : '${suspect.name} was not responsible. The evidence does not support your accusation.\n\nReview the clues and interview the suspects again before trying another theory.',
            style: const TextStyle(height: 1.5),
          ),
        ),
        actions: [
          if (!correct)
            TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Back to investigation')),
          if (correct)
            FilledButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Close case')),
        ],
      ),
    );
    if (result == true && correct) {
      await widget.progress.solve(widget.file.id);
    }
  }

  void _showSolutionHint(BuildContext context, CaseFile file) {
    final hint = file.id == 'diamond'
        ? 'Start with the access log and alarm record. Who had manager access, and whose statement conflicts with the time-stamped evidence?'
        : 'Compare the gallery key register with the suspects’ alibis. Who claimed not to enter the gallery?';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.lightbulb, color: gold),
        title: const Text('Detective hint'),
        content: Text(hint, style: const TextStyle(height: 1.5)),
        actions: [FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Got it'))],
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;
  const SectionHeading({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1.1)),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(color: muted, fontSize: 13)),
    ]);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  const _StatCard({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(color: panel, borderRadius: BorderRadius.circular(16), border: Border.all(color: const Color(0xFF303D51))),
      child: Column(children: [
        Icon(icon, color: gold, size: 22),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 3),
        Text(label, textAlign: TextAlign.center, style: const TextStyle(color: muted, fontSize: 10)),
      ]),
    );
  }
}

