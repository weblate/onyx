import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/extensions/mail_box_extension.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

class EmailMailboxChooserWidget extends StatefulWidget {
  const EmailMailboxChooserWidget({Key? key}) : super(key: key);

  @override
  State<EmailMailboxChooserWidget> createState() =>
      _EmailMailboxChooserWidgetState();
}

class _EmailMailboxChooserWidgetState extends State<EmailMailboxChooserWidget> {
  GlobalKey key = GlobalKey();
  late int _key;

  @override
  void initState() {
    _collapse();
    super.initState();
  }

  _collapse() {
    int newKey = 0;
    do {
      _key = Random().nextInt(10000);
    } while (newKey == _key);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0.5.h),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    key: Key(_key.toString()),
                    //disable the divider at top and bottom whenn expanded

                    title: Text(
                      state.currentMailBox!.name,
                      textAlign: TextAlign.center,
                    ),
                    children: state.mailBoxes
                        .map((e) => Material(
                              color: (state.currentMailBox!.name == e.name)
                                  ? Theme.of(context).primaryColor
                                  : null,
                              child: InkWell(
                                onTap: () {
                                  context.read<EmailCubit>().load(
                                        blockTrackers: context
                                            .read<SettingsCubit>()
                                            .state
                                            .settings
                                            .blockTrackers,
                                        mailbox: e,
                                      );
                                  _collapse();
                                },
                                child: Row(
                                  children: [
                                    Icon(e.toIcon()),
                                    Text(e.name),
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
