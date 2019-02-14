import 'dart:typed_data';
import 'dart:html';

class Memory
{

  List<Uint8List> romBanks;
  List<Uint8List> ramBanks;

  Uint8List videoRAMBank;
  Uint8List workRAMBank0;
  Uint8List workRAMBank1;
  Uint8List oam;
  Uint8List ioRegisters;
  Uint8List highRAMBank;

  String gameName;
  String mapper;

  int romBankNumber;
  int ramBankNumber;

  int romSize;
  int ramSize;

  bool _mode;

  Memory(Uint8List cart)
  {
    Uint8List thisROMBank = new Uint8List(0x4000);

    romBankNumber = 1;
    ramBankNumber = 0;
    int j = 0;

    _mode = false;

    gameName = getGameName(cart.sublist(0x134, 0x144));
    mapper  = getMapperType(cart[0x147]);
    romSize = getROMSize(cart[0x148]);
    ramSize = getRAMSize(cart[0x149]);

    document.querySelector('#title').setInnerHtml(gameName);
    document.querySelector('#mapper').setInnerHtml(mapper);
    document.querySelector('#rom-banks').setInnerHtml("ROM:" + (romSize*0xF).toString() + "K");
    document.querySelector('#ram-banks').setInnerHtml("RAM:" + (ramSize*0x8).toString() + "K");

    romBanks = new List(this.romSize);
    ramBanks = new List(this.ramSize);

    videoRAMBank = new Uint8List(0x2000);
    workRAMBank0 = new Uint8List(0x1000);
    workRAMBank1 = new Uint8List(0x1000);
    oam          = new Uint8List(0x00A0);
    ioRegisters  = new Uint8List(0x0080);
    highRAMBank  = new Uint8List(0x0080);


    for (int i = 0; i < cart.length; i++)
    {
      thisROMBank[i%0x4000] = cart[i];
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
        this.ramBanks[i] = new Uint8List(0x2000);
      }
    }


  }

  int read(int address)
  {
    if (address >= 0x8000 && address <= 0x9FFF) //VRAM
    {
      return videoRAMBank[address - 0x8000];
    }
    else if (address >= 0xC000 && address <= 0xCFFF) //WRAM Bank 0
    {
      return workRAMBank0[address - 0xC000];
    }
    else if (address >= 0xD000 && address <= 0xDFFF) //WRAM Bank 1
    {
      return workRAMBank1[address - 0xD000];
    }
    else if (address >= 0xE000 && address <= 0xEFFF) //WRAM Bank 0 Echo Fighter
    {
      return workRAMBank0[address - 0xE000];
    }
    else if (address >= 0xF000 && address <= 0xFDFF) //WRAM BANK 1 Echo Fighter
    {
      return workRAMBank1[address - 0xF000];
    }
    else if (address >= 0xFE00 && address <= 0xFE9F) //OAM
    {
      return oam[address - 0xFE00];
    }
    else if (address >= 0xFEA0 && address <= 0xFEFF) //NOT USABLE
    {
      return 0;
    }
    else if (address >= 0xFF00 && address <= 0xFF7F) //I/O Registers
    {
      return ioRegisters[address - 0xFF00];
    }
    else if (address >= 0xFF80 && address <= 0xFFFF) //High RAM (Zero Page)
    {
      return highRAMBank[address - 0xFF80];
    }
    if (mapper == "ROM")
    {
      if (address <= 0x3FFF) //ROM BANK 0
      {
        //print("read " + romBanks[0][address].toString() + " from ROM bank #0 at address " + address.toString());
        return romBanks[0][address];
      }
      else if (address >= 0x4000 && address <= 0x7FFF) //ROM BANK 0x1 - 0x7F
      {
        //print("read " + romBanks[romBankNumber][address-0x4000].toString() + " from ROM bank #" + romBankNumber.toString() + " at relative address " + (address - 0x4000).toString() + ", absolute address" + address.toString());
        return romBanks[1][address-0x4000];
      }
    }
    else if (mapper == "MBC1")
    {
      if (address <= 0x3FFF) //ROM BANK 0
      {
        //print("read " + romBanks[0][address].toString() + " from ROM bank #0 at address " + address.toString());
        return romBanks[0][address];
      }
      else if (address >= 0x4000 && address <= 0x7FFF) //ROM BANK 0x1 - 0x7F
      {
        //print("read " + romBanks[romBankNumber][address-0x4000].toString() + " from ROM bank #" + romBankNumber.toString() + " at relative address " + (address - 0x4000).toString() + ", absolute address" + address.toString());
        return romBanks[romBankNumber][address-0x4000];
      }
      else if (address >= 0xA000 && address <= 0xBFFF) //RAM BANK 0x00 - 0x03
      {
        //print("read " + ramBanks[ramBankNumber][address - 0xA000].toString() + " from RAM bank #" + ramBankNumber.toString() + " at address " + (address - 0xA000).toString());
        return ramBanks[ramBankNumber][address - 0xA000];
      }
    }
  }

  void write(int data, int address)
  {
    bool wroteToGB = true;
    bool wroteToCt = true;

    if (address >= 0x8000 && address <= 0x9FFF) //WRITE TO VRAM
    {
      videoRAMBank[address - 0x8000] = data;
    }
    else if (address >= 0xC000 && address <= 0xCFFF) //WRITE TO WRAM 0
    {
      workRAMBank0[address - 0xC000] = data;
    }
    else if (address >= 0xD000 && address <= 0xDFFF) //WRITE TO WRAM 0
    {
      workRAMBank1[address - 0xD000] = data;
    }
    else if (address >= 0xFE00 && address <= 0xFE9F) //WRITE TO OAM
    {
      oam[address - 0xFE00] = data;
    }
    else if (address >= 0xFF80 && address <= 0xFFFF) //WRITE TO HIGH RAM
    {
      highRAMBank[address - 0xFF80] = data;
    }
    else
    {
      wroteToGB = false;
    }
    if (mapper == "MBC1")
    {
      if (address >= 0 && address <= 0x1FFF)
      {
        //print("enabling RAM ;)");
      }
      else if (address >= 0x2000 && address <= 0x3FFF) //SET ROM BANK NUMBER
      {
        romBankNumber = data & 0x1F;

        if (romBankNumber == 0x00 || romBankNumber == 0x20 || romBankNumber == 0x40 || romBankNumber == 0x60)
        {
          romBankNumber++;
        }

        //print("Set ROM bank # to " + romBankNumber.toString());
      }
      else if (address >= 0x4000 && address <= 0x5FFF) //SET RAM BANK NUMBER OR HIGH ROM BANK NUMBER (MODE DEPENDENT)
      {
        if (_mode)
        {
          ramBankNumber = data & 0x3;
          //print("Set RAM bank to " + romBankNumber.toString());
        }
        else
        {
          romBankNumber = romBankNumber | (0x60 & (data << 5));
          //print("Set ROM bank to " + romBankNumber.toString());
        }
      }
      else if (address >= 0x6000 && address <= 0x7FFF) //SET HIGH ROM OR RAM BANKS
      {
        if ((data & 0x1) == 1)
        {
          _mode = true;
          //print("Set _mode to extended RAM");
        }
        if ((data & 0x1) == 0)
        {
          _mode = false;
          //print("Set _mode to extended ROM");
        }
      }
      else if (address >= 0xA000 && address <= 0xBFFF) //WRITE TO RAM BANKS
      {
        ramBanks[ramBankNumber][address - 0xA000] = data;
        //print("Wrote " + data.toString() + " to RAM bank #" + ramBankNumber.toString() + " at address " + (address - 0xA000).toString());
      }
      else
      {
        wroteToCt = false;
      }
    }

    if ((wroteToGB || wroteToCt) == false)
    {
      //print("attempted to write to unknown location" + address.toString());
    }

    if (address == 0xFF46) //DMA OAM TRANSFER
    {
      source = data << 8;

      print("DMA OAM TRANSFER FROM " + source.toString());

      for (int i = 0; i < 0x9F; i++)
      {
        write(read(source + i), 0xFE00 + i);
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

  List<String> readAll()
  {
    List<String> memory = [];
    for (int i = 0; i < 0x10000; i++)
    {
      memory.add(i.toString() + " " + read(i).toString());
      if (i % 0xF == 0)
      {
        print(i);
      }
    }
    return memory;
  }

}
