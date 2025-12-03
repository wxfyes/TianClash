import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutboundMode extends StatelessWidget {
  const OutboundMode({super.key});

  Color _getTextColor(BuildContext context, Mode mode) {
    return switch (mode) {
      Mode.rule => context.colorScheme.onSecondaryContainer,
      Mode.global => context.colorScheme.onPrimaryContainer,
      Mode.direct => context.colorScheme.onTertiaryContainer,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final mode = ref.watch(
          patchClashConfigProvider.select((state) => state.mode),
        );

        return SegmentedButton<Mode>(
          segments: const [
            ButtonSegment<Mode>(
              value: Mode.rule,
              label: Text('智能'),
              icon: Icon(Icons.auto_fix_high),
            ),
            ButtonSegment<Mode>(
              value: Mode.global,
              label: Text('全局'),
              icon: Icon(Icons.public),
            ),
          ],
          selected: {mode == Mode.direct ? Mode.rule : mode},
          onSelectionChanged: (Set<Mode> newSelection) {
            globalState.appController.changeMode(newSelection.first);
          },
          showSelectedIcon: false,
          style: ButtonStyle(
            visualDensity: VisualDensity.comfortable,
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        );
      },
    );
  }
}

