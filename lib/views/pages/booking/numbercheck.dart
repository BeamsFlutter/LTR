
import 'package:flutter/material.dart';
import 'package:ltr/controller/global/globalValues.dart';
import 'package:ltr/views/components/common/common.dart';
import 'package:path/path.dart';

class NumberCheck extends StatefulWidget {
  const NumberCheck({Key? key}) : super(key: key);

  @override
  State<NumberCheck> createState() => _NumberCheckState();
}

class _NumberCheckState extends State<NumberCheck> {

  Global g = Global();
  
  var txtNumberEditor =  TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: txtNumberEditor,
            maxLines: 5,
          ),
          gapHC(10),
          GestureDetector(
            onTap: (){
              fnGenerateNumber();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: boxDecoration(Colors.green, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tc('SUBMIT', Colors.white, 20)
                ],
              ),
            ),
          )
          
        ],
      ),
    );
  }


  fnGenerateNumber(){

    //1.number,2.a count,3.b count,3.b count,4.a type,5.b type,6.c type // format

    //if(number length == 3)
    //need to consider a count and b count
    //length ==3 and a count/ b count is not empty super,box
    //length ==3 and b.count is empty and type is empty it means super
    //length ==3 and a count/ b is empty type = 'B' 'BOX' /'S' 'SUPER'

    //length == 2 or length == 1 and count based on type
    // a count = a type
    // b count = b type
    // c count = c type


    var wpNumberList  = [];
    var text = txtNumberEditor.text.toString();

    List<String> textLines = text.split("\n");

    dprint("TEXT LINE>>>>>>>>>>>>>>>>>>>>>>>");
    dprint(textLines);
    for(var txt in textLines){
      List<String> delimiters = [',','.', '*', '#', '+', '-','=','_'];
      List<String> result = splitTextWithDelimiters(txt, delimiters);
      dprint(result);
      var num  = "";
      var aCount  = "";
      var bCount  = "";
      var cCount  = "";
      var aType  = "";
      var bType  = "";
      var cType  = "";

      num =  fnGetNum(result,0);
      aCount =  fnGetNum(result,1);
      bCount =  fnGetNum(result,2);

      dprint(num);
      if(num.length == 3){
        if(g.mfnDbl(bCount) == 0){
          aType =  fnGetNum(result,2);
        }

        //length ==3 and a count/ b count is not empty super,box
        //length ==3 and b.count is empty and type is empty it means super
        //length ==3 and a count/ b is empty type = 'B' 'BOX' /'S' 'SUPER'

        if(g.mfnDbl(bCount)>0){
          wpNumberList.add({
            "TYPE":"SUPER",
            "NUMBER":num,
            "COUNT":aCount,
          });
          wpNumberList.add({
            "TYPE":"BOX",
            "NUMBER":num,
            "COUNT":bCount,
          });
        }else{
          dprint("A TYPE >>>>>>>>>>>>>  $aType");
          if(aType.isEmpty){
            wpNumberList.add({
              "TYPE":"SUPER",
              "NUMBER":num,
              "COUNT":aCount,
            });
          }else{
            if(aType == "B" ||  aType == "BOX"){
              wpNumberList.add({
                "TYPE":"BOX",
                "NUMBER":num,
                "COUNT":aCount,
              });
            }else if(aType == "S" ||  aType == "SUPER" || aType == "SUP" || aType == "SPR" || aType == "SP"){
              wpNumberList.add({
                "TYPE":"SUPER",
                "NUMBER":num,
                "COUNT":aCount,
              });
            }
          }
        }

      }
      else {
        if(g.mfnDbl(bCount) == 0){
          aType =  fnGetNum(result,2);
          if(aType.isNotEmpty){
            bType =  fnGetNum(result,3);
            if(bType.isNotEmpty){
              cType =  fnGetNum(result,4);
            }
          }
        }
        else{
          cCount =  fnGetNum(result,3);
          if(g.mfnDbl(cCount) == 0){
            aType =  fnGetNum(result,3);
            if(aType.isNotEmpty){
              bType =  fnGetNum(result,4);
              if(bType.isNotEmpty){
                cType =  fnGetNum(result,5);
              }
            }
          }else{
            aType =  fnGetNum(result,4);
            if(aType.isNotEmpty){
              bType =  fnGetNum(result,5);
              if(bType.isNotEmpty){
                cType =  fnGetNum(result,6);
              }
            }
          }
        }

        dprint("A COUNT >>>>>> $aCount");
        dprint("B COUNT >>>>>> $bCount");
        dprint("C COUNT >>>>>> $cCount");

       if(num.length ==2){
         if(aType != "AB" && aType != "BC" && aType != "AC"){
           aType = "";
         }
         if(bType != "AB" && bType != "BC" && bType != "AC"){
           bType = "";
         }
         if(cType != "AB" && cType != "BC" && cType != "AC"){
           cType = "";
         }
       }else if(num.length ==1){
         if(aType != "A" && aType != "B" && aType != "B"){
           aType = "";
         }
         if(bType != "A" && bType != "B" && bType != "C"){
           bType = "";
         }
         if(cType != "A" && cType != "B" && cType != "C"){
           cType = "";
         }
       }

        dprint("A TYPE >>>>>> $aType");
        dprint("B TYPE >>>>>> $bType");
        dprint("C TYPE >>>>>> $cType");




        if(g.mfnDbl(cCount) >0 ){
          if(cType.isNotEmpty){
            wpNumberList.add({
              "TYPE":aType,
              "NUMBER":num,
              "COUNT":aCount,
            });
            wpNumberList.add({
              "TYPE":bType,
              "NUMBER":num,
              "COUNT":bCount,
            });
            wpNumberList.add({
              "TYPE":cType,
              "NUMBER":num,
              "COUNT":cCount,
            });
          }else{
            if(aType.isNotEmpty){
              wpNumberList.add({
                "TYPE":aType,
                "NUMBER":num,
                "COUNT":aCount,
              });
              wpNumberList.add({
                "TYPE":aType,
                "NUMBER":num,
                "COUNT":bCount,
              });
              wpNumberList.add({
                "TYPE":aType,
                "NUMBER":num,
                "COUNT":cCount,
              });
            }
          }
        }
        else if(g.mfnDbl(bCount) >0){
          if(bType.isNotEmpty){
            wpNumberList.add({
              "TYPE":aType,
              "NUMBER":num,
              "COUNT":aCount,
            });
            wpNumberList.add({
              "TYPE":bType,
              "NUMBER":num,
              "COUNT":bCount,
            });
          }else{
            if(aType.isNotEmpty){
              wpNumberList.add({
                "TYPE":aType,
                "NUMBER":num,
                "COUNT":aCount,
              });
              wpNumberList.add({
                "TYPE":aType,
                "NUMBER":num,
                "COUNT":bCount,
              });
            }
          }
        }
        else if(g.mfnDbl(aCount) >0){
          if(cType.isNotEmpty){
            wpNumberList.add({
              "TYPE":aType,
              "NUMBER":num,
              "COUNT":aCount,
            });
            wpNumberList.add({
              "TYPE":bType,
              "NUMBER":num,
              "COUNT":aCount,
            });
            wpNumberList.add({
              "TYPE":cType,
              "NUMBER":num,
              "COUNT":aCount,
            });
          }else if(bType.isNotEmpty){
            wpNumberList.add({
              "TYPE":aType,
              "NUMBER":num,
              "COUNT":aCount,
            });
            wpNumberList.add({
              "TYPE":bType,
              "NUMBER":num,
              "COUNT":aCount,
            });
          }
          else if(aType.isNotEmpty){
            wpNumberList.add({
              "TYPE":aType,
              "NUMBER":num,
              "COUNT":aCount,
            });
          }
        }
      }


    }

    wpNumberList.removeWhere((element) => element["TYPE"] =="");
    dprint(wpNumberList);

  }
  List<String> splitTextWithDelimiters(String text, List<String> delimiters) {
    String pattern = delimiters.map((delimiter) => '\\$delimiter').join('|');
    RegExp regExp = RegExp(pattern);
    return text.split(regExp);
  }


  fnGetNum(list,index){
    var result = "";
    try{
      result  = list[index].toString().toUpperCase().replaceAll(" ", "");
    }catch(e){
      dprint(e);
    }
    return result;
  }



}
