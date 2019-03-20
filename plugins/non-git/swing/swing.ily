%%% Function: rhythmMark
%%% ============================================================
%%%  Purpose: print a sophisticated rehearsal mark e.g
%%%           for rhythm directives
%%%    Usage: \rhythmMark label music1 music2
%%% ------------------------------------------------------------
%%% Variable: label (string)
%%% ------------------------------------------------------------
%%% Variable: music1 (ly:music)
%%% ------------------------------------------------------------
%%% Variable: music2 (ly:music)
%%% ------------------------------------------------------------
%%%  Example: \rhythmMark #"Swing" \rhyMarkIIEighths
%%%                 \rhyMarkSlurredTriplets
%%% ------------------------------------------------------------
%%% Constants:
%%%           rhythmMarkStaffReduce = #-3
%%%           rhythmMarkLabelFontSize = #-2
%%% ------------------------------------------------------------
%%%  Comment: see below for predefined values for music1&2
%%% ============================================================

#(load (string-append (ly:get-option 'datadir) "/scm/swing.scm"))

rhythmMarkStaffReduce = #-3
rhythmMarkLabelFontSize = #-2

rhythmMark = #(define-music-function (parser location label musicI musicII ) (string? ly:music? ly:music?)
   #{
      \mark \markup {
        \line \general-align #Y #DOWN {
          \combine
            \italic \fontsize #rhythmMarkLabelFontSize $label
            \transparent \italic \fontsize #rhythmMarkLabelFontSize f

          \score {                     % 2nd column in line
            \new Staff \with {
              fontSize = #rhythmMarkStaffReduce
              \override StaffSymbol #'staff-space = #(magstep rhythmMarkStaffReduce)
              \override StaffSymbol #'line-count = #0
              \override VerticalAxisGroup #'Y-extent = #'(-0.85 . 4)
            }

            {
              \relative { \stemUp $musicI }
             
%             \override Score.SpacingSpanner #'strict-note-spacing = ##t
              \once \override Score.TextScript #'Y-offset = #-0.4
              s4.^\markup{ \halign #-1 \italic "=" }
              
              \relative { \stemUp $musicII }
            } 
            
            \layout {
              ragged-right= ##t
              indent = 0
              \context {
                \Staff
                \remove "Clef_engraver"
                \remove "Time_signature_engraver"
              }
            } % layout end

          } % Score end

        } % line end
      } % markup end
   #})

%%% Function: rhythmMarkC
%%% ============================================================
%%%  Purpose: print a sophisticated rehearsal mark e.g for
%%%           rhythm directives in a column (music on top)
%%%    Usage: \rhythmMarkC label music1 music2
%%% ------------------------------------------------------------
%%% Variable: label (string)
%%% ------------------------------------------------------------
%%% Variable: music1 (ly:music)
%%% ------------------------------------------------------------
%%% Variable: music2 (ly:music)
%%% ------------------------------------------------------------
%%%  Example: \rhythmMarkC #"Swing" \rhyMarkIIEighths
%%%                 \rhyMarkSlurredTriplets
%%% ------------------------------------------------------------
%%% Constants:
%%%           rhythmMarkCStaffReduce = #-4
%%%           rhythmMarkCLabelFontSize = #-2
%%% ------------------------------------------------------------
%%%  Comment: see below for predefined values for music1&2
%%% ============================================================

rhythmMarkCStaffReduce = #-4
rhythmMarkCLabelFontSize = #-2

rhythmMarkC = #(define-music-function (parser location label musicI musicII ) (string? ly:music? ly:music?)
   #{
      \mark \markup
      {
        \combine

          \line {
            \hspace #0
            \translate #'(-0.1 . -3.25) \italic \fontsize #rhythmMarkCLabelFontSize $label
          } % end Line

          \line \vcenter {

              \score {                 % 1st column in line

                \new Staff \with {
                  fontSize = #rhythmMarkCStaffReduce
                  \override StaffSymbol #'staff-space = #(magstep rhythmMarkCStaffReduce)
                  \override StaffSymbol #'line-count = #0 
                  \override VerticalAxisGroup #'Y-extent = #'(0 . 0)  % td
                }

                \relative { \stemUp $musicI }

                \layout {
                  ragged-right= ##t
                  indent = 0
                  \context {
                    \Staff
                    \remove "Clef_engraver"
                    \remove "Time_signature_engraver" }
                } % layout

              } % 1st score

              \hspace #-0.1            % 2nd column in line

                                       % 3rd column in line
              \italic \fontsize #rhythmMarkCStaffReduce "="

              \score {                 % 4th column in line

                \new Staff \with {
                  fontSize = #rhythmMarkCStaffReduce
                  \override StaffSymbol #'staff-space = #(magstep rhythmMarkCStaffReduce)
                  \override StaffSymbol #'line-count = #0 
                  \override VerticalAxisGroup #'Y-extent = #'(0 . 0)  % td
                }

                \relative {
                  \stemUp $musicII
                }

                \layout {
                  ragged-right= ##t
                  indent = 0
                  \context {
                    \Staff
                    \remove "Clef_engraver"
                    \remove "Time_signature_engraver" }
                } % layout

              } % 2nd score end

            } % line end
          % end combine
        } % markup end
   #})

