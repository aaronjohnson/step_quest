import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../providers/game_state_provider.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';

/// Card for Health Connect integration status and sync.
class HealthConnectCard extends StatefulWidget {
  final HealthConnectStatus status;
  final VoidCallback onConnect;
  final VoidCallback onSync;
  final bool isSyncing;

  const HealthConnectCard({
    super.key,
    required this.status,
    required this.onConnect,
    required this.onSync,
    this.isSyncing = false,
  });

  @override
  State<HealthConnectCard> createState() => _HealthConnectCardState();
}

class _HealthConnectCardState extends State<HealthConnectCard> {
  bool _showInfo = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getStatusIcon(),
                color: _getStatusColor(),
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.healthConnectTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              _buildStatusChip(l10n),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getStatusMessage(l10n),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          _buildActionButton(l10n),
          const SizedBox(height: 8),
          _buildInfoToggle(l10n),
          if (_showInfo) _buildInfoSection(l10n),
        ],
      ),
    );
  }

  Widget _buildInfoToggle(AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => setState(() => _showInfo = !_showInfo),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _showInfo ? Icons.expand_less : Icons.expand_more,
            size: 16,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 4),
          Text(
            _showInfo ? l10n.healthConnectHideDetails : l10n.healthConnectHowItWorks,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(AppLocalizations l10n) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.healthConnectSyncPathTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.healthConnectSyncPathDescription,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.healthConnectMoreSensors,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.healthConnectMoreSensorsDescription,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon() {
    switch (widget.status) {
      case HealthConnectStatus.authorized:
        return Icons.check_circle;
      case HealthConnectStatus.notAuthorized:
        return Icons.lock_outline;
      case HealthConnectStatus.unavailable:
        return Icons.error_outline;
      case HealthConnectStatus.unknown:
        return Icons.help_outline;
    }
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case HealthConnectStatus.authorized:
        return AppColors.accentGold;
      case HealthConnectStatus.notAuthorized:
        return AppColors.textSecondary;
      case HealthConnectStatus.unavailable:
        return Colors.red.shade300;
      case HealthConnectStatus.unknown:
        return AppColors.textSecondary;
    }
  }

  Widget _buildStatusChip(AppLocalizations l10n) {
    final (label, color) = switch (widget.status) {
      HealthConnectStatus.authorized => (l10n.healthConnectConnected, AppColors.accentGold),
      HealthConnectStatus.notAuthorized => (l10n.healthConnectNotConnected, AppColors.textSecondary),
      HealthConnectStatus.unavailable => (l10n.healthConnectUnavailable, Colors.red.shade300),
      HealthConnectStatus.unknown => (l10n.healthConnectChecking, AppColors.textSecondary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
    );
  }

  String _getStatusMessage(AppLocalizations l10n) {
    switch (widget.status) {
      case HealthConnectStatus.authorized:
        return l10n.healthConnectSyncMessage;
      case HealthConnectStatus.notAuthorized:
        return l10n.healthConnectPrompt;
      case HealthConnectStatus.unavailable:
        return l10n.healthConnectUnavailableMessage;
      case HealthConnectStatus.unknown:
        return l10n.healthConnectChecking;
    }
  }

  Widget _buildActionButton(AppLocalizations l10n) {
    if (widget.status == HealthConnectStatus.unavailable) {
      return const SizedBox.shrink();
    }

    if (widget.status == HealthConnectStatus.authorized) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: widget.isSyncing ? null : widget.onSync,
          icon: widget.isSyncing
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.sync, size: 18),
          label: Text(widget.isSyncing ? l10n.healthConnectSyncing : l10n.healthConnectSyncNow),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.cardOverlay,
            foregroundColor: AppColors.textPrimary,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: widget.onConnect,
        icon: const Icon(Icons.link, size: 18),
        label: Text(l10n.healthConnectConnect),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGold,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
