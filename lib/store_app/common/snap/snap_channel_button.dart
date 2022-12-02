/*
 * Copyright (C) 2022 Canonical Ltd
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:software/l10n/l10n.dart';
import 'package:software/store_app/common/constants.dart';
import 'package:software/store_app/common/snap/snap_model.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SnapChannelPopupButton extends StatelessWidget {
  const SnapChannelPopupButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SnapModel>();
    final theme = Theme.of(context);
    final labelStyle = TextStyle(
      color: theme.disabledColor,
      fontSize: 14,
    );
    const infoStyle = TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 14,
    );
    final light = theme.brightness == Brightness.light;

    return YaruPopupMenuButton(
      initialValue: model.channelToBeInstalled,
      tooltip: context.l10n.channel,
      itemBuilder: (v) => [
        for (final entry in model.selectableChannels.entries)
          PopupMenuItem(
            value: entry.key,
            padding: EdgeInsets.zero,
            onTap: () {
              model.channelToBeInstalled = entry.key;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          context.l10n.channel,
                          style: labelStyle,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          context.l10n.version,
                          style: labelStyle,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          context.l10n.releasedAt,
                          style: labelStyle,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: infoStyle,
                          maxLines: 1,
                        ),
                        Text(
                          entry.value.version,
                          style: infoStyle,
                          maxLines: 1,
                        ),
                        Text(
                          DateFormat.yMd(Platform.localeName)
                              .format(entry.value.releasedAt),
                          style: infoStyle,
                          maxLines: 1,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          )
      ],
      child: Text(
        model.channelToBeInstalled,
        style: model.selectedChannelVersion != model.version
            ? TextStyle(color: light ? kGreenLight : kGreenDark)
            : null,
      ),
    );
  }
}
