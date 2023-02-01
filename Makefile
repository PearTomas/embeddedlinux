.PHONY := mediaplayer

all:  mediaplayer

.DEFAULT_GOAL := all

clone:
	git clone https://github.com/buildroot/buildroot

mediaplayer:
	cd ./buildroot; git apply ../mediaplayer.patch; $(MAKE) raspberrypi3_defconfig
	$(MAKE) -C buildroot 
	cp play.sh buildroot/output/target/etc/profile.d/
	echo "/etc/play.sh &" > buildroot/output/target/etc/rc.local
	chmod 766 buildroot/output/target/etc/profile.d/play.sh
	$(MAKE) -C buildroot 


