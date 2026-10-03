import 'package:flutter/material.dart';

class Validators {
  Validators._(); // Mencegah class ini diinisialisasi sebagai objek

  /// Wajib diisi
  static FormFieldValidator<String> requiredField(String field) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return '$field wajib diisi';
      }
      return null;
    };
  }

  /// Panjang minimal karakter
  static FormFieldValidator<String> minLength(int min, String field) {
    return (value) {
      if ((value ?? '').trim().length < min) {
        return '$field minimal $min karakter';
      }
      return null;
    };
  }

  /// Format email sederhana
  static String? email(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Email wajib diisi';
    final regex = RegExp(r'^[\w.+-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!regex.hasMatch(text)) return 'Format email tidak valid';
    return null;
  }

  /// Nomor HP Indonesia (08xx..., 628xx..., atau +628xx...)
  static String? phone(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Nomor HP wajib diisi';
    final regex = RegExp(r'^(\+62|62|0)8[1-9][0-9]{7,10}$');
    if (!regex.hasMatch(text)) {
      return 'Nomor HP tidak valid (contoh: 081234567890)';
    }
    return null;
  }

  /// Menggabungkan beberapa validator sekaligus
  static FormFieldValidator<String> compose(
    List<FormFieldValidator<String>> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) return error;
      }
      return null;
    };
  }
}