import 'Registers.dart';

class OperationCode
{
  List<int> bytes;

  bool affectZFlag;
  bool affectSFlag;
  bool affectHFlag;
  bool affectCFlag;

  OperationCode(this.bytes, this.affectZFlag, this.affectSFlag, this.affectHFlag, this.affectCFlag);

}
