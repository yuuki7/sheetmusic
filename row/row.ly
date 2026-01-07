\version "2.24.4"

\header {
  title = "Row, Row, Row Your Boat"
}

\score {
  \relative c' {
    \time 6/8
    c4. c4. | c4 d8 e4. | e4 d8 e4 f8 | g2. | \break
    c8[ c8 c8] g8[ g8 g8] | e8[ e8 e8] c8[ c8 c8] | g'4 f8 e4 d8 | c2. \fine
  }

  \layout {
  }
}

\paper {
  page-breaking = #ly:one-page-breaking
  indent = #0
  tagline = ##f
}
