%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AMS - Style for Presentations
%%
%% Author: Benjamin Noack
%% Last Modified by: Benjamin Noack
%% Date: 2025-06-11
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Changes
% Changes 2025/06/11
% * "align=flush left" added to frametitle tikz nodes to increase the interword spacing
% Changes 2023/11/16
% * font size in footline increased / consistent with PPTX template
% * option smallfootfontsize added to decrease fontsize in footline
% Changes 2022/06/27
% * bounding box in tikzframe corrected
% * pictheight/pictwidth renamed to slideheight/slidewidth
% * custom bullet colors added
% Changes 2021/09/08
% * headline moved into footline (stays on top of slide)


%%% Identification:
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{AMSBeamer}[2025/06/11 AMS Beamer Style]

%%% Options:

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}

%% Check whether AMS logo should be included
\newif\ifAMSBeamer@AMSLogo
\AMSBeamer@AMSLogotrue
\DeclareOption{noAMSLogo}{\AMSBeamer@AMSLogofalse}

%% Check whether AMS logo should be included
\newcommand{\AMSBeamer@footfontsize}{5} %this was previously 4
\DeclareOption{smallfootfontsize}{\renewcommand{\AMSBeamer@footfontsize}{4}}

%% Check whether total of pages should be shown on page
\newif\ifAMSBeamer@numberofpages
\AMSBeamer@numberofpagesfalse
\DeclareOption{numberofslides}{\AMSBeamer@numberofpagestrue}

\ProcessOptions\relax


%% show header on slide
\newif\ifAMSBeamer@showheader
\AMSBeamer@showheadertrue

%% show footer on slide
\newif\ifAMSBeamer@showfooter
\AMSBeamer@showfootertrue

\LoadClass[aspectratio=169,10pt]{beamer}

\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\RequirePackage{xparse}

\useoutertheme{default}

%% start slide top left
\beamer@centeredfalse

\usefonttheme{professionalfonts}
\RequirePackage{lmodern}

%% define colors
\definecolor{ovgu-inf-blue}{RGB}{0 104 180}

\colorlet{AMSblue}{ovgu-inf-blue}
\definecolor{AMSred}{RGB}{194,23,20}
\definecolor{AMSgreen}{RGB}{0,120,38}
\definecolor{AMSorange}{RGB}{246,129,0}
% \definecolor{AMSorange}{RGB}{243,147,35}

%% remove navigation symbols 
\setbeamertemplate{navigation symbols}{}

%% smaller textsize in nested items
\beamertemplatedotitem

% \setbeamerfont{title}{series=\bfseries,size=\Large}
\setbeamerfont{title}{series=\bfseries,size=\Large}
\setbeamerfont{frametitle}{series=\bfseries,size=\large}
\setbeamerfont{framesubtitle}{size=\normalsize}
\setbeamerfont{author}{series=\bfseries,size=\normalsize}
\setbeamercolor{frametitle}{fg=ovgu-inf-blue}
% \setbeamercolor{frametitle}{fg=ovgu-inf-blue,bg=red}

%% set bullet color in itemized
% \setbeamercolor{itemize item}?
\setbeamercolor{item}{fg=ovgu-inf-blue}
\setbeamercolor{subitem}{fg=ovgu-inf-blue}
\setbeamercolor{subsubitem}{fg=ovgu-inf-blue}

%% manually set bullet color, e.g., \item<AMSred@1->
\newenvironment{AMSgreenenv}{\only{\setbeamercolor{itemize item}{fg=AMSgreen}\usebeamerfont{color=AMSgreen}}}{}
\newenvironment{AMSredenv}{\only{\setbeamercolor{itemize item}{fg=AMSred}}}{}
\newenvironment{AMSorangeenv}{\only{\setbeamercolor{itemize item}{fg=AMSorange}}}{}
\setbeamercolor{alerted text}{fg=AMSred}
\setbeamercolor{example text}{fg=AMSgreen}

%% content size
%% slide size is 160mm x 90mm including header and footer
%% but the content has only 160mm x 78mm
\newdimen\slidewidth% width of content
\newdimen\slideheight% height of content
\slidewidth=160mm%
\slideheight=78mm%

%% Margins left and right
% \setbeamersize{text margin left=0mm, text margin right=0mm,}
% \setlength{\textwidth}{\beamer@paperwidth}
\newlength\leftframemargin
\newlength\rightframemargin
\setlength{\leftframemargin}{\beamer@leftmargin}
\setlength{\rightframemargin}{\beamer@rightmargin}


%%% Slide formatting

