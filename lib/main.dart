import 'package:flutter/material.dart';
import 'dart:math'; // Untuk mengambil kutipan secara acak
import 'package:audioplayers/audioplayers.dart'; // Tambahan untuk musik

//--- KONFIGURASI WARNA
const Color colorBrownDark = Color(0xFF2D1B10);
const Color colorBrownMedium = Color(0xFF5D4037);
const Color colorGold = Color(0xFFD4AF37);
const Color colorBeige = Color(0xFFF5F5DC);

void main() {
  runApp(const PawitraApp());
}

class PawitraApp extends StatelessWidget {
  const PawitraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pawitra Budaya',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: colorBrownDark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: colorBrownMedium,
          primary: colorGold,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colorGold),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: colorBeige),
          bodyLarge: TextStyle(fontSize: 16, color: colorBeige, height: 1.5),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

//--- DATA GLOBAL & STATE ---
List<Map<String, dynamic>> quizHistory = [];
String globalUserName = "Irviean Yoga M.";
String globalProfilePic = "assets/images/depan.webp";

class CultureContent {
  final String title;
  final String subtitle;
  final String image;
  final String description;
  CultureContent({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.description,
  });
}

final List<CultureContent> cultureData = [
  CultureContent(
    title: "Aksara Jawa",
    subtitle: "Manifestasi Spiritual Manusia",
    image: "assets/images/aksara.webp",
    description:
        "Aksara Jawa atau Hanacaraka bukanlah sekadar deretan fonetik untuk berkomunikasi, melainkan sebuah pusaka intelektual yang merangkum siklus eksistensi makhluk hidup. Setiap guratan aksara menyimpan teologi mendalam mengenai asal-usul manusia (Sangkan) dan tujuan akhir kembali kepada Sang Pencipta (Paran). Legenda tragis antara Dora dan Sembada di atas Gunung Kendeng menjadi pengingat abadi tentang bahaya egoisme dan pentingnya kejujuran dalam mengemban amanah. Mempelajari Aksara Jawa berarti membedah batin, memahami bahwa di balik setiap pertemuan (Ha-Na), selalu ada pertarungan antara nafsu dan nurani (Da-Ta-Sa-Wa-La) sebelum akhirnya raga terurai kembali menjadi elemen semesta (Ma-Ga-Ba-Tha-Nga).",
  ),
  CultureContent(
    title: "Weton & Primbon",
    subtitle: "Harmonisasi Makrokosmos",
    image: "assets/images/weton_primbon.jpg",
    description:
        "Kehidupan masyarakat Jawa tradisional dijalankan atas dasar harmoni dengan ritme alam semesta. Weton merupakan perpaduan presisi antara siklus matahari (hari tujuh) dan siklus bulan atau energi bumi (pasaran lima). Ini adalah sistem metafisika kuno yang digunakan untuk memetakan potensi karakter, fluktuasi rezeki, hingga kompatibilitas energi antarindividu. Dengan memahami Weton, seseorang diajak untuk tidak \"melawan arus\" alam, melainkan berselancar di atasnya dengan penuh perhitungan. Primbon menjadi panduan praktis untuk mencari Hari Baik, sebuah upaya spiritual agar setiap langkah-mulai dari pernikahan hingga membangun hunian-selalu selaras dengan frekuensi keberuntungan alam semesta.",
  ),
  CultureContent(
    title: "Wayang Kulit",
    subtitle: "Cermin Bayang-Bayang Kehidupan",
    image: "assets/images/wayang.jpg",
    description:
        "Wayang Kulit merupakan mahakarya seni pertunjukan yang telah diakui dunia sebagai warisan kemanusiaan. Lebih dari sekadar hiburan, pertunjukan ini adalah upacara ritual pembersihan jiwa atau Ruwat. Di balik layar putih (Kelir) yang melambangkan kekosongan dunia, Dalang berperan sebagai poros semesta yang menggerakkan takdir setiap karakter. Cahaya dari lampu Blencong menciptakan gradasi bayangan yang melambangkan bahwa manusia di dunia hanyalah pantulan dari realitas batin yang lebih tinggi. Kisah-kisah Mahabarata dan Ramayana yang dibawakan bukan sekadar dongeng perang, melainkan metafora tentang pergolakan moral, etika kepemimpinan, dan pencarian jati diri seorang ksatria.",
  ),
  CultureContent(
    title: "Gamelan",
    subtitle: "Simfoni Kerendahan Hati",
    image: "assets/images/gamelan.jpg",
    description:
        "Gamelan Jawa adalah perwujudan auditif dari konsep Tepa Selira atau tenggang rasa. Tidak seperti orkestra barat yang sering kali menonjolkan virtuoso individu, Gamelan menuntut setiap penabuhnya untuk menekan ego demi terciptanya keselarasan (Laras). Suara denting Saron yang tajam diredam oleh gema Gong yang berwibawa, menciptakan suasana meditatif yang membawa pendengarnya ke dalam kondisi Eling (sadar). Setiap frekuensi nada dalam laras Slendro dan Pelog dirancang untuk menyentuh titik-titik emosional manusia, mulai dari kegembiraan yang meluap hingga kesedihan yang paling sunyi, semuanya dibungkus dalam keteraturan irama yang sangat disiplin.",
  ),
  CultureContent(
    title: "Tari Serimpi",
    subtitle: "Simfoni Keanggunan",
    image: "assets/images/tari.jpg",
    description:
        "Tari Serimpi merupakan tarian klasik sakral yang lahir di lingkungan Keraton Mataram Islam. Kata \"Serimpi\" sendiri memiliki akar kata Srimpi yang berarti \"impian\" atau \"suci\". Tarian ini melambangkan keanggunan, kesopanan, dan kontrol diri yang sempurna dari seorang wanita Jawa. Dahulu, tarian ini bersifat sangat eksklusif dan hanya boleh ditarikan di dalam tembok keraton untuk menyambut tamu agung atau upacara kenegaraan tertentu. Kehadiran Tari Serimpi di atas panggung bukan sekadar hiburan visual, melainkan sebuah bentuk meditasi gerak yang menghubungkan alam manusia dengan alam ketuhanan.",
  ),
  CultureContent(
    title: "Rumah Joglo",
    subtitle: "Arsitektur Berbasis Alam",
    image: "assets/images/joglo.jpg",
    description:
        "Rumah Joglo adalah manifestasi dari status sosial sekaligus penghormatan terhadap alam. Puncak atapnya yang menjulang tinggi, yang disebut Tajug, dirancang untuk mengalirkan hawa panas ke atas, menjadikannya prototipe hunian tropis yang cerdas secara termal. Bagian paling sakral, Soko Guru, terdiri dari empat tiang jati solid tanpa sambungan yang melambangkan stabilitas jiwa manusia dalam menghadapi empat penjuru cobaan dunia. Ruang Pendhopo yang terbuka tanpa dinding menjadi simbol demokrasi Jawa; sebuah ruang publik di mana perbedaan strata sosial melebur dalam semangat musyawarah dan keterbukaan tanpa sekat.",
  ),
  CultureContent(
    title: "Keris",
    subtitle: "Bilah Logam Pengikat Jiwa",
    image: "assets/images/keris.jpg",
    description:
        "Keris bukan sekadar senjata tajam untuk bela diri, melainkan simbol kedaulatan diri dan status spiritual bagi pria Jawa. Seorang Empu (pembuat keris) menempa bilah besi dengan campuran nikel meteorit melalui proses ribuan kali lipatan, menciptakan pola Pamor yang unik dan tak tertandingi. Setiap lengkungan atau Luk pada bilah keris memiliki makna esoteris; angka ganjil dipilih karena melambangkan sesuatu yang dinamis, terus bergerak, dan tidak pernah statis. Memiliki keris berarti memegang tanggung jawab moral untuk mengendalikan kekuatan batin agar tidak disalahgunakan, menjadikannya sebuah \"piandel\" atau pegangan hidup yang sangat dihormati.",
  ),
  CultureContent(
    title: "Batik",
    subtitle: "Doa dalam Setiap Titik Malam",
    image: "assets/images/batik.webp",
    description:
        "Batik adalah seni rupa yang lahir dari ketekunan batin dan kesabaran tingkat tinggi. Menulis di atas kain dengan Canting dan cairan Malam panas adalah bentuk meditasi visual. Setiap motif yang tercipta bukanlah sekadar hiasan dekoratif, melainkan kumpulan doa dan harapan yang disematkan oleh pembuatnya. Motif Parang, misalnya, dengan garis diagonalnya yang tegas, melambangkan ombak samudera yang tak pernah berhenti bergerak, menjadi simbol bagi semangat pantang menyerah dan kesinambungan perjuangan. Mengenakan batik berarti mengenakan identitas, sejarah, dan nilai-nilai luhur yang telah diwariskan lintas generasi melalui simbolisme visual yang rumit.",
  ),
  CultureContent(
    title: "Tumpeng",
    subtitle: "Simbolisme Vertikal",
    image: "assets/images/tumpeng.png",
    description:
        "Dalam setiap kenduri atau perayaan syukur, Sego Tumpeng selalu hadir sebagai pusat perhatian. Bentuk kerucut nasi kuning yang menjulang melambangkan Gunung Meru, tempat bersemayamnya para dewa dalam mitologi kuno, atau hubungan vertikal yang sakral antara manusia dengan Tuhan Yang Maha Esa. Lauk-pauk yang tertata rapi melingkar di bawahnya melambangkan keberagaman hasil bumi dan keselarasan hubungan horisontal antarmanusia. Tradisi memotong puncak tumpeng dan memberikannya kepada orang yang paling dihormati adalah bentuk nyata dari etika penghormatan terhadap senioritas dan kearifan yang menjadi pilar masyarakat Jawa.",
  ),
];

