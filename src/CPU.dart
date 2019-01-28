import 'registers/Register.dart';
import 'registers/ProgramCounter.dart';
import 'memory/Memory.dart';
import '../other/opcodes.json';

class CPU
{
  Memory memory;
  ProgramCounter pc;
  List<Register> registers;

  Register a;
	Register b;
	Register c;
	Register d;
	Register e;
	Register f;
	Register h;
	Register l;


  CPU(mem, program_counter, regs)
  {
    memory = mem;
    pc = program_counter;
    registers = regs;

    a = registers[0];
    b = registers[1];
    c = registers[2];
    d = registers[3];
    e = registers[4];
    f = registers[5];
    h = registers[6];
    l = registers[7];
  }

  void execute()
  {
    String rawHexCode = "0x"+memory.read(pc.toInt()).toRadixString(16);
    Map instructionMetadata = opcodes['unprefixed'][rawHexCode];

    print(instructionMetadata);

    switch(instruction)
    {
      case 0x40:
        setRegister("B", "B");
    }

    pc.increment(instructionMetadata['length']);
  }

  Register getRegister(String s)
  {

  }

  void setRegister(Register registerI, Register registerO)
  {

  }

  void setRegisterPair(List<String> registers, int value)
  {

  }



}
