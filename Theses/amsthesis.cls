
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            Identification
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{amsthesis}[2025/01/08 The AMS Thesis Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            Class Options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ifthen}

\newif\iftype@dissertation
\DeclareOption{PhD}{%
	\type@dissertationtrue%
}

\newif\iftype@BA
\DeclareOption{BA}{%
	\type@BAtrue%
}

\newif\iftype@MA
\DeclareOption{MA}{%
	\type@MAtrue%
}

\newif\if@german
\@germanfalse
\DeclareOption{german}{%
	\@germantrue%
}

\ProcessOptions\relax

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Main declarations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClass[a4paper,twoside,openright,numbers=noenddot,12pt]{book}

\RequirePackage{amsmath,amsfonts,amssymb}
\RequirePackage[usenames, dvipsnames]{xcolor}
\RequirePackage{graphicx}

\RequirePackage[utf8]{inputenc}				% Letters like ä ü ö ß
\RequirePackage{epstopdf}					% include of .eps files in pdflatex, requires a ghostscript installation
\RequirePackage[main=english,ngerman]{babel}				% Lineending in english

\RequirePackage{lmodern}

\RequirePackage{caption,subcaption}			% Subcaption and subfigures 
% Caption formatting
\captionsetup{format=hang,justification=justified,singlelinecheck=false,labelfont={sf,bf}}

\RequirePackage{multirow}					% Table with combined rows and columns

\RequirePackage{microtype}					% Better font typesetting

\RequirePackage{tikz}						% To use TikZ
\usetikzlibrary{calc}

\RequirePackage[hidelinks]{hyperref}		% Avoid highlighting of links

\RequirePackage{texdate}


% Specify page margins
\newlength{\pagemarginleft}
\setlength{\pagemarginleft}{3cm}
\newlength{\pagemarginright}
\setlength{\pagemarginright}{4cm}

\RequirePackage[a4paper,
	left=\pagemarginleft,
	right=\pagemarginright,
	top=2cm,
	bottom=2cm,
	includeheadfoot]{geometry}

\renewcommand{\baselinestretch}{1.2}
% \renewcommand{\normalsize}{\fontsize{12pt}{14pt}\selectfont}

