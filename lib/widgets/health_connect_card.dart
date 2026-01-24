import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
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
              const Text(
                'Health Connect',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              _buildStatusChip(),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _getStatusMessage(),
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          _buildActionButton(),
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

  Widget _buildStatusChip() {
    final (label, color) = switch (widget.status) {
      HealthConnectStatus.authorized => ('Connected', AppColors.accentGold),
      HealthConnectStatus.notAuthorized => ('Not Connected', AppColors.textSecondary),
      HealthConnectStatus.unavailable => ('Unavailable', Colors.red.shade300),
      HealthConnectStatus.unknown => ('Checking...', AppColors.textSecondary),
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

  String _getStatusMessage() {
    switch (widget.status) {
      case HealthConnectStatus.authorized:
        return 'Your steps are syncing automatically from Health Connect.';
      case HealthConnectStatus.notAuthorized:
        return 'Connect to sync steps from your fitness apps automatically.';
      case HealthConnectStatus.unavailable:
        return 'Health Connect is not available. Use manual step logging.';
      case HealthConnectStatus.unknown:
        return 'Checking Health Connect availability...';
    }
  }

  Widget _buildActionButton() {
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
          label: Text(widget.isSyncing ? 'Syncing...' : 'Sync Now'),
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
        label: const Text('Connect Health'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGold,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}
