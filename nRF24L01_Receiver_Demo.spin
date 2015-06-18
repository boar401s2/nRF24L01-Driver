CON

  _clkmode = XTAL1 + PLL16X
  _xinfreq = 5_000_000

OBJ

  nRF: "nRF24L01"
  Serial: "FullDuplexSerial"

PUB Main | c

  Serial.start(31, 30, 0, 115200)
  Serial.str(String(16, "Starting receiver...", 13, 13))

  nRF.init(0, 1, 2, 3, 4, 5)
  nRF.setReceiver

  DIRA[5]~                      'Set IRQ to Input

  repeat
    if INA[5] == 0
      nRF.writeRegister(nRF#REG_STATUS, %0010_0000)
      c := nRF.readRegister(nRF#R_RX_PAYLOAD)
      Serial.bin(c, 8)
      Serial.tx(13)

    waitcnt(clkfreq/10+cnt)




