\version "2.24.4"

\paper {
  indent = #0
  line-width = #120
}

\header {
  title = "Row, Row, Row Your Boat"
}

\score {
  <<
  \chords {
    c,2.*4 |
    c,2.*2 | g,2. | c,2.
  }
  \relative c' {
    \time 6/8
    c4. c4. | c4 d8 e4. | e4 d8 e4 f8 | g2. | \break
    c8[ c8 c8] g8[ g8 g8] | e8[ e8 e8] c8[ c8 c8] | g'4 f8 e4 d8 | c2. \fine
  }
  >>

  \layout {
    \autoBreaksOff
    \numericTimeSignature
  }

  \midi {
    \tempo 4. = 120
  }
}