% \newcommand{\degree}[1]{\def\@degree{#1}}
\newcommand{\birthdate}[1]{\def\@birthdate{#1}}
\newcommand{\birthplace}[1]{\def\@birthplace{#1}}

\def\degree#1{\gdef\@degree{#1}}
\def\@birthdate#1{\gdef\@birthdate{#1}}
\def\@birthplace#1{\gdef\@birthplace{#1}}
% \def\@degree{\@latex@warning@no@line{No \noexpand\degree given}}
% \def\@birthdate{\@latex@warning@no@line{No \noexpand\birthdate given}}
% \def\@birthplace{\@latex@warning@no@line{No \noexpand\birthplace given}}
\def\@degree{}
\def\@birthdate{}
\def\@birthplace{}
\def\@matriculation{}

\def\reviewerA#1{\gdef\@reviewerA{#1}}
\def\reviewerB#1{\gdef\@reviewerB{#1}}
\def\reviewerC#1{\gdef\@reviewerC{#1}}
\def\reviewerD#1{\gdef\@reviewerD{#1}}
\def\@reviewerA{}
\def\@reviewerB{}
\def\@reviewerC{}
\def\@reviewerD{}

\def\thesistype#1{\gdef\@thesistype{#1}}
\iftype@dissertation
	\def\@thesistype{Dissertation}
\else
\iftype@MA
	\def\@thesistype{Master Thesis}
\else
\iftype@BA
	\def\@thesistype{Bachelor Thesis}
\else
	\def\@thesistype{}
\fi\fi\fi


%% Defintions MA/BA %%
\newcommand\matriculationlabel[0]{ }
\newcommand\matriculation[1]{\def\@matriculation{#1}}
\newcommand\supervisor[1]{\def\@supervisor{#1}}
\newcommand{\supervisorlabel}[0]{ }
\newcommand{\proflabel}[0]{ }
\newcommand{\secondproflabel}[0]{ }
\if@german
	\renewcommand{\matriculationlabel}{Immatrikulationsnr.: }
	\renewcommand{\supervisorlabel}[0]{Betreuer: }
	\renewcommand{\proflabel}[0]{Themensteller: }
	\renewcommand{\secondproflabel}[0]{Zweitgutachter: }
\else
	\renewcommand{\matriculationlabel}{Matrikulation no.: }
	\renewcommand{\supervisorlabel}[0]{Supervisor: }
	\renewcommand{\proflabel}[0]{Professor: }
	\renewcommand{\secondproflabel}[0]{Second Assessor: }
\fi

\newcommand{\titleheader}[0]{$\quad$}
\iftype@BA%
	\if@german%
		\renewcommand{\titleheader}[0]{Bachelorarbeit}
	\else
		\renewcommand{\titleheader}[0]{Bachelor Thesis}
	\fi
\fi

\iftype@MA%
	\if@german
		\renewcommand{\titleheader}[0]{Masterarbeit}
	\else
		\renewcommand{\titleheader}[0]{Master Thesis}
	\fi
\fi


\if@german
	\newcommand{\@institution}{
		Otto-von-Guericke-Universit\"at Magdeburg\\
		Fakult\"at f\"ur Informatik\\
		Institut f\"ur Intelligente Kooperierende Systeme\\
		Lehrstuhl für Autonome Multisensor Systeme
	}
\else
	\newcommand{\@institution}{
		Otto von Guericke University Magdeburg\\
		Faculty of Computer Science\\
		Institute for Intelligent Cooperating Systems\\
		Autonomous Multisensor Systems Group
	}
\fi
%\newlength{\institutionheight}
%\settoheight{\institutionheight}{{\@institution}}
\newcommand{\instlogo}[0]{\includegraphics[scale=0.45]{figures/logos/AMS}}
		
%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Avoiding Widows and Orphans
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\clubpenalty = 5000
\widowpenalty = 5000
\displaywidowpenalty = 3500


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Page Headers
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{fancyhdr}					% Formatting of headers
\setlength{\fboxrule}{1pt}
\setlength{\fboxsep}{3mm}

\setlength{\headheight}{14pt}
\pagestyle{fancy}
\renewcommand{\chaptermark}[1]{\markboth{\if@mainmatter\chaptername~\thechapter.\ \fi#1}{}}
\fancyhead[LE]{\sffamily \leftmark}     			% Chapter in the left on even pages
\fancyhead[RO]{\sffamily \nouppercase{\rightmark}}	% Section in the right on odd pages
\fancyhead[RE]{}					% page number in the right on even pages
\fancyhead[LO]{}					% page number in the left on odd pages
\fancyfoot[OR,EL]{\sffamily \thepage}
\fancyfoot[OC,EC]{}
% \fancyfoot{}
\renewcommand{\headrulewidth}{0.5pt}
\renewcommand{\footrulewidth}{0pt}

%% bring the style into effect
\pagestyle{fancy}

%% now redefine the plain style pages (chapter pages, contents pages)
%% to have the same page number stuff on the bottom
\fancypagestyle{plain}{
	\fancyhf{}
	\fancyfoot[OR]{\sffamily \thepage}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}
}

%% this next section (till \makeatother) makes sure that blank pages
%% are actually completely blank, cause they're not usually
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
			\hbox{}
			\vspace*{\fill}
			\thispagestyle{empty}
			\newpage
			\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Chapter Style
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{titlesec}

\titleformat{\chapter}[display]
{\normalfont\Large\raggedleft}
{\MakeUppercase{\chaptertitlename}%
	\rlap{ \color{gray!50!black}\resizebox{!}{1.3cm}{\bfseries\thechapter} \rule{5cm}{1.3cm}}}
{10pt}{\Huge}
\titlespacing*{\chapter}{0pt}{30pt}{20pt}


% \titleformat{\chapter}[block]
% {\Large\bfseries}
% {\raisebox{-\height}{\sffamily\scriptsize\MakeUppercase{\chaptertitlename}}%
% 	\space\raisebox{-\height}{\bigchapternumber}\space}
% {0pt}
% {\printtitle}

% \newlength\pretitlewidth
% \newcommand\bigchapternumber{\resizebox{24pt}{!}{\sffamily\bfseries\thechapter}}
% \newcommand{\printtitle}[1]{%
% 	\settowidth{\pretitlewidth}{%
% 		{\sffamily\scriptsize\MakeUppercase{\chaptertitlename}}\space
% 		{\bigchapternumber}\space
% 	}%
% 	\parbox[t]{\dimexpr\textwidth-\pretitlewidth}{%
% 		\linespread{1.5}\selectfont
% 		\hrule depth 0.2pt
% 		\vspace{3ex}
% 		\raggedright\bfseries #1
% 	}%
% }
% \titlespacing*{\chapter}{0pt}{0pt}{40pt}

% \titleformat{\chapter}[display]
% {\bfseries\LARGE}
% {\filleft\hspace*{-60pt}%
% 	\rotatebox[origin=c]{90}{%		
% 		\scshape\color{gray!50!black}	\large\textls[200]{\vspace*{5mm}\scshape\chaptertitlename}%
% 	}\hspace{10pt}%
% 	{\setlength{\fboxsep}{0pt}%
% 		\colorbox{gray!50!black}{\parbox[c][3cm][c]{2.5cm}{%
% 				\centering\color{white}\fontsize{120}{140}\selectfont{\thechapter}}%
% 		}}%
% }
% {10pt}
% {}[{\titlerule[3pt]\vskip2pt\titlerule[1pt]}]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Citing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compressed citations (needs to be included before multibib!)
% \RequirePackage{cite}

% Multiple bibliographies
\usepackage[backend=bibtex, defernumbers=true, maxbibnames=99, sorting=none, citestyle=numeric-comp]{biblatex}
\renewcommand*{\bibfont}{\normalfont\small}
\DeclareBibliographyCategory{own}
\DeclareBibliographyCategory{students}

\newcommand{\citeOwn}[1]{%
	\cite{#1}%
    \addtocategory{own}{#1}%
}

\newcommand{\citeStudent}[1]{%
	\cite{#1}%
	\addtocategory{students}{#1}%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Title Page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\iftype@dissertation
	\renewcommand{\maketitle}{
	\thispagestyle{empty}%
	\newgeometry{margin=2.5cm,top=-1.5cm}%top=-2.1cm
	{%
	\parindent0pt%\baselinestretch1.0%
	\begin{center}
		\includegraphics[width=9.2cm]{figures/logos/OVGU.pdf}
	\end{center}
	\sffamily%

	\vspace*{-1.8cm}%

	{\LARGE \@title}%

	\vspace*{3.5cm}%

	{\bfseries DISSERTATION}

	\vspace*{0.7cm}

	\Large zur Erlangung des akademischen Grades

	\vspace*{0.7cm}

	Doktoringenieur (Dr.-Ing.)

	\vspace*{1.5cm}

	angenommen durch die Fakultät für Informatik\\
	der Otto-von-Guericke-Universität Magdeburg

	\vspace*{1.25cm}

	von \@degree~\@author

	\vspace*{0.2cm}

	\begin{tabbing}
		\=\hspace{7.5cm}\=\hspace{5cm}\\[-\baselineskip]
		\>geb. am \@birthdate\>in \@birthplace
	\end{tabbing}

	\vspace*{0.2cm}

	Gutachterinnen/Gutachter

	\vspace*{0.4cm}

	\@reviewerA\\
	\@reviewerB\\
	\@reviewerC\\
	\@reviewerD

	\vspace*{1.75cm}

	Magdeburg, den \printfdate{shbritishdots} %shbritishdots corresponds to German date format

	}%
	\restoregeometry
	\thispagestyle{empty}
	\vspace*{\fill}
	\begin{minipage}{.95\textwidth}
		\textbf{\@author}\\
		\emph{\@title}\\
		\@thesistype, Otto von Guericke University Magdeburg \\
		Magdeburg, \printfdate{Y}.
	\end{minipage}
	\cleardoublepage
	}
	
\else
	\renewcommand{\maketitle}{
	\thispagestyle{empty}%
	\newgeometry{margin=2.5cm}%top=-2.1cm
	{%
		\parindent0pt%\baselinestretch1.0%
	
	\if@german
		\includegraphics[width=\linewidth]{figures/logos/fin-de}\vspace*{2cm}
	\else
		\includegraphics[width=\linewidth]{figures/logos/fin-en}\vspace*{2cm}
	\fi
	
	\hspace*{2.5cm}\begin{minipage}[t][0.7\textheight]{.75\linewidth}
		\huge
		\textbf{\titleheader}\\[1cm]
		\huge
		\@title\\[1cm]
		\large{\@author \\ [0.5cm] 
			\ifx\@empty\@matriculation
			\else
				\matriculationlabel \@matriculation\\
			\fi
			Magdeburg, \printfdate{shbritishdots}}\\%[4cm]
		
		~\vfill
		\large

		\supervisorlabel \@supervisor
		\ifx\@empty\@reviewerA
		\else
			\\ \proflabel \@reviewerA
		\fi
		\ifx\@empty\@reviewerB
			\\[1cm]
		\else
			\\ \secondproflabel \@reviewerB
			\\[1cm]
		\fi
	\end{minipage}

	\vfill
	\hrule
	\vspace*{0.15cm}
	\begin{minipage}{.7\linewidth}
		\small\@institution
	\end{minipage}
	\begin{minipage}{.3\linewidth}
		\raggedleft
		\instlogo
	\end{minipage}
		}%
	\restoregeometry
	\cleardoublepage
	}
\fi


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%				Selbständigkeitserklärung
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\authorshipstatement}{
	\chapter*{Statement of Authorship of the Student}
	Thesis: \@title\\[1cm]
	Name: \@author\\[1cm]
	Date of birth: \@birthdate\\[1cm]
	\matriculationlabel \@matriculation\\ [1cm]
	
	\noindent
	I herewith assure that I wrote the present thesis independently, that the thesis has not
	been partially or fully submitted as graded academic work and that I have used no other
	means than the ones indicated. I have indicated all parts of the work in which sources
	are used according to their wording or to their meaning.
	
	\noindent
	I am aware of the fact that violations of copyright can lead to injunctive relief and claims
	for damages of the author as well as a penalty by the law enforcement agency.\\ [1cm]
%\chapter*{Selbstst\"andigkeitserkl\"arung}\markboth{\textsc{Selbstst\"andigkeitserkl\"arung}}{\textsc{Selbstst\"andigkeitserkl\"arung}}
%Hiermit erkl\"are ich, dass ich die vorliegende Arbeit selbst\"andig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe.\\
Magdeburg, \@date \\ [2cm]
\dots\dots\dots\dots\dots\dots\dots\dots\dots\\
(Signature)
}