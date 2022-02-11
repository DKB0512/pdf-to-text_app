import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_upload_app/bloc/fileupload_bloc.dart';
import 'package:pdf_upload_app/file_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String filePath = "";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileuploadBloc(
        RepositoryProvider.of<FileUploadService>(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hello PDF App"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                BlocBuilder<FileuploadBloc, FileuploadState>(
                  builder: (context, state) {
                    if (state is FileuploadInitial) {
                      return Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              final result =
                                  await FilePicker.platform.pickFiles();
                              if (result == null) return;
                              final file = result.files.first;
                              filePath = file.path!;
                              BlocProvider.of<FileuploadBloc>(context)
                                  .add(FileUpload(filePath));
                            },
                            child: const Text("Click Me"),
                          ),
                        ],
                      );
                    }
                    if (state is FileuploadLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is FileuploadResult) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            Text(state.textResult),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final result =
                                    await FilePicker.platform.pickFiles();
                                if (result == null) return;
                                final file = result.files.first;
                                filePath = file.path!;
                                BlocProvider.of<FileuploadBloc>(context)
                                    .add(FileUpload(filePath));
                              },
                              child: const Text("Click Me"),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
