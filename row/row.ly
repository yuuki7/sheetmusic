\version "2.24.4"

\header {
  title = "Row, Row, Row Your Boat"
  tagline = ##f
}

\score {
  <<
    \chords {
      c,2. * 4 | | | |
      c,2. * 2 | | g,2. | c,2.
    }

    \fixed c' {
      \time 6/8
      c4. c4. | c4 d8 e4. | e4 d8 e4 f8 | g2. | \break
      c'8[ c'8 c'8] g8[ g8 g8] | e8[ e8 e8] c8[ c8 c8] | g4 f8 e4 d8 | c2. \fine
    }
  >>

  \layout {
    indent = 0
  }

  \midi {
    \tempo 4. = 120
  }
}

\paper {
  page-breaking = #ly:one-page-breaking
}
