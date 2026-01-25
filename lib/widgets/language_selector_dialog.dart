import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../l10n/app_localizations.dart';
import '../providers/locale_provider.dart';
import '../services/easter_egg_service.dart';
import '../theme/app_theme.dart';

/// Dialog for selecting app language
class LanguageSelectorDialog extends ConsumerStatefulWidget {
  const LanguageSelectorDialog({super.key});

  @override
  ConsumerState<LanguageSelectorDialog> createState() => _LanguageSelectorDialogState();
}

class _LanguageSelectorDialogState extends ConsumerState<LanguageSelectorDialog> {
  List<String> _availableLanguages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLanguages();
  }

  Future<void> _loadLanguages() async {
    final notifier = ref.read(localeNotifierProvider);
    final languages = await notifier.getAvailableLanguages();
    if (mounted) {
      setState(() {
        _availableLanguages = languages;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeProvider);
    final notifier = ref.read(localeNotifierProvider);
    final hasHiddenUnlocked = ref.watch(hiddenLanguagesUnlockedProvider);

    return AlertDialog(
      backgroundColor: AppColors.primaryGradientEnd,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Row(
        children: [
          const Icon(Icons.language, color: AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            l10n.languageTitle,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        ],
      ),
      content: _isLoading
          ? const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Standard languages
                  ..._buildLanguageList(
                    _availableLanguages.where((l) => !EasterEggService.hiddenLanguages.contains(l)).toList(),
                    currentLocale,
                    notifier,
                  ),
                  // Hidden languages section (if unlocked)
                  if (hasHiddenUnlocked) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: AppColors.textSecondary),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          const Text('🔓', style: TextStyle(fontSize: 14)),
                          const SizedBox(width: 4),
                          Text(
                            l10n.languageSecretSection,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ..._buildLanguageList(
                      _availableLanguages.where((l) => EasterEggService.hiddenLanguages.contains(l)).toList(),
                      currentLocale,
                      notifier,
                    ),
                  ],
                ],
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.closeButton),
        ),
      ],
    );
  }

  List<Widget> _buildLanguageList(
    List<String> languages,
    Locale? currentLocale,
    LocaleNotifier notifier,
  ) {
    return languages.map((code) {
      final isSelected = currentLocale?.languageCode == code;
      final flag = notifier.getLanguageFlag(code);
      final name = notifier.getLanguageName(code);

      return ListTile(
        leading: Text(flag, style: const TextStyle(fontSize: 24)),
        title: Text(
          name,
          style: TextStyle(
            color: isSelected ? AppColors.accentGold : AppColors.textPrimary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        trailing: isSelected
            ? const Icon(Icons.check, color: AppColors.accentGold)
            : null,
        onTap: () async {
          await notifier.setLocale(code);
          if (mounted) {
            Navigator.pop(context);
          }
        },
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      );
    }).toList();
  }
}
