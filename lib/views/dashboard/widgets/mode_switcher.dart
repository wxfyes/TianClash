import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModeSwitcher extends ConsumerWidget {
  const ModeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(
      patchClashConfigProvider.select((state) => state.mode),
    );

    return CommonCard(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SegmentedButton<Mode>(
          segments: [
            ButtonSegment<Mode>(
              value: Mode.rule,
              label: const Text('智能'),
              icon: const Icon(Icons.playlist_add_check),
            ),
            ButtonSegment<Mode>(
              value: Mode.global,
              label: const Text('全局'),
              icon: const Icon(Icons.public),
            ),
          ],
          selected: {mode == Mode.direct ? Mode.rule : mode},
          onSelectionChanged: (Set<Mode> newSelection) {
            if (newSelection.isEmpty) return;
            final selectedMode = newSelection.first;
            globalState.appController.changeMode(selectedMode);
          },
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ),
    );
  }
}
