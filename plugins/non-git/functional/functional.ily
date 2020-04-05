% ---------------------------------------------------------------
%               The "central" function
% Usage:
% FunctionLetter SopranoNote BassNote OptA OptB OptC OptD OptE FillStr
% ---------------------------------------------------------------

#(define-markup-command (fSymbol layout props FunctionLetter SopranoNote BassNote OptA OptB OptC OptD OptE FillStr)
   (markup? markup? markup? markup? markup? markup? markup? markup? markup?)
   (interpret-markup layout props
     #{
       \markup{
         \concat {
           \override #'(baseline-skip . 1.4)
           \center-column {
             \override #`(direction . ,UP)
             \override #'(baseline-skip . 2.0)
             \dir-column {
               \halign #CENTER
               $FunctionLetter
               \tiny
               \halign #CENTER
               $SopranoNote
             }
             \tiny
             $BassNote
           }
           \tiny
           \override #`(direction . ,UP)
           \override #'(baseline-skip . 0.8)
           \dir-column {
             " "
             {
               \override #`(direction . ,UP)
               \override #'(baseline-skip . 1.3)
               \dir-column { $OptA  $OptB $OptC $OptD $OptE }
             }
           }
           $FillStr
         }
       }
     #}))

% ---------------------------------------------------------------
%               Extender lines
% The text parameter "fText" will be placed at the left end of the extender.
% It will only consist of some spaces to move the left end a little forward.
% ---------------------------------------------------------------

fExtend =
#(define-music-function (parser location fText) (string?)
   #{
     \once \override TextSpanner #'direction = #DOWN
     \once \override TextSpanner #'style = #'line
     \once \override TextSpanner #'outside-staff-priority = ##f
     \once \override TextSpanner #'padding = #-0.6 % sets the distance of the line from the lyrics
     \once \override TextSpanner #'bound-details =
     #`((left . ((Y . 0)
                 (padding . 0)
                 (attach-dir . ,LEFT)))
        (left-broken . ((end-on-note . #t)))
        (right . ((Y . 0)
                  (padding . 0)
                  (attach-dir . ,RIGHT))))
     \once \override TextSpanner.bound-details.left.text = $fText
   #})

% ---------------------------------------------------------------
% ----- cross out the letter for "shortened dominants" (where base is omitted):
% ---------------------------------------------------------------

#(define-markup-command (prepend layout props prefix letter)
   (markup? markup?)
   (interpret-markup layout props
     #{
       \markup{
         \concat {
           \override #`(direction . ,UP)
           \override #'(baseline-skip . 0.8)
           \dir-column {
             " "
             {
               \override #`(direction . ,UP)
               \override #'(baseline-skip . 1.3)
               \tiny $prefix
             }
           }
           \override #'(baseline-skip . 0.4)
           \left-column {
             $letter            
           }
         }
       }
     #}))
% ---------------------------------------------------------------
% ----- Prepend a superscript prefix for 
% ---------------------------------------------------------------

#(define-markup-command (crossout layout props letter)
   (markup?)
   (interpret-markup layout props
     #{
       \markup{
         \concat {
           \override #'(baseline-skip . 0.4)
           \left-column {
             $letter
             \with-dimensions #'(-0.0 . 0.0) #'(0 . 0)
             \translate-scaled #'(-0.2 . 0.6)
             \with-dimensions #'(-0.0 . 0.0) #'(0 . 0)
             \draw-line #'(2 . 1.1)
           }
         }
       }
     #}))

% ---------------------------------------------------------------
% ----- double-printed letters for double dominant or double subdominant:
% ---------------------------------------------------------------

#(define-markup-command (double layout props letter)
   (markup?)
   (interpret-markup layout props
     #{
       \markup{
         \concat {
           \override #'(baseline-skip . 0.4)
           \left-column {
             $letter
             \with-dimensions #'(-0.4 . 0.6) #'(0 . 0)
             $letter
           }
         }
       }
     #}))

% ---------------------------------------------------------------
% ----- triple-printed letters for double dominant or double subdominant:
% ---------------------------------------------------------------

#(define-markup-command (triple layout props letter)
   (markup?)
   (interpret-markup layout props
     #{
       \markup{
         \concat {
           \override #'(baseline-skip . 0.4)
           \left-column {
             $letter
             \with-dimensions #'(-0.4 . 0.6) #'(0 . 0)
             $letter
             \with-dimensions #'(-0.8 . 1.6) #'(0 . 0)
             $letter
           }
         }
       }
     #}))

% ---------------------------------------------------------------
% cursive lowercase s
% ---------------------------------------------------------------
cursiveS = \markup

\with-dimensions #'(0 . 1.3) #'(0.05 . 0)
\path #0.15 
#'((rmoveto 0 0.3)
   (rlineto 0.8 1.0)
   (rcurveto 0 0 -0.1 -0.2 0.1 -0.4)
   (rcurveto 0 0 0.4 -0.3 -0.1 -0.6)
   (rcurveto 0 0 -0.1 -0.05 -0.2 0.06)
   )

% ---------------------------------------------------------------
% ----- double-printed letters for double dominant or double subdominant:
% ---------------------------------------------------------------

#(define-markup-command (doubleFunction layout props func letter)
   (markup? markup?)
   (interpret-markup layout props
     #{
       \markup{
         \raise #1 \concat {
           \override #'(baseline-skip . -1.4)
           \left-column {
             \override #`(direction . ,UP)
             \tiny $func
             \with-dimensions #'(0.6 . 1.5) #'(0 . 1)
             $letter
           }
         }
       }
     #}))

% ---------------------------------------------------------------
% opening round bracket before a chord:
% ---------------------------------------------------------------

openbracket = { \set stanza = \markup {\normal-text \magnify #1.1 " ("} }
backwardsbracket = { \set stanza = \markup {\normal-text \magnify #1.1 " ←("} }
opendoublebracket = { \set stanza = \markup {\normal-text \magnify #1.1 " [("} }
opentriplebracket = { \set stanza = \markup {\normal-text \magnify #1.1 " {[("} }

% ---------------------------------------------------------------
% ----- layout
% ---------------------------------------------------------------

\layout {
  \context {
    \Lyrics
    \consists "Text_spanner_engraver"
    \override LyricText.self-alignment-X = #LEFT
    \override LyricExtender.left-padding = #-0.5
    \override LyricExtender.extra-offset = #'(0 . 0.5)
  }
}
