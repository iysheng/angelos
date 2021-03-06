#!/bin/sh

TARGET_NAME=yyfish.bin
DTB_SRC_NAME=dts/stm32429i-eval.dtb
DTB_NAME=yyfish.dtb
SD_PATH=/run/media/shengyang/YYFISH/
TFTP_PATH=/home/shengyang/lan/tftpboot/
UIMAGE=uImage

if [ -e $UIMAGE ];then
	cp $UIMAGE $TARGET_NAME
else
	mkimage -A arm -O linux -T kernel -C none -a 0xc0008000 -e 0xc0008001 -n "yyfish" -d Image $TARGET_NAME

fi

usage()
{
	echo "Usage: sh builduImage.sh [t][s] "
}

if [ $# -gt 0 ];then
case $1 in
	t) cp -v $TARGET_NAME $TFTP_PATH ;
	cp -v $DTB_SRC_NAME $TFTP_PATH/$DTB_NAME ; shift ;;
	s) cp -v $TARGET_NAME $SD_PATH ;
	sudo umount $SD_PATH ; sudo umount /dev/sdb2 ; shift ;;
	*)
	usage break;;
esac
fi
