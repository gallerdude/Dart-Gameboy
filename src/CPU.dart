import 'registers/Register.dart';
import 'registers/ProgramCounter.dart';
import 'memory/Memory.dart';
import '../other/opcodes.json';

class CPU
{
  Memory memory;
  ProgramCounter pc;
  List<Register> registers;
  int sp;

  int totalCycles;

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
    sp = 0xFFFE;

    a = registers[0];
    b = registers[1];
    c = registers[2];
    d = registers[3];
    e = registers[4];
    f = registers[5];
    h = registers[6];
    l = registers[7];
  }

  void execute(int i)
  {
    String rawHexCode = "0x"+i.toRadixString(16);
    Map instructionMetadata = opcodes['unprefixed'][rawHexCode];
    int code = read(pc.toInt());

    print(instructionMetadata);

    switch (i)
    {
      case 0x0:
        print("nop");
        break;
      case 0x1:
        setRegisterPair(b, c, getd16());
        break;
      case 0x2:
        write(a.get(), read(getRegisterPair(b, c)));
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
      case 0x9:
        setRegisterPair(h, l, getRegisterPair(h,l) + getRegisterPair(b, c));
        break;
      case 0x6:
        b.set(d8());
        break;
      case 0xA:
        a.set(read(getRegisterPair(b, c)));
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
      case 0xE:
        c.set(d8());
        break;
      case 0x11:
        setRegisterPair(d, e, getd16());
        break;
      case 0x12:
        write(a.get(), read(getRegisterPair(d, e)));
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
      case 0x16:
        d.set(d8());
        break;
      case 0x19:
        setRegisterPair(h, l, getRegisterPair(h,l) + getRegisterPair(d, e));
        break;
      case 0x1A:
        a.set(read(getRegisterPair(d, e)));
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
      case 0x1E:
        e.set(d8());
        break;
      case 0x21:
        setRegisterPair(h, l, getd16());
        break;
      case 0x22:
        write(a.get(), read((getRegisterPair(d, e) + 1) & 0xFFFF));
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
      case 0x26:
        h.set(d8());
        break;
      case 0x29:
        setRegisterPair(h, l, getRegisterPair(h,l) + getRegisterPair(h, l));
        break;
      case 0x2A:
        a.set(read(getRegisterPair(h, l)) + 1);
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
      case 0x2E:
        l.set(d8());
        break;
      case 0x31:
        sp = getd16();
        break;
      case 0x32:
        write(a.get(), read((getRegisterPair(d, e) - 1) & 0xFFFF));
        break;
      case 0x33:
        sp--;
        break;
      case 0x34:
        write(getRegisterPair(h, l)+1, getRegisterPair(h, l));
        break;
      case 0x35:
        write(getRegisterPair(h, l)-1, getRegisterPair(h, l));
        break;
      case 0x36:
        write(d8(), getRegisterPair(h, l));
        break;
      case 0x39:
        setRegisterPair(h, l, sp + getRegisterPair(h, l));
        break;
      case 0x3A:
        a.set(read(getRegisterPair(h, l)) - 1);
        break;
      case 0x3B:
        sp++;
        break;
      case 0x3C:
        inc(a);
        break;
      case 0x3D:
        dec(a);
        break;
      case 0x3E:
        a.set(d8());
        break;

      case 0x40:
        setRegister(b, b);
        break;
      case 0x41:
        setRegister(b, c);
        break;
      case 0x42:
        setRegister(b, d);
        break;
      case 0x43:
        setRegister(b, e);
        break;
      case 0x44:
        setRegister(b, h);
        break;
      case 0x45:
        setRegister(b, l);
        break;
      case 0x46:
        b.set(read(getRegisterPair(h, l)));
        break;
      case 0x47:
        setRegister(b, a);
        break;
      case 0x48:
        setRegister(c, b);
        break;
      case 0x49:
        setRegister(c, c);
        break;
      case 0x4A:
        setRegister(c, d);
        break;
      case 0x4B:
        setRegister(c, e);
        break;
      case 0x4C:
        setRegister(c, h);
        break;
      case 0x4D:
        setRegister(c, l);
        break;
      case 0x4E:
        c.set(read(getRegisterPair(h, l)));
        break;
      case 0x4F:
        setRegister(c, a);
        break;
      case 0x50:
        setRegister(d, b);
        break;
      case 0x51:
        setRegister(d, c);
        break;
      case 0x52:
        setRegister(d, d);
        break;
      case 0x53:
        setRegister(d, e);
        break;
      case 0x54:
        setRegister(d, h);
        break;
      case 0x55:
        setRegister(d, l);
        break;
      case 0x56:
        d.set(read(getRegisterPair(h, l)));
        break;
      case 0x57:
        setRegister(d, a);
        break;
      case 0x58:
        setRegister(e, b);
        break;
      case 0x59:
        setRegister(e, c);
        break;
      case 0x5A:
        setRegister(e, d);
        break;
      case 0x5B:
        setRegister(e, e);
        break;
      case 0x5C:
        setRegister(e, h);
        break;
      case 0x5D:
        setRegister(e, l);
        break;
      case 0x5E:
        e.set(read(getRegisterPair(h, l)));
        break;
      case 0x5F:
        setRegister(e, a);
        break;
      case 0x60:
        setRegister(h, b);
        break;
      case 0x61:
        setRegister(h, c);
        break;
      case 0x62:
        setRegister(h, d);
        break;
      case 0x63:
        setRegister(h, e);
        break;
      case 0x64:
        setRegister(h, h);
        break;
      case 0x65:
        setRegister(h, l);
        break;
      case 0x66:
        h.set(read(getRegisterPair(h, l)));
        break;
      case 0x67:
        setRegister(h, a);
        break;
      case 0x68:
        setRegister(l, b);
        break;
      case 0x69:
        setRegister(l, c);
        break;
      case 0x6A:
        setRegister(l, d);
        break;
      case 0x6B:
        setRegister(l, e);
        break;
      case 0x6C:
        setRegister(l, h);
        break;
      case 0x6D:
        setRegister(l, l);
        break;
      case 0x6E:
        l.set(read(getRegisterPair(h, l)));
        break;
      case 0x6F:
        setRegister(l, a);
        break;
      case 0x70:
        write(b.get(), getRegisterPair(h, l));
        break;
      case 0x71:
        write(c.get(), getRegisterPair(h, l));
        break;
      case 0x72:
        write(d.get(), getRegisterPair(h, l));
        break;
      case 0x73:
        write(e.get(), getRegisterPair(h, l));
        break;
      case 0x74:
        write(h.get(), getRegisterPair(h, l));
        break;
      case 0x75:
        write(l.get(), getRegisterPair(h, l));
        break;

      case 0x76:
        print("HALT"); //TODO: HALT UNTIL INTERRUPTS
        break;

      case 0x77:
        write(a.get(), getRegisterPair(h, l));
        break;
      case 0x78:
        setRegister(a, b);
        break;
      case 0x79:
        setRegister(a, c);
        break;
      case 0x7A:
        setRegister(a, d);
        break;
      case 0x7B:
        setRegister(a, e);
        break;
      case 0x7C:
        setRegister(a, h);
        break;
      case 0x7D:
        setRegister(a, l);
        break;
      case 0x7E:
        a.set(read(getRegisterPair(h, l)));
        break;
      case 0x7F:
        setRegister(a, a);
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
        addRegisters(a, new Register.int(read(getRegisterPair(h, l))));
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
        subRegisters(a, new Register.int(read(getRegisterPair(h, l))));
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
        andRegisters(a, new Register.int(read(getRegisterPair(h, l))));
        break;
      case 0xA7:
        andRegisters(a, a);
        break;

      case 0xA8:
        xorRegisters(a, b);
        break;
      case 0xA9:
        xorRegisters(a, c);
        break;
      case 0xAA:
        xorRegisters(a, d);
        break;
      case 0xAB:
        xorRegisters(a, e);
        break;
      case 0xAC:
        xorRegisters(a, h);
        break;
      case 0xAD:
        xorRegisters(a, l);
        break;
      case 0xAE:
        xorRegisters(a, new Register.int(read(getRegisterPair(h, l))));
        break;
      case 0xAF:
        xorRegisters(a, a);
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
        orRegisters(a, new Register.int(read(getRegisterPair(h, l))));
        break;
      case 0xB7:
        orRegisters(a, a);
        break;

      case 0xC1:
        setRegisterPair(b, c, (read(sp+2) << 8) | read(sp+1));
        sp = sp + 2;
        break;
      case 0xC3:
        pc.set(getd16());
        pc.set(pc.get() - instructionMetadata['length']);
      case 0xC5:
        write(b.get(),sp);
        sp--;
        write(c.get(),sp);
        sp--;
        break;
      case 0xD1:
        setRegisterPair(d, e, (read(sp+2) << 8) | read(sp+1));
        sp = sp + 2;
        break;
      case 0xD5:
        write(d.get(),sp);
        sp--;
        write(e.get(),sp);
        sp--;
        break;

      case 0xE1:
        setRegisterPair(h, l, (read(sp+2) << 8) | read(sp+1));
        sp = sp + 2;
        break;

      case 0xE2:
        write(a.get(), 0xFF00 & c.get());
        break;
      case 0xE5:
        write(h.get(),sp);
        sp--;
        write(l.get(),sp);
        sp--;
        break;
      case 0xEA:
        write(a.get(), getd16());
        break;
      case 0xF1:
        setRegisterPair(a, f, (read(sp+2) << 8) | read(sp+1));
        sp = sp + 2;
        break;
      case 0xF2:
        a.set(read(0xFF00 & c.get()));
        break;
      case 0xF5:
        write(a.get(),sp);
        sp--;
        write(f.get(),sp);
        sp--;
        break;
      case 0xFA:
        a.set(read(pc.get()+1));
        break;

        //TODO 0xFF
        //TODO SET FLAGS
        //TODO INCREMENT TIMING
        //TODO INCREMENT PC
    }
    print(" a: 0x"+a.get().toRadixString(16));
    print(" b: 0x"+b.get().toRadixString(16));
    print(" c: 0x"+c.get().toRadixString(16));
    print(" d: 0x"+d.get().toRadixString(16));
    print(" e: 0x"+e.get().toRadixString(16));
    print(" f: 0x"+f.get().toRadixString(16));
    print(" h: 0x"+h.get().toRadixString(16));
    print(" l: 0x"+l.get().toRadixString(16));
    print("af: 0x"+getRegisterPair(a,f).toRadixString(16));
    print("bc: 0x"+getRegisterPair(b,c).toRadixString(16));
    print("de: 0x"+getRegisterPair(d,e).toRadixString(16));
    print("hl: 0x"+getRegisterPair(h,l).toRadixString(16));
    print("sp: 0x"+sp.toRadixString(16));
    print("before pc: 0x"+pc.get().toRadixString(16));

    pc.increment(instructionMetadata['length']);
    print("after  pc: 0x"+pc.get().toRadixString(16));
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
    return (r1.get() << 8) | r2.get();
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

  void xorRegisters(Register r1, Register r2)
  {
    r1.set(r1.get() ^ r2.get());
  }

  int d8()
  {
    return read(pc.get()+1);
  }

  int getd16()
  {
    return (read(pc.get()+2) << 8) | read(pc.get()+1);
  }




  void write(int data, int address)
  {
    memory.write(data, address);
  }

  int read(int address)
  {
    return memory.read(address);
  }


  void inc(Register r)
  {
    r.set(r.get() + 1);
  }

  void incPair(Register r1, Register r2)
  {
    setRegisterPair(r1, r2, getRegisterPair(r1, r2) + 1);
  }

  void dec(Register r)
  {
    r.set(r.get() - 1);
  }

  void decPair(Register r1, Register r2)
  {
    if (r1.get() > 0)
    {
      dec(r1);
    }
    else if (r2.get() > 0)
    {
      dec(r2);
    }
    else
    {
      r1.set(0xFF);
      r2.set(0xFF);
    }
  }



}
