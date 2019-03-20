FROM ubuntu

COPY guile /root/guile

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update
#RUN apt-get install -y git software-properties-common
RUN apt-get build-dep -y lilypond
RUN apt-get install -y autoconf install-info fonts-texgyre texlive-lang-cyrillic

WORKDIR /root/guile
RUN ./autogen.sh
RUN ./configure --disable-error-on-warning --prefix=/usr/local
RUN make
RUN make install
RUN ldconfig

COPY lilypond /root/lilypond

WORKDIR /root/lilypond
RUN ./autogen.sh --noconfigure
RUN mkdir build

WORKDIR /root/lilypond/build
RUN ../configure
RUN make
RUN make install

COPY plugins /root/plugins

WORKDIR /root/

# Roman numerals
RUN cp /root/plugins/lilypond-roman-numeral-tool/roman_numeral_analysis_tool.ily /usr/local/share/lilypond/*/ly/

# Lilyjazz
RUN cp /root/plugins/lilyjazz/stylesheet/*.ily /usr/local/share/lilypond/*/ly/
RUN cp /root/plugins/lilyjazz/otf/* /usr/local/share/lilypond/*/fonts/otf/
RUN cp /root/plugins/lilyjazz/svg/* /usr/local/share/lilypond/*/fonts/svg/
RUN cp /root/plugins/lilyjazz/supplementary-files/*/*.otf /usr/local/share/lilypond/*/fonts/otf/

# Merge-rests
RUN cp /root/plugins/lilymusic/include/merge-rests.ily /usr/local/share/lilypond/*/ly/

# Swing
RUN cp /root/plugins/non-git/swing/*.ily /usr/local/share/lilypond/*/ly/
RUN cp /root/plugins/non-git/swing/*.scm /usr/local/share/lilypond/*/scm/
