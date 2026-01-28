\version "2.24.4"

\header {
  title = "Row, Row, Row Your Boat"
}

\score {
  <<
    \chords {
      c,1 * 3 | |

      | g,2 c,2
    }

    \fixed c' {
      \numericTimeSignature
      \time 4/4

      c4 c4 c8.[ d16] e4 | e8.[ d16] e8.[ f16] g2 | \break

      \tuplet 3/2 { c'8[ c'8 c'8] } \tuplet 3/2 { g8[ g8 g8] }
      \tuplet 3/2 { e8[ e8 e8] } \tuplet 3/2 { c8[ c8 c8] }
      | g8.[ f16] e8.[ d16] c2 \bar "|."
    }
  >>

  \layout {}

  \midi {
    \tempo 4 = 120
  }
}

\paper {
  paper-width = 120\mm
  indent = 0
}
