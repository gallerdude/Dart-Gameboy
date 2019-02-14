import 'dart:typed_data';
import 'memory/Memory.dart';

class LCD
{

  List<Uint8List> display;
  Memory memory;

  int lcdc;

  bool displayOn; //LCDC.7
  bool windowOn; //LCDC.5
  int spritesOn; //LCD.1

  int windowTileMap; ////LCDC.6
  int backgroundTileMap; //LCDC.3

  //LCDC.2 is OBJ size, not messing with that yet
  String addressingMode; //LCDC.4

  LCD(Memory mem)
  {
    display = new List<Uint8List>(144);
    memory = mem;
    lcdc = memory.read(0xFF40);

    toggleDisplay();
    setWindowTileLocation();
    toggleWindow();
    setAddressingMode();
    setBackgroundTileLocation();
  }


  void updateLCDC()
  {
    lcdc = memory.read(0xFF40);
    toggleDisplay();
  }

  void toggleDisplay() //7
  {
    if ((lcdc & 0x80) == 0x80)
    {
      displayOn = true;
    }
    else
    {
      displayOn = false;
    }
  }

  void setWindowTileLocation() //6
  {
    if ((lcdc & 0x40) == 0x40)
    {
      windowTileMap = 0x9C00;
    }
    else
    {
      windowTileMap = 0x9800;
    }
  }

  void toggleWindow() //5
  {
    if ((lcdc & 0x20) == 0x20)
    {
      windowOn = true;
    }
    else
    {
      windowOn = false;
    }
  }

  void setAddressingMode() //4
  {
    if ((lcdc & 0x10) == 0x10)
    {
      addressingMode = "signed";
    }
    else
    {
      addressingMode = "unsigned";
    }
  }

  void setBackgroundTileLocation() //3
  {
    if ((lcdc & 0x8) == 0x8)
    {
      backgroundTileMap = 0x9800;
    }
    else
    {
      backgroundTileMap = 0x9C00;
    }
  }





}
