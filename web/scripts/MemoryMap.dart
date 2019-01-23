import 'dart:typed_data';

class MemoryMap
{
  Uint8List memory;

  List<Uint8List> romBanks;
  List<Uint8List> ramBanks;

  String gameName;
  String mapper;

  int romBankNumber;
  int ramBankNumber;

  int romSize;
  int ramSize;

  bool mode;

  MemoryMap(Uint8List cart)
  {
    Uint8List thisROMBank = new Uint8List(0x4000);

    romBankNumber = 1;
    ramBankNumber = 0;
    int j = 0;

    mode = false;

    this.gameName = getGameName(cart.sublist(0x134, 0x144));
    this.mapper  = getMapperType(cart[0x147]);
    this.romSize = getROMSize(cart[0x148]);
    this.ramSize = getRAMSize(cart[0x149]);

    romBanks = new List(this.romSize);
    ramBanks = new List(this.ramSize);
    memory   = new Uint8List(0x4FFFFF);

    for (int i = 0; i < cart.length; i++)
    {
      thisROMBank[i%0x4000] = cart[i];
      this.memory[i] = cart[i];
      if (i > 0 && i % 0x3FFF == 0)
      {
        romBanks[j] = thisROMBank;

        j++;
        if (mapper == "MBC1" && (j == 0x20 || j == 0x40 || j == 0x60))
        {
          j++;
        }

        thisROMBank = new Uint8List(0x4000);
      }
    }

    if (!ramBanks.isEmpty)
    {
      for (int i = 0; i < this.ramSize; i++)
      {
        this.ramBanks[i] = new Uint8List(0x1FFF);
      }
    }


  }

  int read(int address)
  {
    if (mapper == "MBC1")
    {
      if (address <= 0x3FFF)
      {
        print("read " + romBanks[0][address].toString() + " from ROM bank #0 at address " + address.toString());
        return romBanks[0][address];
      }
      else if (address <= 0x7FFF)
      {
        print("read " + romBanks[romBankNumber][address-0x4000].toString() + " from ROM bank #" + romBankNumber.toString() + " at address " + (address - 0x4000).toString());
        return romBanks[romBankNumber][address-0x4000];
      }
      else if (address >= 0xA000 && address <= 0xBFFF)
      {
        print("read " + ramBanks[ramBankNumber][address - 0xA000].toString() + " from RAM bank #" + ramBankNumber.toString() + " at address " + (address - 0xA000).toString());
        return ramBanks[ramBankNumber][address - 0xA000];
      }
    }
  }

  void write(int data, int address)
  {
    if (mapper == "MBC1")
    {
      if (address >= 0x2000 && address <= 0x3FFF) //SET ROM BANK NUMBER
      {
        romBankNumber = data & 0x1F;

        if (romBankNumber == 0x00 || romBankNumber == 0x20 || romBankNumber == 0x40 || romBankNumber == 0x60)
        {
          romBankNumber++;
        }

        print("Set ROM bank # to " + romBankNumber.toString());
      }
      else if (address >= 0x4000 && address <= 0x5FFF)
      {
        if (mode)
        {
          ramBankNumber = data & 0x3;
          print("Set RAM bank to " + romBankNumber.toString());
        }
        else
        {
          romBankNumber = romBankNumber | (0x60 & (data << 5));
          print("Set ROM bank to " + romBankNumber.toString());
        }
      }
      else if (address >= 0x6000 && address <= 0x7FFF) //SET HIGH ROM OR RAM BANKS
      {
        if ((data & 0x1) == 1)
        {
          mode = true;
          print("Set mode to extended RAM");
        }
        if ((data & 0x1) == 0)
        {
          mode = false;
          print("Set mode to extended ROM");
        }
      }
      else if (address >= 0xA000 && address <= 0xBFFF) //WRITE TO RAM
      {
        ramBanks[ramBankNumber][address - 0xA000] = data;
        print("Wrote " + data.toString() + " to RAM bank #" + ramBankNumber.toString() + " at address " + (address - 0xA000).toString());
      }
    }
  }

  String getGameName(Uint8List titlecodes)
  {
  	String gameTitle = "";

  	for (int i = 0; i < titlecodes.length; i++)
  	{
  		gameTitle += String.fromCharCode(titlecodes[i]);
  	}

  	return gameTitle;
  }

  String getMapperType(int mem)
  {
    String result;
    switch (mem)
    {
      case 0x00:
        result = "ROM";
        break;
      case 0x01:
        result = "MBC1";
        break;
      case 0x02:
        result = "MBC1";
        break;
      case 0x03:
        result = "MBC1";
        break;
      case 0x05:
        result = "MBC2";
        break;
      case 0x06:
        result = "MBC2";
        break;
      case 0x07:
        result = "ROM";
        break;
      case 0x10:
        result = "MBC3";
        break;
      case 0x011:
        result = "MBC3";
        break;
      case 0x012:
        result = "MBC3";
        break;
      case 0x013:
        result = "MBC3";
        break;
      case 0x019:
        result = "MBC5";
        break;
      case 0x01A:
        result = "MBC5+RAM";
        break;
      case 0x01B:
        result = "MBC5+RAM+Battery";
        break;
      case 0x020:
        result = "MBC6";
        break;

    }

    return result;
  }

  int getROMSize(int mem)
  {
    int result;
    switch (mem)
    {
      case 0x00:
        result = 2;
        break;
      case 0x01:
        result = 4;
        break;
      case 0x02:
        result = 8;
        break;
      case 0x03:
        result = 16;
        break;
      case 0x04:
        result = 32;
        break;
      case 0x05:
        result = 64;
        break;
      case 0x06:
        result = 128;
        break;
      case 0x07:
        result = 256;
        break;

    }

    return result;
  }

  int getRAMSize(int mem)
  {
    int result;
    switch (mem)
    {
      case 0x00:
        result = 0;
        break;
      case 0x01:
        result = 1;
        break;
      case 0x02:
        result = 1;
        break;
      case 0x03:
        result = 4;
        break;
      case 0x04:
        result = 16;
        break;
      case 0x05:
        result = 8;
        break;
    }

    return result;
  }
}
