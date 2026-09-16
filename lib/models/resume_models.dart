import 'dart:convert';

class ExperienceItem {
  final String company;
  final String role;
  final String period;
  final String description;
  final List<String> highlights;

  const ExperienceItem({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    this.highlights = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'role': role,
      'period': period,
      'description': description,
      'highlights': highlights,
    };
  }

  factory ExperienceItem.fromMap(Map<String, dynamic> map) {
    return ExperienceItem(
      company: map['company'] as String? ?? '',
      role: map['role'] as String? ?? '',
      period: map['period'] as String? ?? '',
      description: map['description'] as String? ?? '',
      highlights: (map['highlights'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  String toJson() => jsonEncode(toMap());
  factory ExperienceItem.fromJson(String source) =>
      ExperienceItem.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

class CertificationItem {
  final String title;
  final String issuer;
  final String year;
  final String credentialUrl;

  const CertificationItem({
    required this.title,
    required this.issuer,
    required this.year,
    required this.credentialUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'issuer': issuer,
      'year': year,
      'credentialUrl': credentialUrl,
    };
  }

  factory CertificationItem.fromMap(Map<String, dynamic> map) {
    return CertificationItem(
      title: map['title'] as String? ?? '',
      issuer: map['issuer'] as String? ?? '',
      year: map['year'] as String? ?? '',
      credentialUrl: map['credentialUrl'] as String? ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());
  factory CertificationItem.fromJson(String source) =>
      CertificationItem.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
