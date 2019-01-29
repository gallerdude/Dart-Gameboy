import 'registers/Register.dart';
import 'registers/ProgramCounter.dart';
import 'memory/Memory.dart';
import '../other/opcodes.json';

class CPU
{
  Memory memory;
  ProgramCounter pc;
  List<Register> registers;

  const int totalCycles

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
    totalCycles = 69905;

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

    switch (instruction)
    {
      case 0x0:
        print("nop")
        break;
      case 0x3:
        incPair(b, c);
        break;
      case 0x4:
        inc(b);
        break;
      case 0x5:
        dec(b);
        break;
      case 0xB:
        decPair(b, c);
        break;
      case 0xC:
        inc(c);
        break;
      case 0xD:
        dec(c);
        break;
      case 0x13:
        incPair(d, e);
        break;
      case 0x14:
        inc(d);
        break;
      case 0x15:
        dec(d);
        break;
      case 0x1B:
        decPair(d, e);
        break;
      case 0x1C:
        inc(e);
        break;
      case 0x1D:
        dec(e);
        break;
      case 0x23:
        incPair(h, l);
        break;
      case 0x24:
        inc(h);
        break;
      case 0x25:
        dec(h);
        break;
      case 0x2B:
        decPair(h, l);
        break;
      case 0x2C:
        inc(l);
        break;
      case 0x2D:
        dec(h);
        break;
      case 0x33:
        pc.increment(1);
        break;
      case 0x34:
        write(getRegisterPair(h, l)+1, read(getRegisterPair(h, l)));
        break;
      case 0x35:
        write(getRegisterPair(h, l)-1, read(getRegisterPair(h, l)));
        break;
      case 0x3B:
        pc.decrement(1);
        break;
      case 0x3C:
        inc(a);
        break;
      case 0x3D:
        dec(a);
        break;
      case 0x40:
        setRegister(b, b);
        break;
      case 0x80:
        addRegisters(a, b);
        break;
      case 0x81:
        addRegisters(a, c);
        break;
      case 0x82:
        addRegisters(a, d);
        break;
      case 0x83:
        addRegisters(a, e);
        break;
      case 0x84:
        addRegisters(a, h);
        break;
      case 0x85:
        addRegisters(a, l);
        break;
      case 0x86:
        addRegisters(a, read(getRegisterPair(h, l)));
        break;
      case 0x87:
        addRegisters(a, a);
        break;
      case 0x90:
        subRegisters(a, b);
        break;
      case 0x91:
        subRegisters(a, c);
        break;
      case 0x92:
        subRegisters(a, d);
        break;
      case 0x93:
        subRegisters(a, e);
        break;
      case 0x94:
        subRegisters(a, h);
        break;
      case 0x95:
        subRegisters(a, l);
        break;
      case 0x96:
        subRegisters(a, read(getRegisterPair(h, l)));
        break;
      case 0x97:
        subRegisters(a, a);
        break;
      case 0xA0:
        andRegisters(a, b);
        break;
      case 0xA1:
        andRegisters(a, c);
        break;
      case 0xA2:
        andRegisters(a, d);
        break;
      case 0xA3:
        andRegisters(a, e);
        break;
      case 0xA4:
        andRegisters(a, h);
        break;
      case 0xA5:
        andRegisters(a, l);
        break;
      case 0xA6:
        andRegisters(a, read(getRegisterPair(h, l)));
        break;
      case 0xA7:
        andRegisters(a, a);
        break;
      case 0xB0:
        orRegisters(a, b);
        break;
      case 0xB1:
        orRegisters(a, c);
        break;
      case 0xB2:
        orRegisters(a, d);
        break;
      case 0xB3:
        orRegisters(a, e);
        break;
      case 0xB4:
        orRegisters(a, h);
        break;
      case 0xB5:
        orRegisters(a, l);
        break;
      case 0xB6:
        orRegisters(a, read(getRegisterPair(h, l)));
        break;
      case 0xB7:
        orRegisters(a, a);
        break;






    }

    pc.increment(instructionMetadata['length']);
  }

  void setRegister(Register registerI, Register registerO)
  {
    registerI.set(registerO.get());
  }

  void setRegisterPair(Register r1, Register r2, int value)
  {
    r1.set((value >> 8) & 0xFF);
    r2.set(value & 0xFF);
  }

  int getRegisterPair(Register r1, Register r2)
  {
    return (r1.get() << 8) | r2.get()
  }

  void addRegisters(Register r1, Register r2)
  {
    r1.set(r1.get() + r2.get());
  }

  void subRegisters(Register r1, Register r2)
  {
    r1.set(r1.get() - r2.get());
  }

  void andRegisters(Register r1, Register r2)
  {
    r1.set(r1.get() & r2.get());
  }

  void orRegisters(Register r1, Register r2)
  {
    r1.set(r1.get() | r2.get());
  }




  void write(int data, int address)
  {
    memory.write(data, address);
  }

  void read(int address)
  {
    memory.read(address);
  }

  void inc(Register r)
  {
    r.set(r.get() + 1);
  }

  void incPair(Register r1, Register r2)
  {
    getRegisterPair(r1, r2, getRegisterPair(r1, r2) + 1);
  }

  void dec(Register r)
  {
    r.set(r.get() - 1);
  }

  void decPair(Register r1, Register r2)
  {
    if (r1 > 0)
    {
      r1.dec();
    }
    else if (r2 > 0)
    {
      r2.dec();
    }
    else
    {
      r1.set(0xFF);
      r2.set(0xFF);
    }
  }



}
