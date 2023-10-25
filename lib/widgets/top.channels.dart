import 'package:flutter/material.dart';
import 'package:mohoro/bloc/get.sources.bloc.dart';
import 'package:mohoro/elements/error.element.dart';
import 'package:mohoro/elements/loader.element.dart';
import 'package:mohoro/model/source.model.dart';
import 'package:mohoro/model/source.response.dart';
import 'package:mohoro/screens/source.detail.dart';

class TopChannels extends StatefulWidget {
  const TopChannels({super.key});

  @override
  State<TopChannels> createState() => _TopChannelsState();
}

class _TopChannelsState extends State<TopChannels> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc.getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null && snapshot.data!.error.isNotEmpty) {
            return buildErrorWidget(snapshot.data!.error);
          }
          return _buildTopChannels(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.data!.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildTopChannels(SourceResponse? data) {
    List<SourceModel> sources = data!.sources;
    if (sources.isEmpty) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [
            Text("No sources"),
          ],
        ),
      );
    } else {
      return SizedBox(
        height: 115.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: sources.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.only(
                top: 10.0,
              ),
              width: 80.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SourceDetail(source: sources[index])),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: sources[index].id,
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(
                                  1.0,
                                  1.0,
                                ))
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/logos/${sources[index].id}.png"),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      sources[index].name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        height: 1.4,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      sources[index].category,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 9.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
