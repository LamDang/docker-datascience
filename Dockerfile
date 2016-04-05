FROM ubuntu:14.04

MAINTAINER Lam Dang <tunglam.dang@bnpparibas.com>

RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion
