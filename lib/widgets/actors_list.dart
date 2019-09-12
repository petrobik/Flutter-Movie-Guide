import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_movie_guide/models/credits.dart';
import 'package:flutter_movie_guide/global.dart' as global;

import '../person_details.dart';

class ActorsList extends StatelessWidget {
  final Credits credits;

  ActorsList(this.credits);

  List<Cast> _getCastList() {
    if (credits.cast.length < 5)
      return credits.cast;
    else
      return credits.cast.sublist(0, 5);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (Cast cast in _getCastList())
            Padding(
                padding: EdgeInsets.only(right: 4.0, left: 4.0),
                child: Container(
                  width: 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PersonDetails(
                                        id: cast.id,
                                      )));
                        },
                        child: Hero(
                          tag: cast.id,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            child: cast.profilePath == null
                                ? Image(
                                    image:
                                        AssetImage('assets/images/actor.png'),
                                    fit: BoxFit.cover,
                                    height: 140,
                                    colorBlendMode: BlendMode.overlay,
                                  )
                                : FadeInImage.memoryNetwork(
                                    placeholder: kTransparentImage,
                                    image:
                                        '${global.imagesUrl}w185${cast.profilePath}',
                                    fit: BoxFit.cover,
//                                                          width: 80.0,
                                    height: 140.0,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 4.0, right: 6.0),
                          child: Text(
                            cast.name,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ))
                    ],
                  ),
                ))
        ],
      ),
    );
  }
}
