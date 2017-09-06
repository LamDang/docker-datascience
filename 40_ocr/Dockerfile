FROM 30_deeplearning:latest

MAINTAINER LAM DANG

USER root

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
	curl \
	libpng12-dev \
	libgif-dev  \
	libtiff5-dev \
	zlib1g-dev \
	python-poppler \
	unrtf \
	unrar-free \
	ghostscript \
	gnumeric

RUN apt-get remove libtool -y && apt-get install -y libtool

RUN apt-get install -y  \
	libicu-dev \
	libpango1.0-dev \
	libcairo2-dev

# install leptonica
RUN cd $ADD_PKG_PATH && \
    wget -q http://www.leptonica.com/source/leptonica-1.74.4.tar.gz && \
    tar -xzf leptonica-1.74.4.tar.gz && rm leptonica-1.74.4.tar.gz && \
    cd leptonica-1.74.4 && \
    ./configure && \
    make -j4 && make install

# Install tesseract
RUN cd $ADD_PKG_PATH && \
	git clone https://github.com/tesseract-ocr/tesseract.git && \
	cd tesseract && \
	./autogen.sh && \
	autoreconf --force --install && \
	./configure && \
	LDFLAGS="-L/usr/local/lib" CFLAGS="-I/usr/local/include" make -j4 && \
	make install && \
	make training && \
    make training-install && \
 	ldconfig

RUN cd $ADD_PKG_PATH && mkdir -m 777 tessdata && cd tessdata && \
    wget -q https://github.com/tesseract-ocr/tessdata/raw/4.00/spa.traineddata && \
    wget -q https://github.com/tesseract-ocr/tessdata/raw/4.00/spa_old.traineddata && \
    wget -q https://github.com/tesseract-ocr/tessdata/raw/4.00/fra.traineddata && \
    wget -q https://github.com/tesseract-ocr/tessdata/raw/4.00/eng.traineddata && \
    wget -q https://github.com/tesseract-ocr/tessdata/raw/4.00/kur.traineddata
ENV TESSDATA_PREFIX=$ADD_PKG_PATH/tessdata

# RUN cd /home/tesseract && \
#     cd tesseract && \
#     make training && \
#     make training-install

###install python packages

RUN conda install -y -c kalefranz imagemagick
#RUN conda install -y -c  birdhouse python-magic

RUN conda clean -tipsy && apt-get clean

USER $NB_USER
