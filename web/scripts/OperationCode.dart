class OperationCode
{
  String operation;
  List<int> bytes;

  String register1;
  String register2;

  int affectZFlag;
  int affectSFlag;
  int affectHFlag;
  int affectCFlag;

  OperationCode(op, r1, r2, zFlag, sFlag, hFlag, cFlag)
  {
    this.operation = op;

    this.register1 = r1;
    this.register2 = r2;

    this.affectZFlag = zFlag;
    this.affectSFlag = sFlag;
    this.affectHFlag = hFlag;
    this.affectCFlag = cFlag;
  }

  String getOperation()
  {
    return operation;
  }

}