// --- SCREENS ---
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset('assets/images/depan.webp',
                  fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: colorBrownDark))),
          Container(color: Colors.black.withOpacity(0.6)),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _fade,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_fade.value * 0.05),
                      child: child,
                    );
                  },
                  child: const Text('PAWITRA', 
                    style: TextStyle(fontSize: 58, fontWeight: FontWeight.bold, color: colorGold, letterSpacing: 8)),
                ),
                const Text('Edukasi Budaya Jawa',
                    style: TextStyle(color: colorBeige, letterSpacing: 4, fontSize: 16)),
                const SizedBox(height: 60),
                _btn(context, 'MASUK', const LoginScreen(), true),
                const SizedBox(height: 20),
                _btn(context, 'DAFTAR AKUN', const RegisterScreen(), false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(BuildContext context, String txt, Widget page, bool primary) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? colorGold : Colors.transparent,
          side: primary ? BorderSide.none : const BorderSide(color: colorGold, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: primary ? 10 : 0,
        ),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => page)),
        child: Text(txt,
            style: TextStyle(color: primary ? colorBrownDark : colorGold, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent, iconTheme: const IconThemeData(color: colorGold)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: colorBrownMedium,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: colorGold.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  const Text('REGISTRASI',
                      style: TextStyle(fontSize: 20, color: colorGold, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  const SizedBox(height: 30),
                  _inputField('Nama Lengkap', Icons.person_outline),
                  const SizedBox(height: 15),
                  _inputField('Email', Icons.alternate_email),
                  const SizedBox(height: 15),
                  _inputField('Password', Icons.lock_outline, obscure: true),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: colorGold, 
                      foregroundColor: colorBrownDark,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('DAFTAR', style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: colorBeige),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: colorGold),
        labelText: label,
        labelStyle: const TextStyle(color: colorGold),
        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: colorBrownMedium)),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sugeng Rawuh', style: TextStyle(fontSize: 32, color: colorGold, fontWeight: FontWeight.bold)),
            const Text('Silakan masuk ke akun Anda', style: TextStyle(color: Colors.white54)),
            const SizedBox(height: 50),
            _loginInput('Username', Icons.account_circle_outlined),
            const SizedBox(height: 20),
            _loginInput('Password', Icons.lock_outline, obscure: true),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorGold, 
                    foregroundColor: colorBrownDark,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (c) => const MainNavigation()), (r) => false),
                child: const Text('LOG IN', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginInput(String label, IconData icon, {bool obscure = false}) {
    return TextField(
      obscureText: obscure,
      style: const TextStyle(color: colorBeige),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white38),
        prefixIcon: Icon(icon, color: colorGold),
        filled: true,
        fillColor: colorBrownMedium,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: colorGold)),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;
  final List<Widget> _tabs = [const HomeScreen(), const QuizEngine(), const WetonCalculatorScreen(), const ProfileScreen()];
  final AudioPlayer _audioPlayer = AudioPlayer(); // Controller Musik

  @override
  void initState() {
    super.initState();
    _startMusic();
  }

  // --- FUNGSI MUSIK ---
  void _startMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Agar musik mengulang
      await _audioPlayer.play(AssetSource('music/GENDING JAWA.mp3')); // Pastikan path benar
    } catch (e) {
      debugPrint("Gagal memutar musik: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Hentikan musik saat keluar
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _idx,
        children: _tabs,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        backgroundColor: colorBrownDark,
        indicatorColor: colorGold.withOpacity(0.2),
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book, color: colorGold), label: 'Materi'),
          NavigationDestination(icon: Icon(Icons.quiz, color: colorGold), label: 'Kuis'),
          NavigationDestination(icon: Icon(Icons.calendar_month, color: colorGold), label: 'Weton'),
          NavigationDestination(icon: Icon(Icons.person, color: colorGold), label: 'Profil'),
        ],
      ),
    );
  }
}

