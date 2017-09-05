FROM 30_deeplearning:latest

MAINTAINER LAM DANG

USER root


###install python packages

RUN conda install -y -c kalefranz imagemagick
RUN conda install -y -c  birdhouse python-magic
 

### install apt packages

RUN apt-get update && \
	apt-get install -y  \
	apt-utils \
	python-wand \
	python-pythonmagick \
	g++ \
	autoconf \
	automake  \
	libtool \
	autoconf-archive \
	libleptonica-dev \
	 gcc \
	make \
	autoconf \
	pkg-config \
	zlib1g-dev \
	node \
	curl \
	libpng12-dev \
	libgif-dev  \
	libtiff5-dev \
	zlib1g-dev


RUN apt-get remove libtool -y && apt-get install -y libtool
																																																																																						
RUN apt-get install -y  \
	libicu-dev \
	libpango1.0-dev \
	libcairo2-dev

### install leptonica

RUN mkdir /home/lep && cd /home/lep && wget http://www.leptonica.com/source/leptonica-1.74.1.tar.gz && tar -xzf leptonica-1.74.1.tar.gz && \
cd leptonica-1.74.1 && \
./configure && \
make && make install


RUN mkdir /home/tesseract && cd /home/tesseract && git clone https://github.com/tesseract-ocr/tesseract.git && \
	cd /home/tesseract && \
	cd tesseract && \
	./autogen.sh && \
	autoreconf --force --install && \
	./configure && \
	LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make && \
	make install && \
 	ldconfig
 


RUN mkdir /home/tessdata && cd /home/tessdata && \
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/spa.traineddata && \
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/spa_old.traineddata && \
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/fra.traineddata && \
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/eng.traineddata && \
wget https://github.com/tesseract-ocr/tessdata/raw/4.00/kur.traineddata
ENV TESSDATA_PREFIX=/home/tessdata

RUN cd /home/tesseract && \
cd tesseract && \
 make training && \
 make training-install

RUN conda clean -tipsy && apt-get clean

USER $NB_USER


