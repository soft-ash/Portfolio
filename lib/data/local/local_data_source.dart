import '../models/blog_model.dart';
import '../models/certification_model.dart';
import '../models/education_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/service_model.dart';
import '../models/skill_model.dart';

class LocalDataSource {
  LocalDataSource._();

  // ── PROJECTS ──────────────────────────────────────────────────────────────

  static List<ProjectModel> getProjects() => [
        const ProjectModel(
          id: 'taco-ride',
          title: 'Taco — Ride Sharing Platform',
          shortDescription:
              'Real-time ride-sharing platform with live tracking, chat, and fare negotiation.',
          description:
              'Built a real-time ride-sharing platform with live tracking, chat, Google Maps, and fare negotiation. Integrated Stripe, Orange Money, and Wave payments; deployed apps for Google Play and App Store.',
          category: 'Mobile',
          technologies: ['Flutter', 'REST APIs', 'Socket.IO', 'GetX', 'Stripe'],
          featured: true,
          year: 2024,
          githubUrl: '',
          features: [
            'Live tracking & Google Maps integration',
            'Real-time chat & Fare negotiation',
            'Stripe, Orange Money & Wave payments',
            'Published on Google Play & App Store',
          ],
        ),
        const ProjectModel(
          id: 'raiz-social',
          title: 'Raíz — Social Networking Platform',
          shortDescription:
              'Role-based social platform with chat, audio/video calling, stories, and AI chatbot.',
          description:
              'Developed a role-based social platform with chat, audio/video calling, stories, campaigns, rewards, AI chatbot and push notifications using WebRTC, Socket.IO, and Firebase. Built a marketplace with Stripe payments, maps, deep links, and secure authentication.',
          category: 'Mobile',
          technologies: ['Flutter', 'WebRTC', 'Socket.IO', 'Firebase', 'Stripe', 'GetX'],
          featured: true,
          year: 2023,
          githubUrl: '',
          features: [
            'Audio/Video calling with WebRTC',
            'Stories, Campaigns & Rewards',
            'AI Chatbot integration',
            'Marketplace with Stripe payments',
            'Deep links & Secure session management',
          ],
        ),
        const ProjectModel(
          id: 'linkyetu-edu',
          title: 'LinkYetu — Education Platform',
          shortDescription:
              'Multi-role education platform combining social networking, events, and job opportunities.',
          description:
              'Developed a multi-role education platform that combines social networking, event management, job opportunities, and learning progress tracking for students, teachers, universities, recruiters, and partners.',
          category: 'Mobile',
          technologies: ['Flutter', 'GetX', 'Firebase', 'REST APIs', 'Socket.IO'],
          featured: true,
          year: 2023,
          githubUrl: '',
          features: [
            'Social feeds & Community engagement',
            'Event organization & Job search',
            'Role-based access control',
            'Learning progress tracking',
          ],
        ),
        const ProjectModel(
          id: 'motorspot-racing',
          title: 'MotorSpot — Racing Community Platform',
          shortDescription:
              'Racing community app with social feed, real-time chat, leaderboards, and AI chatbot.',
          description:
              'Built a Flutter-based racing community app with social feed, real-time chat, leaderboards, events, campaigns, and role-based user access. Developed interactive features including Head-to-Head battles, Raw Shift competitions, Official Partner registration, and an AI chatbot.',
          category: 'Mobile',
          technologies: ['Flutter', 'GetX', 'Firebase', 'Socket.IO'],
          featured: false,
          year: 2024,
          githubUrl: '',
          features: [
            'Head-to-Head battles & Raw Shift competitions',
            'Social feed & Real-time chat',
            'Leaderboards, Events, & Campaigns',
            'AI Chatbot & Partner registration',
          ],
        ),
        const ProjectModel(
          id: '48hours-dating',
          title: '48 Hours — Dating Platform',
          shortDescription:
              'Scalable dating platform with Bumble-inspired onboarding and Clean Architecture.',
          description:
              'Built a scalable cross-platform Flutter app with GetX, feature-based modular architecture, responsive design, and reusable widgets. Developed a complete authentication flow (splash, welcome, phone number, OTP verification) inspired by Bumble.',
          category: 'Mobile',
          technologies: ['Flutter', 'GetX', 'Clean Architecture'],
          featured: false,
          year: 2024,
          githubUrl: '',
          features: [
            'Clean Architecture & Modular design',
            'Bumble-inspired onboarding',
            'Phone number OTP authentication',
            'Responsive UI & Reusable widgets',
          ],
        ),
      ];

  // ── EXPERIENCE ────────────────────────────────────────────────────────────

  static List<ExperienceModel> getExperiences() => [
        const ExperienceModel(
          id: 'exp-1',
          company: 'Softvence Omega, Betopia',
          position: 'Jr. Executive Mobile App',
          startDate: 'Jan 2026',
          isCurrent: true,
          location: 'Dhaka, Bangladesh',
          description:
              'Developed cross-platform Android & iOS apps using Flutter and Dart. '
              'Integrated REST APIs, Firebase, Socket.IO, and WebRTC. '
              'Built responsive UI with GetX and Riverpod state management. '
              'Optimized app performance and fixed production issues. '
              'Published and maintained apps on Google Play and Apple App Store.',
          responsibilities: [
            'Developed cross-platform Android & iOS apps using Flutter and Dart',
            'Integrated REST APIs, Firebase, Socket.IO, and WebRTC',
            'Built responsive UI with GetX and Riverpod state management',
            'Optimized app performance and fixed production issues',
            'Published and maintained apps on Google Play and Apple App Store',
          ],
          technologies: ['Flutter', 'Dart', 'GetX', 'Riverpod', 'Firebase', 'REST APIs', 'Socket.IO', 'WebRTC'],
        ),
      ];

