import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../models/profile_data.dart';
import '../utils/avatar_helper.dart';
import '../utils/validators.dart';
import '../widgets/app_text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.initialData});

  final ProfileData initialData;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // Controller untuk semua field profil
  late final TextEditingController _avatarUrlController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _nimController;
  late final TextEditingController _prodiController;
  late final TextEditingController _universitasController;
  late final TextEditingController _tahunMasukController;
  late final TextEditingController _skillsController;
  late final TextEditingController _bioController;

  // Focus node untuk kelancaran navigasi keyboard
  final _avatarFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _nimFocus = FocusNode();
  final _prodiFocus = FocusNode();
  final _univFocus = FocusNode();
  final _tahunFocus = FocusNode();
  final _skillsFocus = FocusNode();
  final _bioFocus = FocusNode();

  bool _isLoading = false;
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    final data = widget.initialData;
    _avatarUrlController = TextEditingController(text: data.avatarUrl);
    _nameController = TextEditingController(text: data.name);
    _emailController = TextEditingController(text: data.email);
    _phoneController = TextEditingController(text: data.phone);
    _nimController = TextEditingController(text: data.nim);
    _prodiController = TextEditingController(text: data.prodi);
    _universitasController = TextEditingController(text: data.universitas);
    _tahunMasukController = TextEditingController(text: data.tahunMasuk);
    _skillsController = TextEditingController(text: data.skillsText);
    _bioController = TextEditingController(text: data.bio);
  }

  @override
  void dispose() {
    _avatarUrlController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nimController.dispose();
    _prodiController.dispose();
    _universitasController.dispose();
    _tahunMasukController.dispose();
    _skillsController.dispose();
    _bioController.dispose();

    _avatarFocus.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _nimFocus.dispose();
    _prodiFocus.dispose();
    _univFocus.dispose();
    _tahunFocus.dispose();
    _skillsFocus.dispose();
    _bioFocus.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 600,
        maxHeight: 600,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _avatarUrlController.text = image.path;
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil gambar: $e')),
      );
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Text(
                  'Pilih Sumber Foto Profil',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.photo_library_outlined, color: Colors.blue),
                  title: const Text('Pilih dari Galeri Foto'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt_outlined, color: Colors.blue),
                  title: const Text('Ambil Foto Kamera'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidate = AutovalidateMode.onUserInteraction);
      return;
    }

    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;
    setState(() => _isLoading = false);

    final skillsList = _skillsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final result = widget.initialData.copyWith(
      avatarUrl: _avatarUrlController.text.trim(),
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      nim: _nimController.text.trim(),
      prodi: _prodiController.text.trim(),
      universitas: _universitasController.text.trim(),
      tahunMasuk: _tahunMasukController.text.trim(),
      skills: skillsList,
      bio: _bioController.text.trim(),
    );

    Navigator.pop(context, result);
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Section 1: Foto Profil ---
                  Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _showImagePickerOptions,
                          child: Stack(
                            children: [
                              ValueListenableBuilder<TextEditingValue>(
                                valueListenable: _avatarUrlController,
                                builder: (context, value, child) {
                                  return CircleAvatar(
                                    radius: 46,
                                    backgroundColor: Colors.blue.shade100,
                                    backgroundImage: getAvatarImageProvider(value.text),
                                    onBackgroundImageError: (exception, stackTrace) {},
                                  );
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _showImagePickerOptions,
                          icon: const Icon(Icons.photo_library_outlined, size: 16),
                          label: const Text('Pilih Foto dari Galeri', style: TextStyle(fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  AppTextField(
                    controller: _avatarUrlController,
                    focusNode: _avatarFocus,
                    label: 'URL atau Path Foto Profil',
                    hint: 'Pilih dari galeri atau ketik URL foto',
                    icon: Icons.image_outlined,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _nameFocus.requestFocus(),
                  ),

                  // --- Section 2: Informasi Pribadi ---
                  _buildSectionHeader('Informasi Pribadi', Icons.person_outline),

                  AppTextField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    label: 'Nama Lengkap',
                    hint: 'Contoh: Ainul Hakimah',
                    icon: Icons.person,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    autofillHints: const [AutofillHints.name],
                    validator: Validators.compose([
                      Validators.requiredField('Nama'),
                      Validators.minLength(3, 'Nama'),
                    ]),
                    onFieldSubmitted: (_) => _emailFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    label: 'Email',
                    hint: 'nama@email.com',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofillHints: const [AutofillHints.email],
                    validator: Validators.email,
                    onFieldSubmitted: (_) => _phoneFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    label: 'No. HP',
                    hint: '081234567890',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                      LengthLimitingTextInputFormatter(15),
                    ],
                    validator: Validators.phone,
                    onFieldSubmitted: (_) => _nimFocus.requestFocus(),
                  ),

                  // --- Section 3: Informasi Akademik ---
                  _buildSectionHeader('Informasi Akademik', Icons.school_outlined),

                  AppTextField(
                    controller: _nimController,
                    focusNode: _nimFocus,
                    label: 'NIM',
                    hint: 'Contoh: E41252793',
                    icon: Icons.badge_outlined,
                    textInputAction: TextInputAction.next,
                    validator: Validators.requiredField('NIM'),
                    onFieldSubmitted: (_) => _prodiFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _prodiController,
                    focusNode: _prodiFocus,
                    label: 'Program Studi',
                    hint: 'Contoh: Teknik Informatika',
                    icon: Icons.school,
                    textInputAction: TextInputAction.next,
                    validator: Validators.requiredField('Program Studi'),
                    onFieldSubmitted: (_) => _univFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _universitasController,
                    focusNode: _univFocus,
                    label: 'Kampus / Universitas',
                    hint: 'Contoh: Politeknik Negeri Jember',
                    icon: Icons.location_city_outlined,
                    textInputAction: TextInputAction.next,
                    validator: Validators.requiredField('Kampus'),
                    onFieldSubmitted: (_) => _tahunFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _tahunMasukController,
                    focusNode: _tahunFocus,
                    label: 'Tahun Masuk / Angkatan',
                    hint: 'Contoh: 2025',
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: Validators.requiredField('Tahun Masuk'),
                    onFieldSubmitted: (_) => _skillsFocus.requestFocus(),
                  ),

                  // --- Section 4: Keahlian & Bio ---
                  _buildSectionHeader('Keahlian & Bio', Icons.stars_outlined),

                  AppTextField(
                    controller: _skillsController,
                    focusNode: _skillsFocus,
                    label: 'Keahlian / Hobi (Pisahkan dengan koma)',
                    hint: 'UI/UX Design, Travelling, Red Velvet, PHP & Web',
                    icon: Icons.extension_outlined,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) => _bioFocus.requestFocus(),
                  ),

                  AppTextField(
                    controller: _bioController,
                    focusNode: _bioFocus,
                    label: 'Bio',
                    hint: 'Tuliskan deskripsi singkat mengenai diri Anda...',
                    icon: Icons.notes_outlined,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    maxLength: 100,
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: FilledButton.icon(
                      onPressed: _isLoading ? null : _submit,
                      icon: _isLoading
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.save_outlined),
                      label: Text(
                        _isLoading ? 'Menyimpan...' : 'Simpan Perubahan',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}