%% Definition of headline
%% definition of headline is moved into footline
%% headline then stays on top of slide
\setbeamertemplate{headline}{%
	\vspace{1cm}%
    % \ifnum \theframenumber=1%
    % \else%
	% 	\begin{tikzpicture}[inner sep=0pt, outer sep=0pt]
	% 		\useasboundingbox  (0,0) rectangle (160mm,10mm);%
	% 		\path (0,0) node[anchor=south west]{%
	% 				\ifAMSBeamer@AMSLogo\includegraphics{logos/AMShead.pdf}%
	% 			\else%
	% 				\includegraphics{logos/OVGUhead.pdf}%
	% 			\fi%
	% 		};
	% 		% 5.5mm would center text vertically, but 5mm looks better
	% 		\ifAMSBeamer@AMSLogo%
	% 			\path (4mm,5mm) node[anchor=west,text width=97mm]{\usebeamercolor[fg]{frametitle}\usebeamerfont{frametitle}\strut\insertframetitle\strut\par};			
	% 		\else%
	% 			\path (4mm,5mm) node[anchor=west,text width=121mm]{\usebeamercolor[fg]{frametitle}\usebeamerfont{frametitle}\strut\insertframetitle\strut\par};
	% 		\fi%
	% 	\end{tikzpicture}
    % \fi%    
}



\def\insertframetitle{}
\setbeamertemplate{frametitle}{%
 % TODO subtitle
}

%% Definition of footer
\setbeamercolor{footlinecolor}{fg=white,bg=ovgu-inf-blue}
\setbeamertemplate{footline}{%
    \ifnum \theframenumber=1%
    \else%
	% headline (height: 10mm but blue line ends at 9mm):
		\ifAMSBeamer@showheader%
			\begin{tikzpicture}[inner sep=0pt, outer sep=0pt,overlay, remember picture,shift={($(current page.south west)+(0,-0mm)$)}]%
			\useasboundingbox  (0,0) rectangle (160mm,90mm);%
			\path (0,90mm) node[anchor=north west]{%
					\ifAMSBeamer@AMSLogo\includegraphics{logos/AMShead.pdf}%
				\else%
					\includegraphics{logos/OVGUhead.pdf}%
				\fi%
			};
			% 5.5mm would center text vertically, but 5mm looks better
			\ifAMSBeamer@AMSLogo%
				\path (4mm,85mm) node[anchor=west,text width=97mm,align=flush left]{\usebeamercolor[fg]{frametitle}\usebeamerfont{frametitle}\strut\insertframetitle\strut\par};			
			\else%
				\path (4mm,85mm) node[anchor=west,text width=121mm,align=flush left]{\usebeamercolor[fg]{frametitle}\usebeamerfont{frametitle}\strut\insertframetitle\strut\par};
			\fi%
		\end{tikzpicture}%
		\fi%
    %
	% footline (height 3mm):
		\ifbeamercolorempty[bg]{frametitle}{}{\nointerlineskip}%
		\begin{beamercolorbox}[sep=0pt,ht=0.3cm,wd=\paperwidth,leftskip=0.5cm,rightskip=0.5cm]{footlinecolor}%
		\vbox to0.3cm{\vfil\hbox{%
		\color{white}{\fontsize{\AMSBeamer@footfontsize}{7}\selectfont\bfseries{\insertshorttitle~$\vert$~\insertshortauthor}}%
		}\vfil}%
		\hfill%
		\vbox to0.3cm{\vfil\hbox{%
		\color{white}{\fontsize{\AMSBeamer@footfontsize}{7}\selectfont\bfseries{\insertframenumber%
		\ifAMSBeamer@numberofpages/\inserttotalframenumber\fi}}%
		}\vfil}%
		\end{beamercolorbox}
    \fi%    
}

%% Definition of title page
% \setbeamertemplate{title page}{%
%     \setbeamertemplate{footline}{} 
% 	\begin{textblock*}{\paperwidth}[0.5,0.5](0.5\paperwidth,0.5\paperheight)%	
% 		\begin{center}
% 			{\usebeamercolor[fg]{frametitle}\usebeamerfont{title}\inserttitle\par}%
% 			\vspace*{0.5ex}%
% 			\usebeamerfont{subtitle}\insertsubtitle\par%
% 			\bigskip%
% 			\usebeamerfont{author}\insertauthor\par%
% 			\bigskip%
% 			\usebeamerfont{institute}\insertinstitute\par%
% 			\vspace*{1ex}%
% 			\usebeamerfont{date}\insertdate\par%
% 		\end{center}
% 	\end{textblock*}%
% 	\begin{textblock*}{3.3cm}[0,1](11cm,8cm)%
% 		\includegraphics[height=1.4cm]{logos/Signet_INF_1}%
% 	\end{textblock*}%

% 	\begin{textblock*}{3.3cm}[1,1](15cm,8cm)%
% 		\raggedleft%
% 		\includegraphics[height=1.3cm]{logos/AMS}%
% 	\end{textblock*}%
% }

