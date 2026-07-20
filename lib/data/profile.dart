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
    this.score,
  });

  final String institution;
  final String degree;
  final String period;
  final String location;
  final String? score;
}

class Project {
  const Project({
    required this.name,
    required this.description,
    required this.link,
    required this.tags,
    this.playStoreLink,
    this.appStoreLink,
    this.id,
  });

  final String? id;
  final String name;
  final String description;
  final String link;
  final String? playStoreLink;
  final String? appStoreLink;
  final List<String> tags;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    id: json['id'] as String?,
    name: json['name'] as String? ?? '',
    description: json['description'] as String? ?? '',
    link: json['link'] as String? ?? '',
    playStoreLink: json['playStoreLink'] as String?,
    appStoreLink: json['appStoreLink'] as String?,
    tags: (json['tags'] as List<dynamic>? ?? [])
        .map((e) => e.toString())
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'link': link,
    if (playStoreLink != null) 'playStoreLink': playStoreLink,
    if (appStoreLink != null) 'appStoreLink': appStoreLink,
    'tags': tags,
  };
}

class SkillCategory {
  const SkillCategory({required this.title, required this.skills});

  final String title;
  final List<String> skills;
}

class PracticeProject {
  const PracticeProject({
    required this.name,
    required this.description,
    required this.youtubeUrl,
    required this.tags,
  });

  final String name;
  final String description;
  final String youtubeUrl;
  final List<String> tags;

  factory PracticeProject.fromJson(Map<String, dynamic> json) => PracticeProject(
        name: json['name'] as String? ?? '',
        description: json['description'] as String? ?? '',
        youtubeUrl: json['youtubeUrl'] as String? ?? '',
        tags: (json['tags'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'youtubeUrl': youtubeUrl,
        'tags': tags,
      };
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
    required this.practiceProjects,
    required this.ctaLabel,
    required this.headshotAsset,
    this.headshotUrl,
    required this.experienceLabel,
    this.githubUrl = '',
    this.linkedinUrl = '',
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
  final String githubUrl;
  final String linkedinUrl;
  final List<Experience> experiences;
  final List<Education> education;
  final List<Project> projects;
  final List<SkillCategory> skills;
  final List<PracticeProject> practiceProjects;

  static PortfolioData get abir => PortfolioData(
    name: 'Abir Rahman',
    title: 'Software Engineer (Flutter Developer)',
    location: 'Dhaka, Bangladesh',
    email: 'abirrahman959@gmail.com',
    phone: '+8801600223852',
    ctaLabel: 'Let’s build something impactful together',
    headshotAsset: 'assets/images/profile.png',
    experienceLabel: '4+ Years',
    githubUrl: 'https://github.com/abir1h',
    linkedinUrl: 'https://www.linkedin.com/in/abir-rahman-3a7050145/',
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
        score: 'CGPA: 3.75 out of 4.00',
      ),
      Education(
        institution: 'Hazi Misir Ali University College',
        degree: 'Higher Secondary School Certificate (HSC)',
        period: '2014 — 2016',
        location: 'Narayanganj, Bangladesh',
        score: 'GPA: 4.92 out of 5.00',
      ),
      Education(
        institution: 'High School', // User didn't specify school name
        degree: 'Secondary School Certificate (SSC)',
        period: 'Graduated 2014',
        location: 'Bangladesh',
        score: 'GPA: 4.17 out of 5.00',
      ),
    ],
    projects: const [
      Project(
        name: 'Prantik Biggyan',
        description:
            'Prantik Biggyan is a modern educational app for students and teachers from participating schools and educational institutions. It brings learning, assessments, communication, and academic progress into one easy-to-use mobile platform.',
        link: 'https://play.google.com/store/apps/details?id=com.prantikbiggyan.app',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.prantikbiggyan.app',
        appStoreLink: 'https://apps.apple.com/pl/app/prantik-biggyan/id6788683315',
        tags: ['Education', 'Courses', 'Quizzes'],
      ),
      Project(
        name: 'Morooj',
        description:
            'Morooj is Kuwait’s go-to app for finding and booking the perfect chalet getaway. Whether you’re planning a family retreat, a weekend with friends, or a private escape, Morooj makes it easy to browse, compare, and reserve top chalets in Kuwait’s most sought-after locations',
        link: 'https://play.google.com/store/apps/details?id=com.app.moroj&hl=en',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.app.moroj&hl=en',
        appStoreLink: 'https://apps.apple.com/kw/app/morooj/id6448949773',
        tags: ['Travel', 'Booking', 'Kuwait'],
      ),
      Project(
        name: 'Marktzoom',
        description:
            'A marketplace platform connecting buyers, sellers, and suppliers with automated offer matching, request tracking, and B2B/B2C procurement tools.',
        link: 'https://play.google.com/store/apps/details?id=app.marktzoom.com',
        playStoreLink: 'https://play.google.com/store/apps/details?id=app.marktzoom.com',
        appStoreLink: 'https://apps.apple.com/jp/app/marktzoom/id6753353675?l=en-US',
        tags: ['Marketplace', 'B2B', 'Procurement'],
      ),
      Project(
        name: 'Vitamins.ae H&B Marketplace',
        description:
            'Health and beauty e-commerce marketplace in the UAE, featuring advanced product search, wishlist & cart management, secure checkout, and real-time order tracking.',
        link:
            'https://play.google.com/store/apps/details?id=ae.propharma.vitamins',
        playStoreLink: 'https://play.google.com/store/apps/details?id=ae.propharma.vitamins',
        tags: ['E-commerce', 'Marketplace', 'Health & Wellness'],
      ),
      Project(
        name: 'Manaful',
        description:
            'Educational management platform designed for schools to streamline, schedule, and monitor tutoring processes with performance dashboards.',
        link: 'https://play.google.com/store/apps/details?id=com.bacbonltd.manaful',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.bacbonltd.manaful',
        appStoreLink: 'https://apps.apple.com/us/app/manaful/id6748067633',
        tags: ['Education', 'Management', 'Scheduling'],
      ),
      Project(
        name: 'Co-Learning Application',
        description:
            'Collaborative learning platform that equips teachers and mentors with interactive content, assessments, and analytics.',
        link:
            'https://play.google.com/store/apps/details?id=com.bacbonltd.colearning&pcampaignid=web_share',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.bacbonltd.colearning&pcampaignid=web_share',
        appStoreLink: 'https://apps.apple.com/us/app/co-learning/id6741468980',
        tags: ['Education', 'Collaboration', 'Firebase'],
      ),
      Project(
        name: 'BacBon Tutors',
        description:
            'End-to-end tutor management platform with scheduling, live classes, and parent-facing insights.',
        link: 'https://apps.apple.com/pl/app/bacbon-tutors/id6449931601',
        playStoreLink: 'https://play.google.com/store/apps/details?id=com.bacbonltd.bacbontutors&pcampaignid=web_share',
        appStoreLink: 'https://apps.apple.com/pl/app/bacbon-tutors/id6449931601',
        tags: ['Marketplace', 'Payments', 'Live Class'],
      ),
      Project(
        name: 'ELIT',
        description:
            'Enterprise learning management system (LMS) designed for Bangladesh Bank, offering course management, employee training, assessments, and progress tracking.',
        link: 'https://play.google.com/store/apps/details?id=bd.org.bb.elit',
        playStoreLink: 'https://play.google.com/store/apps/details?id=bd.org.bb.elit',
        tags: ['LMS', 'Enterprise', 'Education'],
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
        skills: [
          'Flutter SDK',
          'Dart',
          'Clean Architecture',
          'SOLID Principles',
          'OOP'
        ],
      ),
      SkillCategory(
        title: 'Ecosystem',
        skills: [
          'Firebase',
          'REST APIs',
          'Local Databases (Hive, SQLite)',
          'Push Notifications',
          'App Store & Play Store Deployment'
        ],
      ),
      SkillCategory(
        title: 'State Management',
        skills: ['BLoC', 'GetX', 'Riverpod', 'Provider'],
      ),
      SkillCategory(
        title: 'Practices',
        skills: [
          'CI/CD (GitHub Actions, Codemagic)',
          'Code Review',
          'Performance Tuning',
          'Design Systems',
          'Unit & Widget Testing'
        ],
      ),
    ],
    practiceProjects: const [
      PracticeProject(
        name: 'Travel Go',
        description: 'A modern travel booking and exploration app with a beautiful user interface, smooth animations, and an intuitive user experience.',
        youtubeUrl: 'https://youtube.com/shorts/hnul8dCpkRw?si=iVGxXJba4qDLpgPf',
        tags: ['Flutter', 'UI/UX', 'Animation'],
      ),
      PracticeProject(
        name: 'Habit Quest',
        description: 'A gamified habit tracker that rewards users with XP and level-ups for completing daily tasks and routines. Features a clean, highly animated modern dark interface.',
        youtubeUrl: 'https://youtube.com/shorts/ezH-vhCzmwI?si=LGD3dKBkbu1RdbZ4',
        tags: ['Flutter', 'BLoC', 'Gamification', 'Hive'],
      ),
      PracticeProject(
        name: 'Tasky Kanban',
        description: 'A beautiful local-first project management dashboard featuring interactive drag-and-drop lists, custom task templates, and workspace analytics.',
        youtubeUrl: '',
        tags: ['Flutter', 'Hive DB', 'Drag & Drop'],
      ),
      PracticeProject(
        name: 'FitTrack Workout',
        description: 'A minimal, gesture-driven fitness logging app that focuses on ultra-fast logging, offline synchronization, and dynamic progress visualization charts.',
        youtubeUrl: '',
        tags: ['Dart', 'SQLite', 'Custom Painter'],
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
    List<PracticeProject>? practiceProjects,
    String? githubUrl,
    String? linkedinUrl,
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
      practiceProjects: practiceProjects ?? this.practiceProjects,
      ctaLabel: ctaLabel ?? this.ctaLabel,
      headshotAsset: headshotAsset ?? this.headshotAsset,
      headshotUrl: headshotUrl ?? this.headshotUrl,
      experienceLabel: experienceLabel ?? this.experienceLabel,
      githubUrl: githubUrl ?? this.githubUrl,
      linkedinUrl: linkedinUrl ?? this.linkedinUrl,
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
      githubUrl: json['githubUrl'] as String? ?? abir.githubUrl,
      linkedinUrl: json['linkedinUrl'] as String? ?? abir.linkedinUrl,
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
              score: e['score'] as String?,
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
      practiceProjects: (json['practiceProjects'] == null || (json['practiceProjects'] as List).isEmpty)
          ? abir.practiceProjects
          : (json['practiceProjects'] as List<dynamic>)
              .map((e) => PracticeProject.fromJson(Map<String, dynamic>.from(e)))
              .toList(),
      ctaLabel: json['ctaLabel'] as String? ?? abir.ctaLabel,
      headshotAsset: json['headshotAsset'] as String? ?? abir.headshotAsset,
      headshotUrl: json['headshotUrl'] as String?,
      experienceLabel:
          json['experienceLabel'] as String? ?? abir.experienceLabel,
    );
  }
}
