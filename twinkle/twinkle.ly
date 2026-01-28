\version "2.24.4"

\header {
  title = "Twinkle, Twinkle, Little Star"
}

\score {
  <<
    \chords {
      c,1 | f,2 c,2 | f,2 c,2 | g,2 c,1

      f,2 | c,2 g,2 | c,2 f,2 | c,2 g,2 |

      c,1 | f,2 c,2 | f,2 c,2 | g,2 c,2
    }

    \fixed c' {
      \numericTimeSignature
      \time 4/4

      c4 c4 g4 g4 | a4 a4 g2 | f4 f4 e4 e4 | d4 d4 c2 | \break

      g4 g4 f4 f4 | e4 e4 d2 | g4 g4 f4 f4 | e4 e4 d2 | \break

      c4 c4 g4 g4 | a4 a4 g2 | f4 f4 e4 e4 | d4 d4 c2 \bar "|."
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