%%% predefined ly:music-Variables for use
%%% in function rhythmMark and rhythmMarkC
%%% ============================================================
rhyMarkI = { b'1*1/8 }

rhyMarkII = { b'2*1/4 }

rhyMarkIV = { b'4*1/2 }

rhyMarkEighth = { b'8 }

rhyMarkIIEighths = {
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 4) % tight
  \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 3 16) % even
  b'8[ b8]
}
rhyMarkTriplets = {
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 2) % super-tight
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 4) % tight
  \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 3 16) % even
  \times 2/3 { b'4 b8 }
}
rhyMarkSlurredTriplets = {
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 4) % tight
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 5 32) % slighty tighter as even
  \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 8) % even
  \times 2/3 { b'8 ~ b8 b8 }
}
rhyMarkDottedEighths = {
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 4) % tight
  \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 3 16) % even
  % \override Score.SpacingSpanner #'common-shortest-duration = #(ly:make-moment 1 8) % loose
  { b'8.[ b16*2] }
}


%%% Begin Example
%%% ============================================================
%{
spacer = {
  | g'1
  \noBreak
  | g'1
  | g'1
}

spacerII = {
  | g'1
  \noBreak
  | g'1
}

\score {
  {
    \override Score.RehearsalMark #'self-alignment-X = #LEFT
    \override Score.BarNumber #'break-visibility = #all-invisible
%    \override Score.RehearsalMark #'padding = #-2
    \once \override Score.RehearsalMark #'X-offset = #5  % td
    \rhythmMark #"Swing" \rhyMarkIIEighths \rhyMarkSlurredTriplets
    \spacer
    \rhythmMark #"straight" \rhyMarkEighth \rhyMarkEighth
    \spacer
    \rhythmMark #"Shuffle" \rhyMarkIIEighths \rhyMarkDottedEighths
    \spacer
    \once \override Score.RehearsalMark #'X-offset = #5  % td
    \rhythmMark #"straight" \rhyMarkIIEighths \rhyMarkIIEighths
    \spacer
    \rhythmMark #"Swing" \rhyMarkIIEighths \rhyMarkTriplets
    \spacer
    \rhythmMark #"in 2" \rhyMarkII \rhyMarkIV
    \spacer
    \once \override Score.RehearsalMark #'X-offset = #5  % td
    \rhythmMark #"Swing feel" \rhyMarkDottedEighths \rhyMarkTriplets
    \spacer
    \rhythmMark #"Maestoso" \rhyMarkII \rhyMarkI
    \spacer
    \rhythmMark #"suassa" \rhyMarkII \rhyMarkI % This is just to proof that the basline-fake really works
    \spacer
    \once \override Score.RehearsalMark #'X-offset = #5  % td
    \break
    \rhythmMarkC #"Swing" \rhyMarkIIEighths \rhyMarkSlurredTriplets
    \spacerII
    \rhythmMarkC #"straight" \rhyMarkEighth \rhyMarkEighth
    \spacerII
    \rhythmMarkC #"Shuffle" \rhyMarkIIEighths \rhyMarkDottedEighths
    \spacerII
    \rhythmMarkC #"straight" \rhyMarkIIEighths \rhyMarkIIEighths
    \spacerII
    \rhythmMarkC #"Swing" \rhyMarkIIEighths \rhyMarkTriplets
    \spacerII
    \rhythmMarkC #"in 2" \rhyMarkII \rhyMarkIV
    \spacerII
    \once \override Score.RehearsalMark #'X-offset = #5  % td
    \rhythmMarkC #"Swing feel" \rhyMarkDottedEighths \rhyMarkTriplets
    \spacerII
    \rhythmMarkC #"Maestoso" \rhyMarkII \rhyMarkI
    \spacerII
  }
  
  \layout {
    ragged-right= ##t
    indent = 0       
  }
}

\paper {
  system-system-spacing #'padding = #4
}
%}

