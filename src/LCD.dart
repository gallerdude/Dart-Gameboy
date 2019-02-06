import 'dart:typed_data';

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
    lcdc = memory[0xFF40];

    toggleDisplay();
  }


  void updateLCDC()
  {
    lcdc = memory[0xFF40];
  }

  void toggleDisplay()
  {
    if ((lcdc & 0x80) == 1)
    {
      displayOn = true;
    }
    else
    {
      displayOn = false;
    }
  }

  void toggleWindow()
  {
    if ((lcdc & 0x20) == 1)
    {

    }

  }

}
