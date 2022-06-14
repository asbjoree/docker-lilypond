FROM ubuntu

COPY guile /root/guile

RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
RUN apt-get update
RUN apt-get build-dep -y lilypond
RUN apt-get install -y autoconf fonts-texgyre texlive-lang-cyrillic texlive-font-utils guile-2.2-dev install-info

COPY lilypond /root/lilypond

WORKDIR /root/lilypond
RUN ./autogen.sh --noconfigure
RUN mkdir build

WORKDIR /root/lilypond/build
RUN ../configure
RUN make -j 4
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

# Ez-numbers
RUN cp /root/plugins/non-git/ez-numbers/ez-numbers.ily /usr/local/share/lilypond/*/ly/

# Functional
RUN cp /root/plugins/non-git/functional/functional.ily /usr/local/share/lilypond/*/ly/

# Swing
RUN cp /root/plugins/non-git/swing/*.ily /usr/local/share/lilypond/*/ly/
RUN cp /root/plugins/non-git/swing/*.scm /usr/local/share/lilypond/*/scm/

# Clairnote
RUN cp /root/plugins/lilypond-clairnote/clairnote.ly /root/plugins/lilypond-clairnote/clairnote.ily
RUN cp /root/plugins/lilypond-clairnote/clairnote.ily /usr/local/share/lilypond/*/ly/

# Fonts
RUN cp /root/plugins/non-git/fonts/*.ily /usr/local/share/lilypond/*/ly/

# Profondo
RUN cp /root/plugins/profondo/otf/* /usr/local/share/lilypond/*/fonts/otf/
RUN cp /root/plugins/profondo/svg/* /usr/local/share/lilypond/*/fonts/svg/
RUN cp /root/plugins/profondo/supplementary-fonts/*.otf /usr/local/share/lilypond/*/fonts/otf/

# Gonville
RUN cp /root/plugins/gonville/otf/* /usr/local/share/lilypond/*/fonts/otf/
RUN cp /root/plugins/gonville/svg/* /usr/local/share/lilypond/*/fonts/svg/

# Improviso
RUN cp /root/plugins/improviso/otf/* /usr/local/share/lilypond/*/fonts/otf/
RUN cp /root/plugins/improviso/svg/* /usr/local/share/lilypond/*/fonts/svg/
RUN cp /root/plugins/improviso/supplementary-fonts/*.otf /usr/local/share/lilypond/*/fonts/otf/
