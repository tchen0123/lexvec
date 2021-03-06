#!/bin/bash

set -e

# build lexvec binary
if [ ! -e lexvec ]; then
	go build
fi

if [ ! -e text8 ]; then
	echo Downloading text8 corpus
	if hash wget 2>/dev/null; then
		wget http://mattmahoney.net/dc/text8.zip
	else
		curl -O http://mattmahoney.net/dc/text8.zip
	fi
	unzip text8.zip
	rm text8.zip
fi

OUTPUTDIR=output

mkdir -p $OUTPUTDIR
# These settings are for small corpora such as text8. For larger corpora, stick to the default settings.
./lexvec -corpus text8 -output $OUTPUTDIR/vectors -dim 200 -iterations 15 -subsample 1e-4 -window 2 -model 2 -negative 25 -minfreq 5 -threads 12 -pos=false

echo Trained vectors saved to file $OUTPUTDIR/vectors
