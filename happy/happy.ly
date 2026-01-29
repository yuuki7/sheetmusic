\version "2.24.4"

\header {
  title = "Happy Birthday to You"
}

\score {
  <<
    \chords {
      s4
      c,2. | g,2. | g,2. | c,2. |

      c,2. | f,2. | c,2 g,4 | c,2
    }

    \fixed c' {
      \time 3/4

      \partial 4
      g8.[ g16] | a4 g4 c'4 | b2 g8.[ g16] | a4 g4 d'4 | c'2 g8.[ g16] | \break

      g'4 e'4 c'4 | b4 a4\fermata f'8.[ f'16] | e'4 c'4 d'4 | c'2 \bar "|."
    }
  >>

  \layout {}

  \midi {
    \tempo 4 = 120
  }
}

\paper {
  paper-width = 120\mm

  top-margin = 0
  bottom-margin = 0.1\mm
  left-margin = 1.6\mm
  right-margin = 0.1\mm

  indent = 0
  tagline = ##f
  page-breaking = #ly:one-page-breaking

  last-bottom-spacing.padding = -3.58\mm
  % annotate-spacing = ##t
}
