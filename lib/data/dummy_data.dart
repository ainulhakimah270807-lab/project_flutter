class Project {
  const Project({
    required this.title,
    required this.description,
    required this.year,
  });

  final String title;
  final String description;
  final int year;
}

const projects = <Project>[
  Project(title: 'Kartu Profil Digital', description: 'Halaman profil dengan Row, Column, dan Stack.', year: 2026),
  Project(title: 'Aplikasi Catatan', description: 'Catat, ubah, dan hapus catatan harian dengan mudah.', year: 2026),
  Project(title: 'To-Do List', description: 'Kelola tugas harian lengkap dengan penanda selesai.', year: 2025),
  Project(title: 'Kalkulator BMI', description: 'Hitung indeks massa tubuh dari tinggi dan berat badan.', year: 2025),
  Project(title: 'Toko Online Mini', description: 'Katalog produk dengan keranjang belanja sederhana.', year: 2025),
  Project(title: 'Cuaca Hari Ini', description: 'Menampilkan prakiraan cuaca dari REST API.', year: 2025),
  Project(title: 'Kuis Pemrograman', description: 'Latihan soal pilihan ganda dengan skor akhir.', year: 2025),
  Project(title: 'Pemutar Musik Sederhana', description: 'Memutar daftar lagu lokal dengan kontrol dasar.', year: 2024),
];

final galleryImages = List<String>.generate(
  24,
  (i) => 'https://picsum.photos/seed/galeri$i/400/400',
);