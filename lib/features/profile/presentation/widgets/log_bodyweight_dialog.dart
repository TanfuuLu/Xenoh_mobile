import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/weight_units.dart';
import '../../../../l10n/app_localizations.dart';

/// Small dialog to log a bodyweight entry. [initialWeight] is in kg and the
/// dialog pops the entered weight converted back to kg on save (or null on
/// cancel) - [unit] only affects what's displayed/typed in between. Owns its
/// [TextEditingController] so the controller's lifecycle is tied to the
/// dialog element (avoids teardown/IME races).
class LogBodyweightDialog extends StatefulWidget {
  const LogBodyweightDialog({
    required this.unit,
    this.initialWeight,
    super.key,
  });

  final double? initialWeight;
  final WeightUnit unit;

  @override
  State<LogBodyweightDialog> createState() => _LogBodyweightDialogState();
}

class _LogBodyweightDialogState extends State<LogBodyweightDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialWeight == null
        ? ''
        : formatWeight(widget.unit.fromKg(widget.initialWeight!)),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final entered = double.parse(_controller.text.trim());
    Navigator.pop(context, widget.unit.toKg(entered));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unit = widget.unit;
    final min = unit.fromKg(20);
    final max = unit.fromKg(500);
    return AlertDialog(
      title: Text(l10n.profileLogBodyweightTitle),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
          ],
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            labelText: l10n.profileWeightLabel,
            suffixText: unit.suffix,
          ),
          onFieldSubmitted: (_) => _submit(),
          validator: (v) {
            final w = double.tryParse((v ?? '').trim());
            if (w == null) return l10n.commonEnterNumberError;
            if (w < min || w > max) {
              return l10n.profileWeightRangeWithUnitError(
                formatWeight(min),
                formatWeight(max),
                unit.suffix,
              );
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(onPressed: _submit, child: Text(l10n.commonSave)),
      ],
    );
  }
}
