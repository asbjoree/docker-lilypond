#(define Ez_numbers_engraver
   (make-engraver
    (acknowledgers
     ((note-head-interface engraver grob source-engraver)
      (let* ((context (ly:translator-context engraver))
         (tonic-pitch (ly:context-property context 'tonic))
         (tonic-name (ly:pitch-notename tonic-pitch))
         (grob-pitch
          (ly:event-property (event-cause grob) 'pitch))
         (grob-name (ly:pitch-notename grob-pitch))
         (delta (modulo (- grob-name tonic-name) 7))
         (note-names
          (make-vector 7 (number->string (1+ delta)))))
    (ly:grob-set-property! grob 'note-names note-names))))))

\layout {
  \context {
    \Voice
    \consists \Ez_numbers_engraver
  }
}

ezFlat = \markup \tiny \flat
ezSharp = \markup \tiny \sharp
