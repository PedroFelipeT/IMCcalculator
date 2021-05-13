import 'package:flutter/material.dart';

dynamic _valorImc = 0.0;

class ImcCalculator extends StatefulWidget {
  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  int _selectedIndex = 0;

  dynamic _statusPage = PageHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC Calculator"),
        centerTitle: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10),
        child: _statusPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: "Calcular IMC",
          ),
        ],
        onTap: (index) {
          print("Valor index: $index");
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              _statusPage = PageHome();
            } else {
              _statusPage = PageCalculoImc();
            }
          });
        },
        selectedItemColor: Colors.blue,
        currentIndex: _selectedIndex,
      ),
    );
  }
}

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Cálculo IMC",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
              "IMC é a sigla para Índice de Massa Corpórea, parâmetro adotado pela Organização Mundial de Saúde para calcular o peso ideal de cada pessoa.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify),
          SizedBox(height: 10),
          Text(
            "O índice é calculado da seguinte maneira: divide-se o peso do paciente pela sua altura elevada ao quadrado. Diz-se que o indivíduo tem peso normal quando o resultado do IMC está entre 18,5 e 24,9.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Text(
            "Quer descobrir seu IMC? Insira seu peso e sua altura nos campos abaixo e compare com os índices da tabela. Importante: siga os exemplos e use pontos como separadores.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20),
          Text(
            "O que fazer para melhorar o IMC?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Para melhorar o IMC é importante verificar se está acima ou abaixo do que é considerado normal. Quando o IMC está na faixa de magreza, é importante consultar o nutricionista para que, além de ser feita uma avaliação completa, seja indicado um plano alimentar que foque no aumento de peso de forma saudável.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
          Text(
            "Por outro lado, quando o IMC está na faixa do sobrepeso ou da obesidade, pode ser indicado pelo nutricionista a realização de uma alimentação com mais restrição calórica, além de ser também indicada a prática de atividade física regular, pois assim é possível acelerar o metabolismo e favorecer a perda de peso, o que influencia diretamente no IMC.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class PageCalculoImc extends StatefulWidget {
  @override
  _PageCalculoImcState createState() => _PageCalculoImcState();
}

class _PageCalculoImcState extends State<PageCalculoImc> {
  TextEditingController _alturaController = TextEditingController();
  TextEditingController _pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _alturaController,
                  maxLength: 4,
                  decoration: InputDecoration(
                    labelText: "Altura(m)",
                    labelStyle: TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: Color(0xE6E0F8F2),
                    hintText: "Digite sua Altura : exemplo 1.76",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 3, color: Colors.green),
                    ),
                  ),
                ),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: _pesoController,
                  maxLength: 5,
                  decoration: InputDecoration(
                    labelText: "Peso(Kg)",
                    labelStyle: TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: Color(0xE6E0F8F2),
                    hintText: "Digite o seu peso : exemplo 55.00",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 3, color: Colors.indigo),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 3, color: Colors.green),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text("Calcular"),
                      onPressed: () {
                        print("Altura: ${_alturaController.text}");
                        print("Peso: ${_pesoController.text}");
                        setState(() {
                          _valorImc = calculoIMC(
                              _alturaController.text, _pesoController.text);
                          _valorImc = maskDecimal(_valorImc);
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      child: Text("Limpar"),
                      onPressed: () {
                        setState(() {
                          _alturaController.text = "";
                          _pesoController.text = "";
                          _valorImc = 0.0;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "Seu IMC: $_valorImc",
                    style: DefaultTextStyle.of(context)
                        .style
                        .apply(fontSizeFactor: 2.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                DataTable(
                  columnSpacing: 15,
                  columns: [
                    DataColumn(label: Text("IMC")),
                    DataColumn(label: Text("CLASSIFICAÇÂO")),
                    DataColumn(label: Text("OBESIDADE(grau)")),
                  ],
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(
                          Text("MENOR QUE 18,5"),
                        ),
                        DataCell(
                          Text("MAGREZA"),
                        ),
                        DataCell(
                          Text("0"),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text("ENTRE 18,5 E 24,9"),
                        ),
                        DataCell(
                          Text("NORMAL"),
                        ),
                        DataCell(
                          Text("0"),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text(
                            "ENTRE 25,0 E 29,9",
                          ),
                        ),
                        DataCell(
                          Text("SOBREPESO"),
                        ),
                        DataCell(
                          Text("I"),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text("ENTRE 30,0 E 39,9"),
                        ),
                        DataCell(
                          Text("OBESIDADE"),
                        ),
                        DataCell(
                          Text("II"),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(
                          Text("MAIOR QUE 40,0"),
                        ),
                        DataCell(
                          Text("OBESIDADE GRAVE"),
                        ),
                        DataCell(
                          Text("III"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  calculoIMC(var altura, var peso) {
    double calculaImc =
        double.parse(peso) / (double.parse(altura) * double.parse(altura));

    return calculaImc;
  }

  maskDecimal(var valor) {
    var convertidto = double.parse(valor.toStringAsFixed(2));
    return convertidto;
  }
}
