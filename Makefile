PICO8=/Applications/PICO-8.app/Contents/MacOS/pico8
TARGET=sw

all:
	$(PICO8) -run $(CURDIR)/main.p8

build: src
	rm -rf $(TARGET).p8.png
	$(PICO8) -x main.p8 -export $(TARGET).p8.png

sync: build
	scp $(TARGET).p8.png root@game-anbernic.lan:/mnt/sdcard/ROMS/DEV/.

clean_data:
	rm -f ../../cdata/horneds-$(TARGET)*

memdata:
	lua $(CURDIR)/data/convert.lua
	make inject TARGET=editor.p8
	make inject TARGET=main.p8

inject:
	@csplit $(TARGET) /__gfx__/
	@rm -f xx01 $(TARGET)
	@mv xx00 $(TARGET)
	@cat memdata.rom >> $(TARGET)

edit:
	open https://www.lexaloffle.com/bbs/?tid=144970

bin:
	$(PICO8) -x main.p8 -export $(TARGET).bin
