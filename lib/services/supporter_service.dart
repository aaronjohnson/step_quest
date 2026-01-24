import 'package:shared_preferences/shared_preferences.dart';

/// Manages supporter status and tip jar purchases.
///
/// Currently uses local storage for supporter status.
/// Will integrate with Google Play Billing for IAP.
class SupporterService {
  static const String _supporterKey = 'is_supporter';
  static const String _supporterTierKey = 'supporter_tier';
  static const String _supporterDateKey = 'supporter_date';

  /// Supporter tiers for tip jar (prime number pricing)
  /// Actual prices come from Google Play IAP (localized per country)
  static final Map<String, SupporterTier> tiers = {
    'coffee': SupporterTier(
      id: 'tip_coffee',
      name: 'Buy a Coffee',
      fallbackPrice: '~2', // Actual price from Google Play IAP
      description: 'A small thanks!',
      badge: '☕',
    ),
    'supporter': SupporterTier(
      id: 'tip_supporter',
      name: 'Support the Quest',
      fallbackPrice: '~3', // Actual price from Google Play IAP
      description: 'Help keep development going',
      badge: '⭐',
    ),
    'legendary': SupporterTier(
      id: 'tip_legendary',
      name: 'Legendary Patron',
      fallbackPrice: '~7', // Actual price from Google Play IAP
      description: 'You are a legend!',
      badge: '👑',
    ),
  };

  /// Check if user is a supporter
  Future<bool> isSupporter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_supporterKey) ?? false;
  }

  /// Get supporter tier (if any)
  Future<String?> getSupporterTier() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_supporterTierKey);
  }

  /// Get supporter badge based on tier
  Future<String?> getSupporterBadge() async {
    final tier = await getSupporterTier();
    if (tier == null) return null;
    return tiers[tier]?.badge;
  }

  /// Mark user as supporter (called after successful IAP)
  Future<void> markAsSupporter(String tierId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_supporterKey, true);
    await prefs.setString(_supporterTierKey, tierId);
    await prefs.setString(_supporterDateKey, DateTime.now().toIso8601String());
  }

  /// Get supporter status details
  Future<SupporterStatus> getStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isSupporter = prefs.getBool(_supporterKey) ?? false;
    final tier = prefs.getString(_supporterTierKey);
    final dateStr = prefs.getString(_supporterDateKey);

    return SupporterStatus(
      isSupporter: isSupporter,
      tier: tier != null ? tiers[tier] : null,
      supportedDate: dateStr != null ? DateTime.parse(dateStr) : null,
    );
  }

  // TODO: Implement Google Play Billing
  // Future<bool> purchaseTip(String tierId) async {
  //   // 1. Initialize billing client
  //   // 2. Query product details
  //   // 3. Launch purchase flow
  //   // 4. Verify purchase
  //   // 5. Call markAsSupporter on success
  //   return false;
  // }
}

/// Represents a supporter tier / tip option
class SupporterTier {
  final String id;
  final String name;
  final String fallbackPrice; // Shown before IAP loads, e.g. "~2"
  final String description;
  final String badge;

  /// Localized price from Google Play (set at runtime)
  String? localizedPrice;

  SupporterTier({
    required this.id,
    required this.name,
    required this.fallbackPrice,
    required this.description,
    required this.badge,
    this.localizedPrice,
  });

  /// Display price (localized if available, fallback otherwise)
  String get displayPrice => localizedPrice ?? fallbackPrice;
}

/// Current supporter status
class SupporterStatus {
  final bool isSupporter;
  final SupporterTier? tier;
  final DateTime? supportedDate;

  const SupporterStatus({
    required this.isSupporter,
    this.tier,
    this.supportedDate,
  });
}
