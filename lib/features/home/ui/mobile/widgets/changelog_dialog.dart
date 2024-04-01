import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/home/ui/widgets/changelog_dialog.dart';

class ChangelogDialogMobile extends ChangelogDialog {
  const ChangelogDialogMobile(super.packageInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        getTitle(context),
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.whatsnew,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            getChangelog(context),
            style: const TextStyle(
              height: 1.7,
            ),
          ),
        ],
      ),
      actionsOverflowAlignment: OverflowBarAlignment.start,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.dontshowagain),
              onPressed: () => disableChangelog(context),
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.great),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }
}
