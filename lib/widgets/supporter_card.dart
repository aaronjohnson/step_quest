import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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
              const Text(
                'Support Step Quest',
                style: TextStyle(
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
                  child: const Text(
                    'Supporter',
                    style: TextStyle(
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
            _status?.isSupporter == true
                ? 'Thank you for supporting the quest! Your generosity keeps the fortress running.'
                : 'Step Quest is free and open source. Tips help fund development and keep ads away.',
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
                label: Text(_showTipJar ? 'Hide Tip Jar' : 'Open Tip Jar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  foregroundColor: Colors.black,
                ),
              ),
            ),
            if (_showTipJar) ...[
              const SizedBox(height: 16),
              _buildTipOptions(),
            ],
          ],
          const SizedBox(height: 12),
          _buildExternalLinks(),
        ],
      ),
    );
  }

  Widget _buildTipOptions() {
    return Column(
      children: SupporterService.tiers.entries.map((entry) {
        final tier = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _TipOption(
            tier: tier,
            onTap: () => _handleTip(entry.key),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExternalLinks() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () => _launchUrl('https://github.com/sponsors/aaronjohnson'),
              icon: const Icon(Icons.favorite_border, size: 16),
              label: const Text('GitHub Sponsors'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
            ),
            const Text('•', style: TextStyle(color: AppColors.textSecondary)),
            TextButton.icon(
              onPressed: () => _launchUrl('https://www.patreon.com/aaronjohnson'),
              icon: const Icon(Icons.star_border, size: 16),
              label: const Text('Patreon'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () => _launchUrl('https://github.com/aaronjohnson/step_quest'),
          icon: const Icon(Icons.code, size: 16),
          label: const Text('View Source Code'),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Future<void> _handleTip(String tierId) async {
    // TODO: Implement Google Play Billing
    // For now, show a coming soon message
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tip jar coming soon! For now, visit GitHub Sponsors.'),
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
  final SupporterTier tier;
  final VoidCallback onTap;

  const _TipOption({
    required this.tier,
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
              Text(tier.badge, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tier.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      tier.description,
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
                  tier.displayPrice,
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
