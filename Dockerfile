FROM ubuntu

COPY lilypond /root/lilypond
COPY plugins /root/plugins
COPY guile /root/guile

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update
#RUN apt-get install -y git software-properties-common
RUN apt-get build-dep -y lilypond
RUN apt-get install -y autoconf install-info fonts-texgyre texlive-lang-cyrillic libunistring-dev libffi-dev libgc-dev

WORKDIR /root/guile
RUN ./autogen.sh
RUN ./configure --disable-error-on-warning --prefix=/usr/local
RUN make
RUN make install
RUN ldconfig

WORKDIR /root/lilypond
RUN ./autogen.sh --noconfigure
RUN mkdir build

WORKDIR /root/lilypond/build
RUN ../configure
RUN make
RUN make install

