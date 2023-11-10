import 'package:flutter/material.dart';
import 'package:mohoro/bloc/get.sources.bloc.dart';
import 'package:mohoro/common.libs.dart';
import 'package:mohoro/elements/error.element.dart';
import 'package:mohoro/elements/loader.element.dart';
import 'package:mohoro/model/source.model.dart';
import 'package:mohoro/model/source.response.dart';
import 'package:mohoro/screens/source.detail.dart';

class SourceScreen extends StatefulWidget {
  const SourceScreen({super.key});

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        child: StreamBuilder<SourceResponse>(
          stream: getSourcesBloc.subject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.error.isNotEmpty) {
                return buildErrorWidget(snapshot.data!.error);
              }
              return _buildSources(snapshot.data);
            } else if (snapshot.hasError) {
              return buildErrorWidget(snapshot.data!.error);
            } else {
              return buildLoadingWidget();
            }
          },
        ),
      ),
    );
  }

  Widget _buildSources(SourceResponse? data) {
    List<SourceModel> sources = data!.sources;
    return GridView.builder(
      itemCount: sources.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.86,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
            top: 10.0,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SourceDetail(source: sources[index]),
                ),
              );
            },
            child: Container(
              width: 100.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade100,
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                      offset: const Offset(1.0, 1.0),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: sources[index].id,
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              "assets/logos/${sources[index].id}.png"),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 15.0,
                      bottom: 15.0,
                    ),
                    child: Text(
                      sources[index].name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
