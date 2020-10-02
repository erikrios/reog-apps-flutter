import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 124.0,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100.0,
                width: 100.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    'https://avatars3.githubusercontent.com/u/42199285?s=460',
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Jumlah Programmer di Ponorogo Meningkat Lebih Dari 50% dari Tahun ke Tahun Jumlah Programmer di Ponorogo Meningkat Lebih Dari 50% dari Tahun ke Tahun',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Dilansir dari Kompas.com, jumlah pemrogram kompas dari Kompas.com, jumlah pemrogram kompas dari Kompas.com, jumlah pemrogram kompas',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Fri, 2 Oct 20, 09.55 PM',
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black26,
            height: 24.0,
          )
        ],
      ),
    );
  }
}
