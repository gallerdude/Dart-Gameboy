import 'Register.dart';

class FlagRegister extends Register
{
  int value;
  FlagRegister()
  {
    value = 0;
  }

  void setZ(bool b)
  {
    if (b)
    {
      value = value | 0x80;
    }
    else
    {
      value = value & 0x7F;
    }
  }

  void setN(bool b)
  {
    if (b)
    {
      value = value | 0x40;
    }
    else
    {
      value = value & 0xBF;
    }
  }

  void setH(bool b)
  {
    if (b)
    {
      value = value | 0x20;
    }
    else
    {
      value = value & 0xDF;
    }
  }

  void setC(bool b)
  {
    if (b)
    {
      value = value | 0x10;
    }
    else
    {
      value = value & 0xEF;
    }
  }

  bool getZ()
  {
    return (value & 0x80 != 0);
  }

  bool getN()
  {
    return (value & 0x40 != 0);
  }

  bool getH()
  {
    return (value & 0x20 != 0);
  }

  bool getC()
  {
    return (value & 0x10 != 0);
  }
}
