import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/profile_data.dart';
import 'pages/edit_profile_page.dart';
import 'utils/avatar_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  // Menggunakan model ProfileData agar sinkron penuh dengan form edit
  ProfileData _profile = const ProfileData(
    name: 'Ainul Hakimah',
    email: 'ainulhakimah270807@gmail.com',
    phone: '081252611176',
    bio: 'Suka desain UI/UX, Travelling dan minum red velvet.',
    nim: 'E41252793',
    prodi: 'Teknik Informatika',
    universitas: 'Politeknik Negeri Jember',
    tahunMasuk: '2025',
    avatarUrl: 'https://picsum.photos/200',
    skills: ['UI/UX Design', 'Travelling', 'Red Velvet', 'PHP & Web'],
  );

  int _likeCount = 1;
  bool _isLiked = true;
  bool _isSaved = false;
  bool _isSubscribed = false;
  int _subscriberCount = 120;

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likeCount++ : _likeCount--;
    });
  }

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

  void _toggleSubscribe() {
    setState(() {
      _isSubscribed = !_isSubscribed;
      _isSubscribed ? _subscriberCount++ : _subscriberCount--;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSubscribed 
            ? 'Berhasil Subscribe ke profil ${_profile.name}!' 
            : 'Unsubscribe dari profil ${_profile.name}.',
        ),
        duration: const Duration(seconds: 1),
        backgroundColor: _isSubscribed ? Colors.redAccent : Colors.grey[800],
      ),
    );
  }

  void _shareProfile() {
    String profileUrl = 'https://profil.digital/user/${_profile.nim}';
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

  void _copyNim() {
    Clipboard.setData(ClipboardData(text: _profile.nim));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('NIM ${_profile.nim} berhasil disalin!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

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
              Text('Nama Lengkap: ${_profile.name}'),
              Text('NIM: ${_profile.nim}'),
              Text('Email: ${_profile.email}'),
              Text('No. HP: ${_profile.phone}'),
              Text('Program Studi: ${_profile.prodi}'),
              Text('Kampus: ${_profile.universitas}'),
              Text('Tahun Masuk: ${_profile.tahunMasuk}'),
              Text('Keahlian / Hobi: ${_profile.skillsText}'),
              Text('Jumlah Subscriber: $_subscriberCount'),
              const SizedBox(height: 8),
              Text('Bio: ${_profile.bio}', style: const TextStyle(fontStyle: FontStyle.italic)),
            ],
          ),
        );
      },
    );
  }

  /// Membuka halaman Edit Profil lengkap dengan form validasi
  Future<void> _openEditPage() async {
    final result = await Navigator.push<ProfileData>(
      context,
      MaterialPageRoute(
        builder: (_) => EditProfilePage(initialData: _profile),
      ),
    );

    if (!mounted || result == null) return;

    setState(() => _profile = result);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil diperbarui ✅')),
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
                    color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.blue.shade100,
                    backgroundImage: getAvatarImageProvider(_profile.avatarUrl),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                  const SizedBox(height: 12),

                  Text(
                    _profile.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),

                  InkWell(
                    onTap: _copyNim,
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('NIM: ${_profile.nim}', style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[700])),
                          const SizedBox(width: 4),
                          const Icon(Icons.copy, size: 12, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(_profile.prodi, style: TextStyle(fontSize: 12, color: isDark ? Colors.grey[400] : Colors.grey[600])),
                  const SizedBox(height: 6),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.school, size: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        '${_profile.universitas}, ${_profile.tahunMasuk}',
                        style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Display Email & Phone directly on the front card
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.email_outlined, size: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            _profile.email,
                            style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone_outlined, size: 12, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            _profile.phone,
                            style: TextStyle(fontSize: 11, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    alignment: WrapAlignment.center,
                    children: _profile.skills.map((hobby) => Chip(
                      label: Text(hobby, style: const TextStyle(fontSize: 10)),
                      padding: EdgeInsets.zero,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: isDark ? Colors.grey[800] : Colors.blue[50],
                    )).toList(),
                  ),
                  const SizedBox(height: 16),

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
                        onPressed: _openEditPage, // Tombol edit profil terhubung ke form validasi
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