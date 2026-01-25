import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_localizations.dart';
import '../services/supporter_service.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';

/// Card showing supporter status and tip jar options.
class SupporterCard extends StatefulWidget {
  const SupporterCard({super.key});

  @override
  State<SupporterCard> createState() => _SupporterCardState();
}

class _SupporterCardState extends State<SupporterCard> {
  final SupporterService _supporterService = SupporterService();
  SupporterStatus? _status;
  bool _showTipJar = false;

  @override
  void initState() {
    super.initState();
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    final status = await _supporterService.getStatus();
    if (mounted) {
      setState(() => _status = status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                _status?.tier?.badge ?? '💝',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                l10n.supportTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (_status?.isSupporter == true)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accentGold.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.supporterBadge,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.accentGold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _status?.isSupporter == true ? l10n.supportThanks : l10n.supportPrompt,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          if (_status?.isSupporter != true) ...[
            // Tip jar toggle
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => setState(() => _showTipJar = !_showTipJar),
                icon: Icon(
                  _showTipJar ? Icons.expand_less : Icons.favorite,
                  size: 18,
                ),
                label: Text(_showTipJar ? l10n.supportHideTipJar : l10n.supportOpenTipJar),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            if (_showTipJar) ...[
              const SizedBox(height: 16),
              _buildTipOptions(l10n),
            ],
          ],
          const SizedBox(height: 12),
          _buildExternalLinks(l10n),
        ],
      ),
    );
  }

  Widget _buildTipOptions(AppLocalizations l10n) {
    // Map tier IDs to localized names/descriptions
    final localizedTiers = {
      'coffee': (l10n.tipCoffee, l10n.tipCoffeeDesc),
      'supporter': (l10n.tipSupporter, l10n.tipSupporterDesc),
      'legendary': (l10n.tipLegendary, l10n.tipLegendaryDesc),
    };

    return Column(
      children: SupporterService.tiers.entries.map((entry) {
        final tier = entry.value;
        final (name, desc) = localizedTiers[entry.key] ?? (tier.name, tier.description);
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _TipOption(
            badge: tier.badge,
            name: name,
            description: desc,
            price: tier.displayPrice,
            onTap: () => _handleTip(entry.key, l10n),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExternalLinks(AppLocalizations l10n) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _launchUrl('https://github.com/sponsors/aaronjohnson'),
              icon: const Icon(Icons.favorite_border, size: 16),
              label: Text(l10n.supportGitHubSponsors),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
            ),
            const Text('•', style: TextStyle(color: AppColors.textSecondary)),
            TextButton.icon(
              onPressed: () => _launchUrl('https://www.patreon.com/aaronjohnson'),
              icon: const Icon(Icons.star_border, size: 16),
              label: Text(l10n.supportPatreon),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () => _launchUrl('https://github.com/aaronjohnson/step_quest'),
          icon: const Icon(Icons.code, size: 16),
          label: Text(l10n.supportSourceCode),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Future<void> _handleTip(String tierId, AppLocalizations l10n) async {
    // TODO: Implement Google Play Billing
    // For now, show a coming soon message
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.supportTipComing),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _TipOption extends StatelessWidget {
  final String badge;
  final String name;
  final String description;
  final String price;
  final VoidCallback onTap;

  const _TipOption({
    required this.badge,
    required this.name,
    required this.description,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black26,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Text(badge, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accentGold,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
