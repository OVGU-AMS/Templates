%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            Identification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ams-project}[2025/01/08 THE AMS PROJECT TEMPLATE]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            Preliminary declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\cover}{}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{eso-pic}
\RequirePackage{fix-cm}
\RequirePackage{amsmath}
\RequirePackage{picture}

\RequirePackage{nameref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\projecttype#1{\gdef\@projecttype{#1}}
 \global\let\@projecttype\@empty
\DeclareOption{cover}{
  \def\group#1{\gdef\@group{#1}}
  \global\let\@group\@empty
  \def\projectname#1{\gdef\@projectname{#1}}
  \global\let\@projectname\@empty
  \setlength\textwidth{16cm}

  \renewcommand{\cover}{
    \definecolor{covertextblue}{rgb}{0.3,0.46,0.6}
    \AddToShipoutPicture*{%
      \AtPageUpperLeft{%
        \put(\LenToUnit{0},\LenToUnit{0}){%
          \raisebox{-\height}{%
            \includegraphics[width=\paperwidth]{front_page_watermark.pdf}%
          }
        }
      }
    }
    \pagestyle{empty}


    \fontfamily{phv}\fontseries{b}\color{covertextblue}
    \fontshape{sl}
    \begin{center}
      ~\\[4cm]
      \fontsize{25}{30}\selectfont
      \@projecttype\\[0.2cm]
      \fontsize{34}{43}\selectfont
      \@projectname\\[0.2cm]
      \fontsize{25}{30}\selectfont
      \@date\\

      \fontseries{m}%
      \fontshape{n}
      \fontsize{25}{30}
      \color{covertextblue}
      \selectfont
      \vspace{2cm}
      \setlength{\fboxrule}{2pt}
      \fbox{%
        \begin{minipage}{16cm}%
          \centering
          \@title
        \end{minipage}
      }\\
      \setlength{\fboxrule}{1pt}
      \vspace{2cm}
      \@author\\

      \vfill
      \fontsize{20}{25}\selectfont
      \textbf{ams.ovgu.de}
    \end{center}

    \clearpage
    \ClearShipoutPicture
    \pagecolor{white}
    \parbox{16cm}{}
    \clearpage
    \pagestyle{empty}
  }
}
\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Main declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\LoadClass[twoside]{article}

\setlength{\parindent}{0em}
\setlength{\parskip}{1.5ex plus0.5ex minus0.2ex}
\renewcommand{\baselinestretch}{1.2}

\setlength{\fboxrule}{1pt}
\setlength{\fboxsep}{3mm}

\clubpenalty=100000
\widowpenalty=1000000
\brokenpenalty=1000000
\finalhyphendemerits=1000000


\renewcommand{\normalsize}{\fontsize{12pt}{14pt}\selectfont}
\RequirePackage[a4paper,hmargin=2cm,vmargin=1.5cm,includeheadfoot]{geometry}

\RequirePackage{fancyhdr}
\RequirePackage[pdftex,hypertexnames=false,colorlinks,linkcolor=black,citecolor=black]{hyperref}
\pagestyle{fancy}

\newcommand{\authorrunning}[1]{\gdef\@authorrunning{#1}}

\fancyhead[OR,EL]{\sffamily\footnotesize  \@currentlabelname}
\fancyhead[OL,ER]{\sffamily\footnotesize \@projecttype ~ \@projectname}
\fancyfoot[OR,EL]{\sffamily\small\thepage}
\fancyfoot[OC,EC]{\sffamily\footnotesize \@authorrunning}
\renewcommand{\headrulewidth}{0.1pt}
\renewcommand{\footrulewidth}{0.1pt}

\RequirePackage[pdftex]{graphicx}
\RequirePackage{color}
\RequirePackage{float}
%\RequirePackage[float]{caption2}
\RequirePackage{caption}
\renewcommand*\captionfont{\sffamily}
\renewcommand*\captionlabelfont{\sffamily\bfseries}

\renewcommand{\maketitle}{%
  {
    \renewcommand{\baselinestretch}{1}
    \cover
    \fontsize{20}{22}
    %\huge
    \fontfamily{phv}\fontseries{bx}%
  \selectfont\normalcolor
  \thispagestyle{empty}
  \setcounter{page}{1}
  \begin{center}
    \@title\\
    \fontsize{18}{22}
    %\LARGE
    \fontfamily{phv}\fontseries{b}%
    \fontshape{sl}\selectfont\normalcolor
    \vspace{0.5ex}
     --~\@projecttype:~\@projectname~--\\
    \vspace{1ex}
    \fontsize{16}{19}\fontfamily{phv}\fontseries{m}%
    \fontshape{n}\selectfont\normalcolor
    \@author\\
    \vspace{0.5ex}
    \fontsize{14}{17}\fontfamily{phv}\fontseries{m}%
    \fontshape{n}\selectfont\normalcolor
    \@date\\
    \vspace{1ex}
  \end{center}}
}

\renewenvironment{abstract}{%
  \normalsize
  \begin{center}%
    {\sffamily\bfseries\normalsize\abstractname}%\vspace{\z@}}%
  \end{center}%
  \quotation\vspace{-1cm}
  {\endquotation}
}


\renewcommand\section{\@startsection{section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\sffamily\Large\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                   {-3.25ex\@plus -1ex \@minus -.2ex}%
                                   {1.5ex \@plus .2ex}%
                                   {\sffamily\large\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                   {-3.25ex\@plus -1ex \@minus -.2ex}%
                                   {1.5ex \@plus .2ex}%
                                   {\sffamily\normalsize\bfseries}}%
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                   {3.25ex \@plus1ex \@minus.2ex}%
                                   {-1em}%
                                   {\sffamily\normalsize\bfseries}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}
                                   {3.25ex \@plus1ex \@minus .2ex}
                                   {-1em}
                                   {\sffamily\normalsize\bfseries}}

\def\rv#1{{\mathbf #1}} %Random Variable
\def\vec#1{\underline{#1}} %Vector
\def\rvv#1{{\vec{\rv{#1}}}} %Random Vector
\def\mat#1{{\mathbf #1}} %Matrix
\def\Var{\mathrm{Var}} %Variance
\def\E{\mathrm{E}} %Expectation
\def\Cov{\mathrm{Cov}} %Covariance
\def\IN{\mathrm{I\hspace{-2pt}N}} %Natural Numbers
\def\IR{\mathrm{I\hspace{-2pt}R}} %Real Numbers 