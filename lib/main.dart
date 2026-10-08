import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= PALET WARNA =================
class AppColors {
  static const navy = Color(0xFF101C3A);
  static const navy2 = Color(0xFF1B2D5C);
  static const gold = Color(0xFFD4B06A);
  static const goldSoft = Color(0xFFE8D4A2);
  static const goldDeep = Color(0xFFB98D3F);
  static const ivory = Color(0xFFFAF6EC);
  static const ink = Color(0xFF14213D);
  static const muted = Color(0xFF6B7390);
  static const page = Color(0xFFECEAE4);
}

const List<String> _serifFallback = ['Georgia', 'Times New Roman', 'serif'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profil Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.navy2),
        scaffoldBackgroundColor: AppColors.page,
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controller untuk input teks
  final TextEditingController _nameController =
      TextEditingController(text: "SAEFUL AL FATH");
  final TextEditingController _prodiController =
      TextEditingController(text: "Teknologi Rekayasa Multimedia");
  final TextEditingController _npmController =
      TextEditingController(text: "B01220053");

  // Variable untuk semester
  int _currentSemester = 1;

  // Fungsi untuk menambah / mengurangi semester
  void _updateSemester(int delta) {
    setState(() {
      _currentSemester += delta;
      // Membatasi semester minimal 1
      if (_currentSemester < 1) _currentSemester = 1;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _prodiController.dispose();
    _npmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kartu Profil Mahasiswa"),
        centerTitle: true,
        backgroundColor: AppColors.navy,
        foregroundColor: AppColors.goldSoft,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ================= KARTU IDENTITAS (POSISI ATAS) =================
            Center(
              child: StudentIdCard(
                name: _nameController.text,
                semester: _currentSemester,
                npm: _npmController.text,
                prodi: _prodiController.text,
              ),
            ),

            const SizedBox(height: 28),

            // ================= FORM INPUT PROFIL (POSISI BAWAH) =================
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Input Data Profil",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: "Nama Lengkap",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _prodiController,
                      decoration: const InputDecoration(
                        labelText: "Program Studi (Prodi)",
                        prefixIcon: Icon(Icons.school),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _npmController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "NPM / ID No",
                        prefixIcon: Icon(Icons.badge),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (val) => setState(() {}),
                    ),
                    const SizedBox(height: 16),
                    // Pengatur Semester
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Semester:",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => _updateSemester(-1),
                              icon: const Icon(Icons.remove_circle_outline),
                              color: Colors.red,
                            ),
                            Text(
                              '$_currentSemester',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              onPressed: () => _updateSemester(1),
                              icon: const Icon(Icons.add_circle_outline),
                              color: Colors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
//                         KARTU MAHASISWA ELEGAN
// =====================================================================
class StudentIdCard extends StatelessWidget {
  final String name;
  final int semester;
  final String npm;
  final String prodi;

  const StudentIdCard({
    super.key,
    required this.name,
    required this.semester,
    required this.npm,
    required this.prodi,
  });

  // Mengubah "SAEFUL AL FATH" menjadi "Saeful Al Fath"
  String _titleCase(String s) {
    return s
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final displayName = name.trim().isEmpty ? "Nama Mahasiswa" : _titleCase(name);

    return Container(
      width: 340,
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x73101C3A),
            blurRadius: 40,
            spreadRadius: -12,
            offset: Offset(0, 24),
          ),
          BoxShadow(
            color: Color(0x40101C3A),
            blurRadius: 18,
            spreadRadius: -8,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Column(
              children: [
                _buildHeaderWithPhoto(),
                // Ruang untuk bagian foto yang menjorok ke bawah
                const SizedBox(height: 66),

                // Nama & Semester
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    displayName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'serif',
                      fontFamilyFallback: _serifFallback,
                      fontSize: 30,
                      height: 1.1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF6E9C4), Color(0xFFECD9A2)],
                    ),
                    border: Border.all(color: const Color(0x73B98D3F)),
                  ),
                  child: Text(
                    "Semester $semester",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                      color: Color(0xFF7A5A1C),
                    ),
                  ),
                ),

                // Detail NPM & Prodi
                Padding(
                  padding: const EdgeInsets.fromLTRB(26, 24, 26, 30),
                  child: Column(
                    children: [
                      _DetailRow(
                        label: "NPM",
                        value: npm,
                        spaced: true,
                        showDivider: true,
                      ),
                      _DetailRow(
                        label: "Program studi",
                        value: prodi,
                        showDivider: false,
                      ),
                    ],
                  ),
                ),

                // Aksen emas di bawah kartu
                Container(
                  height: 8,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.navy, AppColors.gold, AppColors.navy],
                    ),
                  ),
                ),
              ],
            ),

            // Bingkai emas tipis di sekeliling kartu
            Positioned.fill(
              child: IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      border: Border.all(color: const Color(0x8CD4B06A)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header navy + logo + foto berbingkai emas
  Widget _buildHeaderWithPhoto() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: _HeaderCurveClipper(),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.navy2, AppColors.navy],
              ),
            ),
            child: Stack(
              children: [
                // Cahaya emas lembut di pojok kanan atas
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.8, -1.1),
                        radius: 1.0,
                        colors: [Color(0x47D4B06A), Color(0x00D4B06A)],
                      ),
                    ),
                  ),
                ),
                // Motif anyaman halus
                Positioned.fill(
                  child: CustomPaint(painter: _WeavePainter()),
                ),
                // Logo + nama universitas
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 80),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/unbo.png', // Sesuaikan dengan path logo Anda
                          height: 55,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.account_balance,
                                  color: AppColors.goldSoft, size: 44),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "UNIVERSITAS BOASH",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'serif',
                            fontFamilyFallback: _serifFallback,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: AppColors.goldSoft,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Foto profil dengan cincin emas
        Positioned(
          bottom: -58,
          child: Container(
            width: 116,
            height: 116,
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFFF3E2B3),
                  AppColors.goldDeep,
                  Color(0xFFF3E2B3),
                  AppColors.goldDeep,
                  Color(0xFFF3E2B3),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x8C101C3A),
                  blurRadius: 24,
                  spreadRadius: -6,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.ivory,
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/saeful.jpg',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Tampilan jika gambar gagal dimuat
                    return Container(
                      width: 100,
                      height: 100,
                      color: AppColors.gold,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 48,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Baris detail: label di kiri, nilai di kanan, garis pemisah tipis
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool spaced;
  final bool showDivider;

  const _DetailRow({
    required this.label,
    required this.value,
    this.spaced = false,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: Color(0x1F14213D)))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: AppColors.muted),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value.isEmpty ? "-" : value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.ink,
                letterSpacing: spaced ? 1.3 : 0,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Memotong sisi bawah header menjadi lengkungan lembut
class _HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const dip = 68.0; // titik kontrol -> puncak lengkung sekitar 34px
    final path = Path()
      ..lineTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height - dip, 0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// Motif garis diagonal halus berwarna emas
class _WeavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0x1FD4B06A)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const gap = 22.0;
    final span = size.width + size.height;
    for (double d = -size.height; d < span; d += gap) {
      canvas.drawLine(Offset(d, 0), Offset(d + size.height, size.height), paint);
      canvas.drawLine(Offset(d + size.height, 0), Offset(d, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}