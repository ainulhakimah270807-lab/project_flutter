class ProfileData {
  const ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.bio,
    required this.nim,
    required this.prodi,
    required this.universitas,
    required this.tahunMasuk,
    this.avatarUrl = 'https://picsum.photos/200',
    this.skills = const ['UI/UX Design', 'Travelling', 'Red Velvet', 'PHP & Web'],
  });

  final String name;
  final String email;
  final String phone;
  final String bio;
  final String nim;
  final String prodi;
  final String universitas;
  final String tahunMasuk;
  final String avatarUrl;
  final List<String> skills;

  String get skillsText => skills.join(', ');

  /// Membuat salinan baru dengan sebagian data diganti.
  ProfileData copyWith({
    String? name,
    String? email,
    String? phone,
    String? bio,
    String? nim,
    String? prodi,
    String? universitas,
    String? tahunMasuk,
    String? avatarUrl,
    List<String>? skills,
  }) {
    return ProfileData(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      nim: nim ?? this.nim,
      prodi: prodi ?? this.prodi,
      universitas: universitas ?? this.universitas,
      tahunMasuk: tahunMasuk ?? this.tahunMasuk,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      skills: skills ?? this.skills,
    );
  }
}