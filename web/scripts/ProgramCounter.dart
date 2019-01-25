class ProgramCounter
{
  int value;
  ProgramCounter(v)
  {
    value = v & 0xFFFF;
  }

  void set(int i)
  {
    value = i & 0xFFFF;
  }

  int get()
  {
    return value;
  }

  int toInt()
  {
    return value;
  }
}