\newlength\title@tlsep%
\setlength\title@tlsep{5mm}%
\newlength\title@titlemargin%
\setlength\title@titlemargin{14mm}%
\newlength\title@institutemargin%
\setlength\title@institutemargin\title@titlemargin%
\setbeamertemplate{title page}{%
    \setbeamertemplate{footline}{} 
	\begin{tikzpicture}[overlay, remember picture, shift={(current page.south west)}, inner sep=0pt, outer sep=0pt]% shift to lower left corner and 3mm (footline) upwards
		\useasboundingbox (0,0) rectangle (160mm,90mm);%
		\fill[ovgu-inf-blue] (0,90mm) rectangle (160mm,55mm);
		\node[anchor=north east] at (160mm,90mm) {\includegraphics{logos/otto.pdf}};
		\node[anchor=north west] at (\title@titlemargin,87mm) {\includegraphics[height=11mm]{logos/Signet_INF_1_inv.pdf}};	
		%132mm
		\node[anchor=south west, text width=160mm-2\title@titlemargin] at (\title@titlemargin,55mm+\title@tlsep) {\color{white}\usebeamerfont{title}\inserttitle\par%
		\ifx\insertsubtitle\empty\else\medskip\color{white}\usebeamerfont{subtitle}\insertsubtitle\fi};	
		\node[anchor=north west, text width=160mm-2\title@institutemargin] at (\title@institutemargin,55mm-\title@tlsep) {%
			% \usebeamerfont{subtitle}\insertsubtitle\par%
			% \vspace*{4ex}%
			{\usebeamerfont{author}\insertauthor\par}%
			\vspace*{\title@tlsep}%
			\usebeamerfont{institute}\insertinstitute\par%
			\vspace*{\title@tlsep}%
			\usebeamerfont{date}\insertdate\par%
		};	
		\ifAMSBeamer@AMSLogo%
			\node[anchor=south east] at (150mm,7mm) {\includegraphics[width=50mm]{logos/AMS.pdf}};%
		\fi
		% \makegrid		
	\end{tikzpicture}
}

%% Section slide
\newcommand*{\sectionslide}[2][]%
{%
\AMSBeamer@showheaderfalse%
\begin{frame}
	\begin{tikzframe}
		\path (1.3,4.2) node[anchor=south west, font=\large]{#2};
		\path (1.3,3.7) node[anchor=north west, text width=\slidewidth-1.3, font=\Large\bfseries\color{AMSblue}]{\ifx &#1& \inserttitle\else #1\fi};
	\end{tikzframe}
\end{frame}
\AMSBeamer@showheadertrue%
}


%% half-transparent pause
\setbeamercovered{transparent=45}

%% Use serifs in equations
\usefonttheme[onlymath]{serif}

%% remove margin
\RequirePackage{changepage}
\newenvironment{nomargin}{
	\begin{adjustwidth}{-\leftmargin}{-\rightmargin}%
}{%
	\end{adjustwidth}%
}

%% SI units
\RequirePackage{siunitx}


%% TikZ frame for absolute positioning:
%% always at the same position
%% no inner and outer sep of nodes
%% default value of inner sep is: inner sep=0.3333em
\def\innersep{0.3333em}
\newenvironment{tikzframe}{%
	\begin{tikzpicture}[overlay, remember picture, shift={($(current page.south west)+(0,3mm)$)}, inner sep=0pt, outer sep=0pt]% shift to lower left corner and 3mm (footline) upwards
		\useasboundingbox (0,0) rectangle (\slidewidth,\slideheight);%	
}{%
	\end{tikzpicture}
}

%% Grid for use in TikZ frame
\newcommand{\makegrid}{%
	\draw[style=help lines,step=0.1,opacity=0.2] (0,0) grid (\slidewidth,\slideheight);
	\draw[very thin,step=1,opacity=0.2] (0,0) grid (\slidewidth,\slideheight);
	\foreach \y in {1,2,...,7}
	{
		\draw (2,\y) node[left,gray,opacity=0.5]{\color{gray}\y};
	}
	\foreach \x in {1,2,...,15}
	{
		\draw (\x,5) node[below,gray,opacity=0.5]{\color{gray}\x};
	}
}%

%% Grid for use with textpos
\newcommand{\makegridtp}{%
	\begin{tikzframe}
		\draw[style=help lines,step=0.1,opacity=0.2] (0,0) grid (\slidewidth,\slideheight);
		\draw[very thin,step=1,opacity=0.2,yshift=-3mm] (0,0) grid (\slidewidth,\slideheight+3mm);
		\foreach \y in {1,2,...,8}
		{
			\draw (2, 87mm - \y cm) node[left,gray,opacity=0.5]{\color{gray}\y};
		}
		\foreach \x in {1,2,...,15}
		{
			\draw (\x,5) node[below,gray,opacity=0.5]{\color{gray}\x};
		}
	\end{tikzframe}		
}%



%%% Helpers
%% Show number of slides consisting of multiple frames
%% can be used outsize tikzframe
\newcommand{\overlaynumber}{%
\begin{tikzpicture}[overlay, remember picture, shift={($(current page.north west)+(0,-2mm)$)}, inner sep=0pt, outer sep=0pt]%
	\path (0,0) node[anchor=north west, inner sep=0pt]{\number\beamer@slideinframe};
\end{tikzpicture}%
}

%% Todo Notes box in upper right corner
\newcommand{\Notes}[1]{%
\begin{tikzpicture}[overlay, remember picture, shift={($(current page.north east)+(-1mm,-10mm)$)}, inner sep=0pt, outer sep=0pt]%
	\path (0,0) node[anchor=north east, inner sep=0pt, draw=red!50!black,thick, fill=white, text width=5cm,rounded corners=1mm,inner sep=2mm,font=\small]{\tiny #1};
\end{tikzpicture}%
}