import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State untuk Tema Gelap Global
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil Digital',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: ProfilePage(
        isDarkMode: _isDarkMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Data Profil (Dapat di-edit)
  String _nama = 'Ainul Hakimah';
  String _nim = 'E41252793';
  String _prodi = 'Teknik Informatika';
  String _universitas = 'Politeknik Negeri Jember';
  String _tahunMasuk = '2025';
  String _bio = 'Suka desain UI/UX, Travelling dan minum red velvet.';

  // State Fitur Utama
  int _likeCount = 1;
  bool _isLiked = true;
  bool _isSaved = false;

  // State Fitur Subscribe & Share
  bool _isSubscribed = false;
  int _subscriberCount = 120;

  // FITUR BARU: Daftar Hobi/Interest
  final List<String> _hobbies = ['UI/UX Design', 'Travelling', 'Red Velvet', 'PHP & Web'];

  // Toggle Like & Jumlah Like
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likeCount++ : _likeCount--;
    });
  }

  // Toggle Simpan Profil
  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Profil disimpan!' : 'Profil dihapus dari simpanan.'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Toggle Subscribe (Berlangganan)
  void _toggleSubscribe() {
    setState(() {
      _isSubscribed = !_isSubscribed;
      _isSubscribed ? _subscriberCount++ : _subscriberCount--;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSubscribed 
            ? 'Berhasil Subscribe ke profil $_nama!' 
            : 'Unsubscribe dari profil $_nama.',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: _isSubscribed ? Colors.redAccent : Colors.grey[800],
      ),
    );
  }

  // Share Profil (Bagikan Tautan Profil)
  void _shareProfile() {
    String profileUrl = 'https://profil.digital/user/$_nim';
    Clipboard.setData(ClipboardData(text: profileUrl));

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.share, color: Colors.blue),
              SizedBox(width: 8),
              Text('Bagikan Profil'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Tautan profil berhasil disalin ke clipboard:'),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  profileUrl,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Salin NIM ke Clipboard
  void _copyNim() {
    Clipboard.setData(ClipboardData(text: _nim));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('NIM $_nim berhasil disalin!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Modal Detail Profil
  void _showDetailModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Detail Profil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Divider(),
              const SizedBox(height: 8),
              Text('Nama Lengkap: $_nama'),
              Text('NIM: $_nim'),
              Text('Program Studi: $_prodi'),
              Text('Kampus: $_universitas'),
              Text('Tahun Masuk: $_tahunMasuk'),
              Text('Jumlah Subscriber: $_subscriberCount'),
              const SizedBox(height: 8),
              Text('Bio: $_bio', style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        );
      },
    );
  }

  // Dialog Edit Profil
  void _showEditDialog() {
    TextEditingController nameCtrl = TextEditingController(text: _nama);
    TextEditingController nimCtrl = TextEditingController(text: _nim);
    TextEditingController prodiCtrl = TextEditingController(text: _prodi);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profil'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Nama')),
                TextField(controller: nimCtrl, decoration: const InputDecoration(labelText: 'NIM')),
                TextField(controller: prodiCtrl, decoration: const InputDecoration(labelText: 'Prodi')),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _nama = nameCtrl.text;
                  _nim = nimCtrl.text;
                  _prodi = prodiCtrl.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // TOMBOL BARU: Toggle Dark/Light Mode di AppBar
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Ubah Tema',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Foto Profil
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage('https://picsum.photos/200'),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    _nama,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),

                  // Salin NIM Feature
                  InkWell(
                    onTap: _copyNim,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('NIM: $_nim', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[700])),
                          const SizedBox(width: 4),
                          const Icon(Icons.copy, size: 12, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(_prodi, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  const SizedBox(height: 6),

                  // Data Universitas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '$_universitas, $_tahunMasuk',
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // FITUR BARU: Menampilkan Daftar Hobi / Chips
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    alignment: WrapAlignment.center,
                    children: _hobbies.map((hobby) => Chip(
                      label: Text(hobby, style: const TextStyle(fontSize: 10)),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.blue[50],
                    )).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Tombol Utama: Like & Subscribe
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _toggleLike,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.grey[800] : const Color(0xFFE8EEF5),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: Icon(
                          _isLiked ? Icons.favorite : Icons.favorite_border,
                          color: _isLiked ? Colors.red : Colors.grey,
                          size: 16,
                        ),
                        label: Text('$_likeCount Like', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontSize: 12)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        onPressed: _toggleSubscribe,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isSubscribed 
                              ? (isDark ? Colors.grey[700] : Colors.grey[300]) 
                              : Colors.red,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        icon: Icon(
                          _isSubscribed ? Icons.notifications_active : Icons.notifications_none,
                          color: _isSubscribed ? (isDark ? Colors.white : Colors.black87) : Colors.white,
                          size: 16,
                        ),
                        label: Text(
                          _isSubscribed ? 'Subscribed' : 'Subscribe',
                          style: TextStyle(
                            color: _isSubscribed ? (isDark ? Colors.white : Colors.black87) : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Divider(height: 1, color: isDark ? Colors.grey[800] : Colors.grey[300]),
                  const SizedBox(height: 8),

                  // Action Buttons (Simpan, Detail, Edit, Share)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: _toggleSave,
                        icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
                        color: _isSaved ? Colors.redAccent : (isDark ? Colors.grey[400] : Colors.grey[700]),
                        tooltip: 'Simpan Profil',
                      ),
                      IconButton(
                        onPressed: _showDetailModal,
                        icon: const Icon(Icons.visibility_outlined),
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        tooltip: 'Detail Profil',
                      ),
                      IconButton(
                        onPressed: _showEditDialog,
                        icon: const Icon(Icons.edit_outlined),
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        tooltip: 'Edit Profil',
                      ),
                      IconButton(
                        onPressed: _shareProfile,
                        icon: const Icon(Icons.share_outlined),
                        color: isDark ? Colors.grey[400] : Colors.grey[700],
                        tooltip: 'Bagikan Profil',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}