class WetonCalculatorScreen extends StatefulWidget {
  const WetonCalculatorScreen({super.key});

  @override
  State<WetonCalculatorScreen> createState() => _WetonCalculatorScreenState();
}

class _WetonCalculatorScreenState extends State<WetonCalculatorScreen> {
  DateTime? _selectedDate;
  String _wetonResult = "Silakan pilih tanggal lahir Anda.";
  String _wetonDescription = "";

  // Data neptu hari dan pasaran
  final Map<int, int> _neptuHari = {
    DateTime.sunday: 5, // Minggu
    DateTime.monday: 4, // Senin
    DateTime.tuesday: 3, // Selasa
    DateTime.wednesday: 7, // Rabu
    DateTime.thursday: 8, // Kamis
    DateTime.friday: 6, // Jumat
    DateTime.saturday: 9, // Sabtu
  };

  final List<String> _pasaran = ['Legi', 'Pahing', 'Pon', 'Wage', 'Kliwon'];
  final Map<String, int> _neptuPasaran = {
    'Legi': 5,
    'Pahing': 9,
    'Pon': 7,
    'Wage': 4,
    'Kliwon': 8,
  };

  // Deskripsi singkat untuk setiap Weton (contoh, bisa diperluas)
  final Map<String, String> _wetonDescriptions = {
    "Minggu Legi": "Orang dengan weton Minggu Legi cenderung memiliki sifat yang kuat, mandiri, dan berwibawa. Mereka juga dikenal cerdas dan berani mengambil risiko.",
    "Minggu Pahing": "Weton ini melambangkan pribadi yang tertutup, namun cerdas dan memiliki cita-cita tinggi. Mereka seringkali menjadi pemimpin yang disegani.",
    "Minggu Pon": "Memiliki sifat yang tenang, berwibawa, dan suka menolong. Namun, mereka juga bisa keras kepala dan sulit diatur.",
    "Minggu Wage": "Weton ini menunjukkan pribadi yang tekun, ulet, dan pekerja keras. Mereka cenderung sukses dalam karir, namun perlu belajar bersosialisasi.",
    "Minggu Kliwon": "Dikenal sebagai pribadi yang ramah, pandai bergaul, dan memiliki banyak teman. Mereka juga memiliki intuisi yang kuat.",
    "Senin Legi": "Pribadi yang jujur, setia, dan bertanggung jawab. Mereka cocok menjadi penasihat atau pendamping yang baik.",
    "Senin Pahing": "Weton ini melambangkan pribadi yang cerdas, kreatif, dan memiliki banyak ide. Namun, mereka juga bisa mudah bosan.",
    "Senin Pon": "Memiliki sifat yang sabar, teliti, dan hati-hati. Mereka cocok untuk pekerjaan yang membutuhkan ketelitian.",
    "Senin Wage": "Pribadi yang sederhana, rendah hati, dan suka menolong. Mereka memiliki jiwa sosial yang tinggi.",
    "Senin Kliwon": "Weton ini menunjukkan pribadi yang berani, tegas, dan memiliki pendirian kuat. Mereka cocok menjadi pemimpin.",
    "Selasa Legi": "Dikenal sebagai pribadi yang ceria, optimis, dan mudah bergaul. Mereka membawa suasana positif di sekitarnya.",
    "Selasa Pahing": "Pribadi yang mandiri, pekerja keras, dan tidak mudah menyerah. Mereka memiliki semangat juang yang tinggi.",
    "Selasa Pon": "Memiliki sifat yang jujur, adil, dan bertanggung jawab. Mereka cocok menjadi penegak keadilan.",
    "Selasa Wage": "Weton ini melambangkan pribadi yang sederhana, sabar, dan tidak banyak menuntut. Mereka mudah beradaptasi.",
    "Selasa Kliwon": "Dikenal sebagai pribadi yang misterius, memiliki intuisi kuat, dan suka belajar hal baru.",
    "Rabu Legi": "Pribadi yang cerdas, bijaksana, dan memiliki wawasan luas. Mereka cocok menjadi guru atau penasihat.",
    "Rabu Pahing": "Weton ini menunjukkan pribadi yang kreatif, inovatif, dan memiliki banyak ide cemerlang.",
    "Rabu Pon": "Memiliki sifat yang ramah, sopan, dan pandai bergaul. Mereka mudah mendapatkan simpati orang lain.",
    "Rabu Wage": "Pribadi yang tekun, ulet, dan pekerja keras. Mereka memiliki potensi besar untuk sukses.",
    "Rabu Kliwon": "Dikenal sebagai pribadi yang berwibawa, tegas, dan memiliki jiwa kepemimpinan yang kuat.",
    "Kamis Legi": "Weton ini melambangkan pribadi yang optimis, ceria, dan selalu berpikir positif. Mereka membawa kebahagiaan.",
    "Kamis Pahing": "Pribadi yang mandiri, bertanggung jawab, dan memiliki pendirian kuat. Mereka tidak mudah terpengaruh.",
    "Kamis Pon": "Memiliki sifat yang sabar, teliti, dan hati-hati. Mereka cocok untuk pekerjaan yang membutuhkan ketelitian.",
    "Kamis Wage": "Weton ini menunjukkan pribadi yang sederhana, rendah hati, dan suka menolong. Mereka memiliki jiwa sosial yang tinggi.",
    "Kamis Kliwon": "Dikenal sebagai pribadi yang cerdas, bijaksana, dan memiliki intuisi kuat. Mereka sering menjadi penasihat.",
    "Jumat Legi": "Pribadi yang jujur, setia, dan bertanggung jawab. Mereka cocok menjadi penasihat atau pendamping yang baik.",
    "Jumat Pahing": "Weton ini melambangkan pribadi yang cerdas, kreatif, dan memiliki banyak ide. Namun, mereka juga bisa mudah bosan.",
    "Jumat Pon": "Memiliki sifat yang sabar, teliti, dan hati-hati. Mereka cocok untuk pekerjaan yang membutuhkan ketelitian.",
    "Jumat Wage": "Pribadi yang sederhana, rendah hati, dan suka menolong. Mereka memiliki jiwa sosial yang tinggi.",
    "Jumat Kliwon": "Weton ini menunjukkan pribadi yang berani, tegas, dan memiliki pendirian kuat. Mereka cocok menjadi pemimpin.",
    "Sabtu Legi": "Dikenal sebagai pribadi yang ceria, optimis, dan mudah bergaul. Mereka membawa suasana positif di sekitarnya.",
    "Sabtu Pahing": "Pribadi yang mandiri, pekerja keras, dan tidak mudah menyerah. Mereka memiliki semangat juang yang tinggi.",
    "Sabtu Pon": "Memiliki sifat yang jujur, adil, dan bertanggung jawab. Mereka cocok menjadi penegak keadilan.",
    "Sabtu Wage": "Weton ini melambangkan pribadi yang sederhana, sabar, dan tidak banyak menuntut. Mereka mudah beradaptasi.",
    "Sabtu Kliwon": "Dikenal sebagai pribadi yang misterius, memiliki intuisi kuat, dan suka belajar hal baru.",
  };

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith( // Tetap gunakan Dark Theme untuk kalender
            colorScheme: ColorScheme.dark(
              primary: colorGold,
              onPrimary: colorBrownDark,
              surface: colorBrownMedium,
              onSurface: colorBeige, // Ini yang membuat angka kalender terlihat
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: colorBrownDark, // Hapus 'const' karena variabel warna
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateWeton();
      });
    }
  }

  void _calculateWeton() {
    if (_selectedDate == null) {
      _wetonResult = "Silakan pilih tanggal lahir Anda.";
      _wetonDescription = "";
      return;
    }

    final int dayOfWeek = _selectedDate!.weekday; // 1=Senin, 7=Minggu
    final int neptuHari = _neptuHari[dayOfWeek] ?? 0;

    // Algoritma pasaran (siklus 5 hari)
    // Epoch date untuk pasaran (misal: 1 Januari 1900 adalah Minggu Legi)
    final DateTime epochDate = DateTime(1900, 1, 1);
    final int daysSinceEpoch = _selectedDate!.difference(epochDate).inDays;
    final int pasaranIndex = (daysSinceEpoch + 0) % 5; // +0 karena 1 Jan 1900 adalah Legi
    final String pasaran = _pasaran[pasaranIndex];
    final int neptuPasaran = _neptuPasaran[pasaran] ?? 0;

    final String namaHari;
    switch (dayOfWeek) {
      case DateTime.sunday:
        namaHari = "Minggu";
        break;
      case DateTime.monday:
        namaHari = "Senin";
        break;
      case DateTime.tuesday:
        namaHari = "Selasa";
        break;
      case DateTime.wednesday:
        namaHari = "Rabu";
        break;
      case DateTime.thursday:
        namaHari = "Kamis";
        break;
      case DateTime.friday:
        namaHari = "Jumat";
        break;
      case DateTime.saturday:
        namaHari = "Sabtu";
        break;
      default:
        namaHari = "";
    }

    final String weton = "$namaHari $pasaran";
    final int totalNeptu = neptuHari + neptuPasaran;

    _wetonResult = "Weton Anda adalah: $weton (Neptu: $totalNeptu)";
    _wetonDescription = _wetonDescriptions[weton] ?? "Deskripsi weton ini belum tersedia.";
  }

  @override
  void initState() {
    super.initState();
    _calculateWeton(); // Hitung weton awal jika ada selectedDate
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Weton', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5)),
        backgroundColor: colorBrownDark,
        foregroundColor: colorGold,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _selectedDate == null
                  ? "Tanggal lahir belum dipilih"
                  : "Tanggal Lahir: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
              style: const TextStyle(fontSize: 16, color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _selectDate(context),
              icon: const Icon(Icons.calendar_today, color: colorBrownDark),
              label: const Text('Pilih Tanggal Lahir', style: TextStyle(color: colorBrownDark)),
              style: ElevatedButton.styleFrom(
                backgroundColor: colorGold,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 40),
            Card(
              color: colorBrownMedium,
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      _wetonResult,
                      style: const TextStyle(
                          fontSize: 22, color: colorGold, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      _wetonDescription,
                      style: const TextStyle(fontSize: 16, color: colorBeige, height: 1.5),
                      textAlign: TextAlign.center,
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAWITRA MATERI', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2)),
        backgroundColor: colorBrownDark,
        foregroundColor: colorGold,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 18, mainAxisSpacing: 18),
        itemCount: cultureData.length,
        itemBuilder: (context, i) {
          return Hero(
            tag: cultureData[i].title,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (c, a1, a2) => DetailMateri(data: cultureData[i]),
                      transitionsBuilder: (c, a1, a2, child) => FadeTransition(opacity: a1, child: child),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
                    image: DecorationImage(
                      image: AssetImage(cultureData[i].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: const LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black26, Colors.black87]),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      cultureData[i].title.toUpperCase(),
                      style: const TextStyle(
                          color: colorGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1.2,
                          shadows: [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(1, 1))]),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailMateri extends StatelessWidget {
  final CultureContent data;
  const DetailMateri({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: colorBrownDark,
            iconTheme: const IconThemeData(color: colorGold),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(data.title,
                  style: const TextStyle(
                      color: colorGold,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black, offset: Offset(2, 2))])),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                      tag: data.title,
                      child: Image.asset(data.image,
                          fit: BoxFit.cover,
                          errorBuilder: (c, e, s) => Container(color: colorBrownMedium))),
                  DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black45, Colors.transparent, Colors.black87]))),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration:
                        BoxDecoration(color: colorGold, borderRadius: BorderRadius.circular(20)),
                    child: Text(data.subtitle,
                        style: const TextStyle(color: colorBrownDark, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  Text(data.description,
                      style: const TextStyle(
                          fontSize: 17, color: colorBeige, height: 1.8, letterSpacing: 0.5)),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuizEngine extends StatefulWidget {
  const QuizEngine({super.key});

  @override
  State<QuizEngine> createState() => _QuizEngineState();
}

class _QuizEngineState extends State<QuizEngine> {
  int _qldx = 0;
  int _score = 0;
  bool _finished = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'q': 'Dalam Aksara Jawa, "Da-Ta-Sa-Wa-La" bermakna...',
      'o': ['Asal manusia', 'Pertarungan nafsu & nurani', 'Persamaan derajat', 'Raga jadi semesta'],
      'a': 1
    },
    {
      'q': 'Siklus matahari (7) dan bumi (5) disebut...',
      'o': ['Primbon', 'Pranata Mangsa', 'Weton', 'Ruwatan'],
      'a': 2
    },
    {
      'q': 'Layar putih pada Wayang Kulit disebut...',
      'o': ['Blencong', 'Kelir', 'Kotak', 'Gawang'],
      'a': 1
    },
    {
      'q': 'Konsep menekan ego pada Gamelan disebut...',
      'o': ['Eling', 'Sangkan Paraning', 'Tepa Selira', 'Patrap'],
      'a': 2
    },
    {
      'q': 'Dalam Tari Serimpi, apa arti "Warih"?',
      'o': ['Api', 'Angin', 'Tanah', 'Air'],
      'a': 3
    },
    {
      'q': 'Empat tiang jati utama Rumah Joglo disebut...',
      'o': ['Tajug', 'Soko Guru', 'Pendhopo', 'Tumpang Sari'],
      'a': 1
    },
    {
      'q': 'Mengapa jumlah Luk Keris selalu ganjil?',
      'o': ['Lebih tajam', 'Sifat dinamis & terus bergerak', 'Aturan seminggu', 'Pembeda kasta'],
      'a': 1
    },
    {
      'q': 'Motif Batik Parang melambangkan...',
      'o': ['Ketenangan', 'Semangat pantang menyerah', 'Kekuasaan mutlak', 'Kemakmuran'],
      'a': 1
    },
    {
      'q': 'Bentuk kerucut Tumpeng melambangkan...',
      'o': ['Militer', 'Hubungan manusia & Pencipta', 'Batas desa', 'Kesuburan'],
      'a': 1
    },
    {
      'q': 'Cairan lilin perintang warna batik disebut...',
      'o': ['Canting', 'Sogan', 'Malam', 'Mori'],
      'a': 2
    },
  ];

  void _answer(int idx) {
    if (idx == _questions[_qldx]['a']) _score += 10;
    setState(() {
      if (_qldx < _questions.length - 1) {
        _qldx++;
      } else {
        _finished = true;
        quizHistory.insert(
            0, {'score': _score, 'date': DateTime.now().toString().substring(0, 16)});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Kuis Budaya Jawa'),
          backgroundColor: colorBrownDark,
          foregroundColor: colorGold),
      body: _finished ? _result() : _play(),
    );
  }

  Widget _play() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          LinearProgressIndicator(
              value: (_qldx + 1) / _questions.length,
              color: colorGold,
              backgroundColor: colorBrownMedium),
          const SizedBox(height: 30),
          Text(_questions[_qldx]['q'],
              style: const TextStyle(fontSize: 22, color: colorBeige, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          const SizedBox(height: 40),
          ...List.generate(
              4,
              (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          backgroundColor: colorBrownMedium,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () => _answer(i),
                      child: Text(_questions[_qldx]['o'][i],
                          style: const TextStyle(color: colorBeige, fontSize: 16)),
                    ),
                  )),
        ],
      ),
    );
  }

  Widget _result() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.workspace_premium, size: 120, color: colorGold),
          Text('$_score',
              style: const TextStyle(fontSize: 80, color: colorGold, fontWeight: FontWeight.bold)),
          const Text('SKOR AKHIR', style: TextStyle(color: colorBeige, letterSpacing: 2)),
          const SizedBox(height: 30),
          ElevatedButton(
              onPressed: () => setState(() {
                    _qldx = 0;
                    _score = 0;
                    _finished = false;
                  }),
              style: ElevatedButton.styleFrom(backgroundColor: colorGold, foregroundColor: colorBrownDark),
              child: const Text('COBA LAGI')),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(text: globalUserName);
  late Future<String> _quoteFuture;

  //--- KUMPULAN PITUTUR LUHUR (PENGGANTI API LUAR) ---
  final List<String> _pituturLuhur = [
    "Urip Iku Urup. (Hidup itu hendaknya memberi manfaat bagi sesama)",
    "Sura Dira Jayaningrat, Lebur Dening Pangastuti. (Angkara murka luluh oleh kasih sayang)",
    "Memehayu Hayuning Bawana. (Menjaga kelestarian dan keindahan dunia)",
    "Sabar iku ingaran mustikaning laku. (Kesabaran adalah permata dari setiap perbuatan)",
    "Datan Serik Lamun Ketaman, Datan Susah Lamun Kelangan. (Jangan sakit hati saat diuji, jangan susah saat kehilangan)",
    "Ojo Dumeh, Ojo Nyeleneh, Ojo Gumaweh. (Jangan sombong, jangan aneh-aneh, jangan sok berkuasa)",
    "Nrimo ing Pandum. (Menerima segala pemberian Tuhan dengan ikhlas)",
    "Alon-alon Waton Kelakon. (Perlahan namun pasti, mengutamakan keselamatan)",
    "Adigang, Adigung, Adiguna. (Jangan membanggakan kekuatan, kekuasaan, dan kepandaian)",
  ];

  //--- FUNGSI AMBIL KUTIPAN (SIMULASI API) ---
  Future<String> fetchQuote() async {
    try {
      // Simulasi delay sedikit agar terasa seperti mengambil dari internet
      await Future.delayed(const Duration(milliseconds: 500));
      return _pituturLuhur[Random().nextInt(_pituturLuhur.length)];
    } catch (e) {
      return "Sabar iku ingaran mustikaning laku."; 
    }
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi di initState agar API hanya dipanggil sekali saat layar dibuka
    _quoteFuture = fetchQuote();
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorBrownMedium,
        title: const Text('Edit Profil', style: TextStyle(color: colorGold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: _nameController,
                style: const TextStyle(color: colorBeige),
                decoration: const InputDecoration(
                    labelText: 'Nama Baru', labelStyle: TextStyle(color: colorGold))),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _picOption("assets/images/depan.webp"),
                _picOption("assets/images/tari.jpg"),
                _picOption("assets/images/wayang.jpg"),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.white54))),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  globalUserName = _nameController.text;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: colorGold, foregroundColor: colorBrownDark),
              child: const Text('Simpan')),
        ],
      ),
    );
  }

  // --- LOGIC UNTUK MENDAPATKAN GELAR BERDASARKAN TOTAL SKOR ---
  String _getUserTitle() {
    int totalScore = 0;
    for (var entry in quizHistory) {
      totalScore += (entry['score'] as int);
    }

    if (totalScore >= 500) return "EMPU BUDAYA";
    if (totalScore >= 200) return "PUNGGAWA";
    if (totalScore >= 50) return "CANTRIK";
    return "PENDAFTAR BARU";
  }

  Widget _picOption(String path) {
    return InkWell(
      onTap: () => setState(() => globalProfilePic = path),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: AssetImage(path),
          backgroundColor: colorGold,
          child: globalProfilePic == path ? const Icon(Icons.check, color: colorGold) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Profil Saya'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: colorGold,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (c) => const WelcomeScreen()), (r) => false),
                icon: const Icon(Icons.logout))
          ]),
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 260,
              child: Image.asset('assets/images/wayang.jpg',
                  fit: BoxFit.cover, errorBuilder: (c, e, s) => Container(color: colorBrownMedium))),
          Container(
              height: 260,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, colorBrownDark]))),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                        radius: 65,
                        backgroundColor: colorGold,
                        child: CircleAvatar(radius: 60, backgroundImage: AssetImage(globalProfilePic))),
                    GestureDetector(
                        onTap: _showEditDialog,
                        child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: colorGold,
                            child: Icon(Icons.camera_alt, size: 18, color: colorBrownDark))),
                  ],
                ),
                const SizedBox(height: 15),
                Text(globalUserName,
                    style:
                        const TextStyle(fontSize: 26, color: colorGold, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                const SizedBox(height: 5),
                // --- MENAMPILKAN GELAR ---
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: colorGold.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colorGold, width: 1),
                  ),
                  child: Text(_getUserTitle(),
                      style: const TextStyle(color: colorGold, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                // --- TAMPILAN DATA API (DIPERBAIKI) ---
                FutureBuilder<String>(
                  future: _quoteFuture,
                  builder: (context, snapshot) {
                    String message = "Memuat pesan hari ini...";
                    if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) message = '"${snapshot.data}"';
                    if (snapshot.hasError) message = "Nrimo ing pandum.";
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white60, fontStyle: FontStyle.italic, fontSize: 13),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Divider(color: colorBrownMedium),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('RIWAYAT KUIS TERBARU',
                        style: TextStyle(
                            color: colorGold, fontWeight: FontWeight.bold, letterSpacing: 1.2))),
                const SizedBox(height: 10),
                Expanded(
                  child: quizHistory.isEmpty
                      ? const Center(
                          child: Text('Belum ada riwayat', style: TextStyle(color: Colors.white38)))
                      : ListView.builder(
                          itemCount: quizHistory.length,
                          itemBuilder: (c, i) => Card(
                            color: colorBrownMedium.withOpacity(0.5),
                            child: ListTile(
                              leading: const Icon(Icons.military_tech, color: colorGold),
                              title: Text('Skor: ${quizHistory[i]['score']}',
                                  style: const TextStyle(color: colorGold, fontWeight: FontWeight.bold)),
                              subtitle: Text(quizHistory[i]['date'],
                                  style: const TextStyle(color: Colors.white54, fontSize: 12)),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}