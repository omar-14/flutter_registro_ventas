import 'package:flutter/material.dart';
import 'package:intventory/features/shared/shared.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    const titileHeadStyle =
        TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    const titileStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
    const textStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 15);
    // const textStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 13);

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Recomendaciones"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Generar Lista"),
        icon: const Icon(Icons.refresh),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            Card(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "Recomendaciones de compra",
                          style: titileHeadStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Fecha: 30/10/2023",
                          style: titileStyle,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Costo aproximaod del totoal de la sugerencia: ",
                          style: titileStyle,
                        ),
                        Text(
                          "\$2100 pesos",
                          style: titileStyle,
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Column(children: [
                  Row(
                    children: [
                      Text(
                        "Producto: Abaco",
                        style: textStyle,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Marca: Marca1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Tipo: tipo1",
                        style: textStyle,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Existencias: 10",
                        style: textStyle,
                      )
                    ],
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Column(
                      children: [
                        Text(
                          "Sugerencias de compra: 20 items",
                          style: titileStyle,
                        ),
                        Text(
                          "Costo aproxmado: \$350 pesos",
                          style: titileStyle,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
