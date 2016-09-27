rm -rf tmp
mkdir tmp
if [ ! -d grupo09/dirconf ]; then
	mkdir grupo09/dirconf
fi
tar zcvf tmp/grupo09.tar.gz grupo09
cd tmp
tar -xvf grupo09.tar.gz
cd grupo09