  // ── EDUCATION ─────────────────────────────────────────────────────────────

  static List<EducationModel> getEducation() => [
        const EducationModel(
          id: 'edu-1',
          degree: 'BSc. in Software Engineering',
          major: 'Data Science',
          institution: 'Daffodil International Univercity',
          startYear: 2023,
          endYear: 2027,
          description:
              'Pursuing a Bachelor of Science in Software Engineering with a specialization '
              'in Data Science. Gaining strong foundations in software architecture, '
              'algorithms, and machine learning.',
        ),
      ];

  // ── SKILLS ────────────────────────────────────────────────────────────────

  static List<SkillModel> getSkills() => [
        // Languages
        const SkillModel(id: 's-1', name: 'Dart', category: SkillCategory.programming, proficiency: 5),
        const SkillModel(id: 's-2', name: 'Kotlin', category: SkillCategory.programming, proficiency: 4),
        const SkillModel(id: 's-3', name: 'Java', category: SkillCategory.programming, proficiency: 4),
        const SkillModel(id: 's-4', name: 'Python', category: SkillCategory.programming, proficiency: 4),
        const SkillModel(id: 's-5', name: 'C', category: SkillCategory.programming, proficiency: 4),
        
        // Frameworks
        const SkillModel(id: 's-6', name: 'Flutter', category: SkillCategory.mobile, proficiency: 5),
        const SkillModel(id: 's-7', name: 'Jetpack Compose', category: SkillCategory.mobile, proficiency: 4),
        
        // State Management (mapped to stateManagement)
        const SkillModel(id: 's-8', name: 'GetX', category: SkillCategory.stateManagement, proficiency: 5),
        const SkillModel(id: 's-9', name: 'Riverpod', category: SkillCategory.stateManagement, proficiency: 4),
        
        // Backend, APIs
        const SkillModel(id: 's-10', name: 'Firebase', category: SkillCategory.backend, proficiency: 5),
        const SkillModel(id: 's-11', name: 'REST APIs', category: SkillCategory.backend, proficiency: 5),
        const SkillModel(id: 's-12', name: 'Socket.IO', category: SkillCategory.backend, proficiency: 4),
        const SkillModel(id: 's-13', name: 'WebRTC / Agora', category: SkillCategory.backend, proficiency: 4),
        
        // Tools & Services
        const SkillModel(id: 's-14', name: 'Git & GitHub', category: SkillCategory.tools, proficiency: 5),
        const SkillModel(id: 's-15', name: 'Postman / Swagger', category: SkillCategory.tools, proficiency: 5),
        const SkillModel(id: 's-16', name: 'Google Maps / MapBox', category: SkillCategory.tools, proficiency: 4),
        const SkillModel(id: 's-17', name: 'Stripe Payments', category: SkillCategory.tools, proficiency: 4),
        
        // AI / ML
        const SkillModel(id: 's-18', name: 'Claude / Gemini / ChatGPT APIs', category: SkillCategory.aiMl, proficiency: 5),
      ];

  // ── CERTIFICATIONS ────────────────────────────────────────────────────────

  static List<CertificationModel> getCertifications() => [];

  // ── SERVICES ──────────────────────────────────────────────────────────────

  static List<ServiceModel> getServices() => [
        ServiceModel(
          id: 'svc-1',
          title: 'Flutter App Development',
          description:
              'End-to-end cross-platform application development for Android and iOS '
              'using Flutter and Dart with clean architecture principles.',
          emojiIcon: '📱',
          features: [
            'Cross-platform (Android, iOS)',
            'Clean Architecture & GetX/Riverpod',
            'Custom animations & UIs',
            'Play Store & App Store deployment',
          ],
          accentColorHex: '#7C6EFA',
        ),
        ServiceModel(
          id: 'svc-2',
          title: 'Real-Time Applications',
          description:
              'Build highly interactive real-time experiences using WebRTC for video calls, '
              'Socket.IO for live data, or Firebase for instant sync.',
          emojiIcon: '⚡',
          features: [
            'Video & Audio calling with WebRTC/Agora',
            'Live chat & messaging',
            'Real-time data synchronization',
            'Push notifications',
          ],
          accentColorHex: '#38BDF8',
        ),
        ServiceModel(
          id: 'svc-3',
          title: 'Backend API Integration',
          description:
              'Seamless integration of robust REST APIs and complex payment gateways '
              'like Stripe, Wave, and Orange Money into mobile applications.',
          emojiIcon: '🔗',
          features: [
            'REST API integration',
            'Payment Gateway integration',
            'Deep linking & routing',
            'Authentication & Security',
          ],
          accentColorHex: '#00D4AA',
        ),
        ServiceModel(
          id: 'svc-4',
          title: 'Map & Location Services',
          description:
              'Develop location-based features like ride-sharing, live tracking, and '
              'geofencing using Google Maps, MapBox, and TomTom.',
          emojiIcon: '🗺️',
          features: [
            'Live tracking & GPS',
            'Google Maps & MapBox',
            'Route planning',
            'Location-based features',
          ],
          accentColorHex: '#FFB347',
        ),
      ];

  // ── BLOG ──────────────────────────────────────────────────────────────────

  static List<BlogModel> getBlogPosts() => [];
}
