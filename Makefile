LINKS = ../metamage_1/var/links

MACRELIX = MacRelix.app/Contents/MacOS/MacRelix

GRADIENT_SKIF = var/run/skif/gradient.skif
NYANCAT_SKIF  = var/run/skif/nyancat.skif

default:
	@echo 'Try `make gradient` or `make nyancat`.'

../%:
	@test -d ../$*/.git || git clone https://github.com/jjuran/$*.git ../$*

var-links: ../metamage_1
	@mkdir -p $(LINKS)

link/%: var-links
	@test -d ../$*/.git || (echo 'Please run `(cd .. && git clone https://github.com/jjuran/$*.git)`.'; exit 128)
	@test -e $(LINKS)/$* || (ln -s ../../../$* $(LINKS)/ && rm -f var/cache/compile-driver/catalog)

%.git: ../% link/%
	@true

clone: ../macward-compat ../freemount ../metamage_1

links: clone freemount.git macward-compat.git

checkout: ../metamage_1
	(cd ../metamage_1 && git checkout osb2017)

bin:
	@mkdir -p bin

setup: links checkout bin
	@test -f setup || touch setup

bin/%: setup
	(cd ../metamage_1 && ./build.pl $*)
	cp ../metamage_1/var/build/x86-mach-carb-dbg/bin/$*/$* bin/
	@echo Build of $* complete'!'
	@echo

$(MACRELIX): bin/A-line bin/cpres bin/vx var-run-fs
	PATH=${PWD}/bin:${PWD}/../metamage_1/bin:${PATH} ALINE_SRC_TREE=../metamage_1 ALINE_BUILDS=var/app-build bin/A-line -j3 Genie
	cp -a var/app-build/x86-mach-carb-dbg/bin/Genie/MacRelix.app .
	@touch $(MACRELIX)
	mkfifo ${HOME}/var/run/fs/gui.fifo || true
	@echo Build of MacRelix.app complete'!'
	@echo

MacRelix: $(MACRELIX)

var-run-fs:
	@mkdir -p ${HOME}/var/run/fs

var-run-skif:
	@mkdir -p var/run/skif

exhibiting: bin/raster bin/uunix bin/exhibit MacRelix bin/telecast-send

interacting: exhibiting bin/interact
displaying:  exhibiting bin/vraster

open-MacRelix: MacRelix
	@open MacRelix.app
	@true > ${HOME}/var/run/fs/gui.fifo

gradient: displaying var-run-skif open-MacRelix
	test -f $(GRADIENT_SKIF) || bin/raster make -g 512x384x32 -m xRGB $(GRADIENT_SKIF)
	utils/gradient.pl 512 384 1<> $(GRADIENT_SKIF)
	PATH=./bin:${PATH} bin/exhibit --raster $(GRADIENT_SKIF)

nyancat: interacting bin/nyancat var-run-skif open-MacRelix
	test -f $(NYANCAT_SKIF) || bin/raster make -g 70x72x32 -m xRGB -R $(NYANCAT_SKIF)
	@echo
	@echo 'Nyan nyan nyan nyanyanyanyan nyan nyan!  (Press q to quit.)'
	@echo
	PATH=./bin:${PATH} bin/exhibit -x5 --raster $(NYANCAT_SKIF) bin/nyancat -f $(NYANCAT_SKIF) -i 70

.SECONDARY:
