import 'OperationCode.dart';

class OperationCodes
{
  List<OperationCode> opcodes;
  List<OperationCode> cbcodes;

  OperationCodes()
  {
    opcodes = new List(0xFF);
    cbcodes = new List(0xFF);

    opcodes[0x00] = new OperationCode("NOP", null, null, 3, 3, 3, 3);
    opcodes[0x01] = new OperationCode("LD", "(BC)", "d16", 3, 3, 3, 3);
    opcodes[0x02] = new OperationCode("LD", "BC", "A", 3, 3, 3, 3);
    opcodes[0x03] = new OperationCode("INC", "BC", null, 3, 3, 3, 3);
    opcodes[0x04] = new OperationCode("INC", "B", null, 2, 0, 2, 3);
    opcodes[0x05] = new OperationCode("DEC", "B", null, 2, 1, 2, 3);
    opcodes[0x06] = new OperationCode("LD", "B", "d8", 3, 3, 3, 3);
    opcodes[0x07] = new OperationCode("RLCA", null, null, 0, 0, 0, 2);
    opcodes[0x08] = new OperationCode("LD", "(a16)", "SP", 3, 3, 3, 3);
    opcodes[0x09] = new OperationCode("LD", "HL", "BC", 0, 2, 2, 2);
    opcodes[0x0A] = new OperationCode("LD", "A", "(BC)", 3, 3, 3, 3);
    opcodes[0x0B] = new OperationCode("DEC", "BC", null, 3, 3, 3, 3);
    opcodes[0x0C] = new OperationCode("INC", "C", null, 2, 0, 2, 3);
    opcodes[0x0D] = new OperationCode("DEC", "C", null, 2, 1, 2, 3);
    opcodes[0x0E] = new OperationCode("LD", "C", "d8", 3, 3, 3, 3);
    opcodes[0x0F] = new OperationCode("RRCA", null, null, 0, 0, 0, 2);
    opcodes[0x10] = new OperationCode("STOP", null, null, 3, 3, 3, 3);
    opcodes[0x11] = new OperationCode("LD", "DE", "d16", 3, 3, 3, 3);
    opcodes[0x12] = new OperationCode("LD", "(DE)", "A", 3, 3, 3, 3);
    opcodes[0x13] = new OperationCode("INC", "DE", null, 3, 3, 3, 3);
    opcodes[0x14] = new OperationCode("INC", "D", null, 2, 0, 2, 3);
    opcodes[0x15] = new OperationCode("DEC", "D", null, 2, 1, 2, 3);
    opcodes[0x15] = new OperationCode("DEC", "D", null, 2, 1, 2, 3);
    opcodes[0x16] = new OperationCode("LD", "D", "d8", 3, 3, 3, 3);
    opcodes[0x17] = new OperationCode("RLA", null, null, 0, 0, 0, 2);
    opcodes[0x18] = new OperationCode("JR", "r8", null, 3, 3, 3, 3);
    opcodes[0x19] = new OperationCode("ADD", "HL", "DE", 3, 0, 2, 2);
    opcodes[0x1A] = new OperationCode("LD", "A", "(DE)", 3, 3, 3, 3);
    opcodes[0x1B] = new OperationCode("DEC", "DE", null, 3, 3, 3, 3);
    opcodes[0x1C] = new OperationCode("INC", "E", null, 2, 0, 2, 3);
    opcodes[0x1D] = new OperationCode("DEC", "E", null, 2, 1, 2, 3);
    opcodes[0x1E] = new OperationCode("LD", "E", "d8", 3, 3, 3, 3);
    opcodes[0x1F] = new OperationCode("RRA", null, null, 0, 0, 0, 2);
  }
}
