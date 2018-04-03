#!/bin/sh

#Component Sources versions:
FRAMEWORK_COMP_VERSION="3_40_02_07"
CODEC_ENGINE_VERSION="3_24_00_08"
XDAIS_VERSION="7_24_00_04"
BIOS_VERSION="6_52_00_12"
XDCTOOLS_VERSION="3_50_03_33"
TI_CGT_BIN="ti_cgt_tms470_16.9.2.LTS_linux_installer_x86.bin" 

FRAMEWORK_COMP_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/fc/$FRAMEWORK_COMP_VERSION/exports/framework_components_$FRAMEWORK_COMP_VERSION.tar.gz"
CODEC_ENGINE_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ce/$CODEC_ENGINE_VERSION/exports/codec_engine_$CODEC_ENGINE_VERSION.tar.gz"
XDAIS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/xdais/$XDAIS_VERSION/exports/xdais_$XDAIS_VERSION.tar.gz"
BIOS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/bios/sysbios/$BIOS_VERSION/exports/bios_$BIOS_VERSION.run"
XDCTOOLS_WGET_URL="http://downloads.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/rtsc/$XDCTOOLS_VERSION/exports/xdccore/xdctools_${XDCTOOLS_VERSION}_core_linux.zip"
LINUXUTILS_WGET_URL="http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/linuxutils/$LINUXUTILS_VERSION/exports/linuxutils_$LINUXUTILS_VERSION.tar.gz"

if [ ! -d "component-sources" ]; then
	mkdir "component-sources"
fi
if [ ! -d "component-sources/framework_components_$FRAMEWORK_COMP_VERSION" ]; then
	wget -nc $FRAMEWORK_COMP_WGET_URL
	echo "Extracting framework components..."
	tar -zxf framework_components_$FRAMEWORK_COMP_VERSION.tar.gz -C component-sources/
	mv framework_components*.tar.gz component-sources/
fi
if [ ! -d "component-sources/codec_engine_$CODEC_ENGINE_VERSION" ]; then
	wget -nc $CODEC_ENGINE_WGET_URL
	echo "Extracting codec engine..."
	tar -zxf codec_engine_$CODEC_ENGINE_VERSION.tar.gz -C component-sources/
	mv codec_engine*.tar.gz component-sources/
fi
if [ ! -d "component-sources/xdais_$XDAIS_VERSION" ]; then
	wget -nc $XDAIS_WGET_URL
	echo "Extracting XDAIS..."
	tar -zxf xdais_$XDAIS_VERSION.tar.gz -C component-sources/
	mv xdais*.tar.gz component-sources/
fi
if [ ! -d "component-sources/bios_$BIOS_VERSION" ]; then
	wget -nc $BIOS_WGET_URL
	echo "Installing BIOS..."
	chmod +x bios_$BIOS_VERSION.run
	./bios_$BIOS_VERSION.run --prefix ./component-sources/ --mode unattended
	mv bios_*.run component-sources/
fi
if [ ! -d "component-sources/xdctools_${XDCTOOLS_VERSION}_core" ]; then
	wget -nc $XDCTOOLS_WGET_URL
	echo "Installing XDC tools..."
	unzip xdctools_*.zip -d ./component-sources/
        mv xdctools_*.zip ./component-sources/.
fi
wget -nc  http://software-dl.ti.com/codegen/esd/cgt_public_sw/TMS470/16.9.2.LTS/$TI_CGT_BIN -O component-sources/$TI_CGT_BIN
