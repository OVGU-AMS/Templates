\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesistasksheet}[2025/06/03 LaTeX class for thesis task description sheet]
\LoadClass[a4paper, 10pt]{scrartcl}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{xifthen}

\RequirePackage{babel}

% Create a switch to choose language
\newif\ifgerman
\germanfalse % Default to English
\newcommand{\setgerman}{\germantrue\selectlanguage{ngerman}}
\newcommand{\setenglish}{\germanfalse\selectlanguage{english}}

\DeclareOption{german}{%
    \setgerman
}

\DeclareOption{english}{%
    \setenglish
}

% Define options for the type of thesis
\newif\if@master
\@mastertrue % Default to Master thesis

\DeclareOption{bachelor}{%
  \@masterfalse
}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
% Process options
\ProcessOptions\relax


% General settings
\parindent0pt
\parskip5mm plus1mm minus1mm

\setlength{\textwidth}{140mm}
\setlength{\textheight}{265mm}
\setlength{\oddsidemargin}{12mm}
\setlength{\evensidemargin}{12mm}
\setlength{\topmargin}{-20mm}
\setlength{\headheight}{0mm}
\setlength{\columnsep}{5mm}
\setlength{\footskip}{18mm}
\setlength{\headsep}{12mm}

\RequirePackage{graphicx}
\RequirePackage{tabularx}
\RequirePackage{amsmath}
\RequirePackage{mdwlist}
\RequirePackage{tabularx}
\RequirePackage{xspace}

\RequirePackage{etoolbox}
\RequirePackage{makecell}
\RequirePackage{tabto}


\newcommand{\supervisor}[2][]{%
  \listadd{\supervisorlist}{\ifthenelse{\isempty{#1}}{#2}{#1 #2}}%
  \listadd{\supervisornamelist}{#2}%
}

\newcommand{\printsupervisors}{
  \renewcommand*{\do}[1]{{##1}\\}\dolistloop{\supervisorlist}%
}


\newcommand{\Supervisor}[2][]{
  \newcommand{\supervisordegree}{#1}\xspace
  \newcommand{\supervisorname}{#2}        
}


\newcommand{\Mitarbeiter}[2][]{%
  \newcommand{\mitarbeitertitel}{#1\ }%
  \newcommand{\mitarbeitername}{#2}%
}
\newcommand{\student}[2][]{%
  \newcommand{\studentdegree}{#1\ }%
  \newcommand{\studentname}{#2}%
}
\def\matrikelnummer #1 {%
  \def\matrikelnr {#1}%
}

\def\Titel #1 {%
  \def\arbeittitel {#1}%
}

\def\type {%
\ifgerman\if@master Masterarbeit\else Bachelorarbeit\fi\else%
\if@master Master Thesis\else Bachelor Thesis\fi\fi%
}

\def\ThesisType #1 {% type is set manually
  \def\type{#1}%
}

\newenvironment{tasks}[0]{\textbf{\ifgerman Aufgaben:\else Tasks: \fi}\\[-1.5\baselineskip]\begin{itemize*}}{\end{itemize*}}

\def\Dates #1#2#3 {%
  \def\beginn {#1} \def\zwischen {#2} \def\ende {#3}%
}

\def\Beginning{%
  \centerline{\resizebox{\linewidth}{!}{\includegraphics{\ifgerman./logos/ovgu-fin-ams-de.pdf\else./logos/ovgu-fin-ams-en.pdf\fi}}}%
  % 
  \sffamily 
  \vspace*{5mm}%
  \centerline{\Large{%
      \textbf{\type:}}}\vspace*{-5mm}
  \begin{center}
    \Large{%
      \textbf{\arbeittitel}}
  \end{center}
  \bigskip
}			


  \newcommand{\signaturebox}[1]{%
  \parbox{5cm}{%
    \centering%
    \rule{4.5cm}{0.5pt}\\%
    \emph{#1}%
    \vspace{3.5cm}%
  }}%



\AtEndDocument{
 \vfill
  \hspace{-\parindent}%
  \renewcommand*{\do}[1]{\textbf{#1}\\}%
  \begin{tabularx}{\textwidth}{lXlX}%
    % \bf Titel: &\bf Effiziente Prädiktion nichtlinearer Systeme basierend auf der Approximation von Transitionsdichten mittels Gaussian Mixtures\\
    \textbf{Student:} &\textbf{\studentdegree\studentname} &
    \textbf{\ifgerman Matrikelnummer\else Matric. no. \fi: \matrikelnr}
    \\\ \\
    % \textbf{Betr. Mitarbeiter:}&\multicolumn{2}{l}{\textbf{\mitarbeitertitel\mitarbeitername\newline Horst Mustermann}}\\
    % 
    \textbf{\ifgerman Betreuer\else Supervisors\fi:}&\multicolumn{2}{l}{\makecell[tl]{%
    \dolistloop{\supervisorlist}}}\\
    % 
    % \textbf{Referent:}& \multicolumn{2}{l}{\textbf{\supervisordegree\supervisorname}}\\
    \ \\\end{tabularx}
  \begin{tabular}{lr}
    \textbf{\ifgerman Beginn:\else Beginning:\fi} &\textbf{\beginn}\\
    \textbf{\ifgerman Zwischenvortrag:\else Intermediate Presentation:\fi} & \textbf{\zwischen}\\
    \textbf{\ifgerman Abgabe:\else Submission:\fi} & \textbf{\ende}
  \end{tabular}
  \par
  \vfill


  Magdeburg, \ifgerman den \fi \today\par
  \vspace{1.5cm}%

  % \noindent\begin{tabularx}{1.0\linewidth}[h]{cXcXc}
  %   \underline{\hspace{4cm}}&\ &\underline{\hspace{4.5cm}}
  %   &\ &\underline{\hspace{4cm}}\\
  %   \emph{\studentname} && \emph{\mitarbeitername} && \emph{\supervisorname}
  % \end{tabularx}  

  % \uselengthunit{mm}\printlength{\dimexpr\textwidth/2-2cm\relax} % Print the width of half the textwidth


  % mnake signature boxes for student and supervisors
  \TabPositions{0cm, 5.5cm, 11cm} % Adjust tab positions as needed

   \signaturebox{%
    \studentname%
  }%
  \renewcommand*{\do}[1]{\tab \signaturebox{#1}}%
  \dolistloop{\supervisornamelist}%


}