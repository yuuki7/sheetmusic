\version "2.24.4"

\paper {
  indent = #0
  line-width = #120
}

\header {
  title = "Twinkle, Twinkle, Little Star"
}

\score {
  <<
  \chords {
    c,1 | f,2 c,2 | f,2 c,2 | g,2 c,2 |
    c,2 f,2 | c,2 g,2 | c,2 f,2 | c,2 g,2 |
    c,1 | f,2 c,2 | f,2 c,2 | g,2 c,2
  }
  \relative c' {
    \time 4/4
    c4 c4 g'4 g4 | a4 a4 g2 | f4 f4 e4 e4 | d4 d4 c2 | \break
    g'4 g4 f4 f4 | e4 e4 d2 | g4 g4 f4 f4 | e4 e4 d2 | \break
    c4 c4 g'4 g4 | a4 a4 g2 | f4 f4 e4 e4 | d4 d4 c2 \fine
  }
  >>

  \layout {
    \autoBreaksOff
    \numericTimeSignature
  }

  \midi {
    \tempo 4 = 120
  }
}
