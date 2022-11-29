import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/screens/mails/mails_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class EmailDetailsPage extends StatelessWidget {
  final EmailModel mail;

  const EmailDetailsPage({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        return Hero(
          tag: mail.id.toString(),
          child: Scaffold(
            body: Container(
              color: Theme.of(context).backgroundColor,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: 100.w,
                    height: 100.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Theme.of(context).cardTheme.color,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 0.5.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                SizedBox(
                                  width: 80.w,
                                  child: Center(
                                    child: Text(
                                      mail.subject,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Container(
                          color: Theme.of(context).cardTheme.color,
                          width: 100.w,
                          child: Padding(
                            padding: EdgeInsets.all(1.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SelectableText("de: ${mail.sender}"),
                                SizedBox(
                                  height: 1.h,
                                ),
                                SelectableText("à: ${mail.receiver}"),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Expanded(
                          child: Container(
                            color: Theme.of(context).cardTheme.color,
                            padding: EdgeInsets.all(1.h),
                            child: EmailContentWidget(mail: mail),
                          ),
                        ),
                        (mail.attachments.isNotEmpty)
                            ? Container(
                                color: Theme.of(context).cardTheme.color,
                                padding: EdgeInsets.all(1.h),
                                height: 12.h,
                                width: 100.w,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: mail.attachments.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.all(1.h),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          onTap: () async {
                                            //save data in a file and open it
                                            final directory =
                                                await getTemporaryDirectory();
                                            final file = File(
                                                '${directory.path}/${mail.attachments[index].name}');
                                            await file.writeAsBytes(
                                                mail.attachments[index].data);
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    SaveOrOpenDialogWidget(
                                                      filePath: file.path,
                                                    ));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.attach_file,
                                                size: 20.sp,
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              Text(
                                                mail.attachments[index].name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 10.h,
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: (state.status == EmailStatus.initial ||
                              state.status == EmailStatus.connecting ||
                              state.status == EmailStatus.cacheLoaded ||
                              state.status == EmailStatus.cacheSorted ||
                              state.status == EmailStatus.error)
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSendPage(
                                    replyAll: false,
                                    replyOriginalMessage: mail.id,
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(
                        Icons.reply,
                      )),
                  IconButton(
                      onPressed: (state.status == EmailStatus.initial ||
                              state.status == EmailStatus.connecting ||
                              state.status == EmailStatus.cacheLoaded ||
                              state.status == EmailStatus.cacheSorted ||
                              state.status == EmailStatus.error)
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EmailSendPage(
                                    replyAll: true,
                                    replyOriginalMessage: mail.id,
                                  ),
                                ),
                              );
                            },
                      icon: const Icon(Icons.reply_all))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
