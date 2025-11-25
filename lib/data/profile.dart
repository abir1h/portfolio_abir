class Experience {
  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.location,
    required this.points,
  });

  final String company;
  final String role;
  final String period;
  final String location;
  final List<String> points;
}

class Education {
  const Education({
    required this.institution,
    required this.degree,
    required this.period,
    required this.location,
  });

  final String institution;
  final String degree;
  final String period;
  final String location;
}

class Project {
  const Project({
    required this.name,
    required this.description,
    required this.link,
    required this.tags,
    this.id,
  });

  final String? id;
  final String name;
  final String description;
  final String link;
  final List<String> tags;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'] as String?,
    name: json['name'] as String? ?? '',
    description: json['description'] as String? ?? '',
    link: json['link'] as String? ?? '',
    tags: (json['tags'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'link': link,
    'tags': tags,
  };
}

class SkillCategory {
  const SkillCategory({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

class PortfolioData {
  const PortfolioData({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.phone,
    required this.summary,
    required this.experiences,
    required this.education,
    required this.projects,
    required this.skills,
    required this.ctaLabel,
    required this.headshotAsset,
    this.headshotUrl,
    required this.experienceLabel,
  });

  final String name;
  final String title;
  final String location;
  final String email;
  final String phone;
  final String summary;
  final String ctaLabel;
  final String headshotAsset;
  final String? headshotUrl;
  final String experienceLabel;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Project> projects;
  final List<SkillCategory> skills;

  static PortfolioData get abir => PortfolioData(
    name: 'Abir Rahman',
    title: 'Flutter Mobile Application Developer',
    location: 'Dhaka, Bangladesh',
    email: 'abirrahman959@gmail.com',
    phone: '+8801600223852',
    ctaLabel: 'Let’s build something impactful together',
    headshotAsset: 'assets/images/profile.jpg',
    experienceLabel: '4+ Years',
    summary:
        'Flutter developer with 4+ years of experience building high-performing, crash-resistant apps for education, fleet, and talent marketplaces. Focused on scalable architecture, delightful UI, and measurable product outcomes.',
    experiences: const [
      Experience(
        company: 'BacBon Limited',
        role: 'Flutter Developer',
        period: 'Nov 2023 — Present',
        location: 'Dhaka, Bangladesh',
        points: [
          'Build and maintain e-learning applications that serve thousands of students nationwide.',
          'Lead performance optimization initiatives that reduced crash rates and improved retention.',
          'Work closely with UX to launch features that elevate user satisfaction metrics.',
        ],
      ),
      Experience(
        company: 'Star Computer Systems Limited',
        role: 'Flutter Developer',
        period: 'Sep 2022 — Oct 2023',
        location: 'Dhaka, Bangladesh',
        points: [
          'Delivered production apps for Save the Children Bangladesh, including internal tooling.',
          'Upheld clean architecture and reliable state management across large codebases.',
          'Directed code reviews and debugging sessions that lowered defect counts.',
        ],
      ),
      Experience(
        company: 'Codecell Ltd',
        role: 'Junior Flutter Developer',
        period: 'Jul 2021 — Oct 2022',
        location: 'Dhaka, Bangladesh',
        points: [
          'Implemented core modules for multiple consumer mobile products.',
          'Improved launch times through memory tuning and eager-loading audits.',
          'Contributed to peer reviews to maintain consistent delivery velocity.',
        ],
      ),
    ],
    education: const [
      Education(
        institution: 'Daffodil International University',
        degree: 'B.Sc. in Computer Science & Engineering',
        period: '2017 — 2021',
        location: 'Dhaka, Bangladesh',
      ),
      Education(
        institution: 'Hazi Misir Ali University College',
        degree: 'Higher Secondary School Certificate',
        period: '2014 — 2016',
        location: 'Narayanganj, Bangladesh',
      ),
    ],
    projects: const [
      Project(
        name: 'Co-Learning Application',
        description:
            'Collaborative learning platform that equips teachers and mentors with interactive content, assessments, and analytics.',
        link:
            'https://play.google.com/store/apps/details?id=com.bacbonitd.coleaming',
        tags: ['Education', 'Collaboration', 'Firebase'],
      ),
      Project(
        name: 'BB Tutors',
        description:
            'End-to-end tutor management platform with scheduling, live classes, and parent-facing insights.',
        link: 'https://apps.apple.com/pl/app/bacbon-tutors/id6449931601',
        tags: ['Marketplace', 'Payments', 'Live Class'],
      ),
      Project(
        name: 'ADB LMS',
        description:
            'Specialized LMS for the Asian Development Bank and Bangladesh Bank with enterprise reporting.',
        link: 'https://github.com/abir1h/ADB-LMS',
        tags: ['LMS', 'Enterprise', 'Web'],
      ),
      Project(
        name: 'CLMS',
        description:
            'Large-scale learning ecosystem combining eLibrary, eTeacher guide, and PLC features.',
        link: 'https://github.com/abir1h/LMS/tree/stage',
        tags: ['Scaling', 'Content', 'Social Learning'],
      ),
      Project(
        name: 'Turkey Fleet MS',
        description:
            'Vehicle management system that digitizes requests, fuel logs, and safety checklists for distributed teams.',
        link: '',
        tags: ['Fleet', 'Logistics', 'Tracking'],
      ),
      Project(
        name: 'Hire Me Now',
        description:
            'Marketplace that connects Nigerian households with verified service professionals.',
        link: '',
        tags: ['Marketplace', 'Mobile', 'Services'],
      ),
    ],
    skills: const [
      SkillCategory(
        title: 'Core',
        skills: ['Flutter', 'Dart', 'Flutter Web', 'Clean Architecture'],
      ),
      SkillCategory(
        title: 'Ecosystem',
        skills: ['Firebase', 'REST APIs', 'Push Notifications', 'CI/CD'],
      ),
      SkillCategory(
        title: 'State Management',
        skills: ['GetX', 'Riverpod', 'Provider'],
      ),
      SkillCategory(
        title: 'Practices',
        skills: ['Code Review', 'Performance Tuning', 'Design Systems'],
      ),
    ],
  );

  PortfolioData copyWith({
    String? summary,
    String? ctaLabel,
    String? headshotAsset,
    String? headshotUrl,
    String? experienceLabel,
    List<Project>? projects,
  }) {
    return PortfolioData(
      name: name,
      title: title,
      location: location,
      email: email,
      phone: phone,
      summary: summary ?? this.summary,
      experiences: experiences,
      education: education,
      projects: projects ?? this.projects,
      skills: skills,
      ctaLabel: ctaLabel ?? this.ctaLabel,
      headshotAsset: headshotAsset ?? this.headshotAsset,
      headshotUrl: headshotUrl ?? this.headshotUrl,
      experienceLabel: experienceLabel ?? this.experienceLabel,
    );
  }

  factory PortfolioData.fromJson(Map<String, dynamic> json) {
    return PortfolioData(
      name: json['name'] as String? ?? abir.name,
      title: json['title'] as String? ?? abir.title,
      location: json['location'] as String? ?? abir.location,
      email: json['email'] as String? ?? abir.email,
      phone: json['phone'] as String? ?? abir.phone,
      summary: json['summary'] as String? ?? abir.summary,
      experiences: (json['experiences'] as List<dynamic>? ?? [])
          .map(
            (e) => Experience(
              company: e['company'] as String? ?? '',
              role: e['role'] as String? ?? '',
              period: e['period'] as String? ?? '',
              location: e['location'] as String? ?? '',
              points: (e['points'] as List<dynamic>? ?? [])
                  .map((p) => p.toString())
                  .toList(),
            ),
          )
          .toList(),
      education: (json['education'] as List<dynamic>? ?? [])
          .map(
            (e) => Education(
              institution: e['institution'] as String? ?? '',
              degree: e['degree'] as String? ?? '',
              period: e['period'] as String? ?? '',
              location: e['location'] as String? ?? '',
            ),
          )
          .toList(),
      projects: (json['projects'] as List<dynamic>? ?? [])
          .map((e) => Project.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      skills: (json['skills'] as List<dynamic>? ?? [])
          .map(
            (e) => SkillCategory(
              title: e['title'] as String? ?? '',
              skills: (e['skills'] as List<dynamic>? ?? [])
                  .map((s) => s.toString())
                  .toList(),
            ),
          )
          .toList(),
      ctaLabel: json['ctaLabel'] as String? ?? abir.ctaLabel,
      headshotAsset: json['headshotAsset'] as String? ?? abir.headshotAsset,
      headshotUrl: json['headshotUrl'] as String?,
      experienceLabel:
          json['experienceLabel'] as String? ?? abir.experienceLabel,
    );
  }
}
