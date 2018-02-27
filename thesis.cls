% 
%% This is file `thesis.cls', for use at Rensselaer Polytechnic Institute.
%% It is based on the standard LaTeX report class.
%% Originally written by Harriet Borton (ITS), April 1996.
%% Modified April 11, 1996; minor revisions February, 2001.
%% 
%% On RCS, template files for preparing a thesis are in the directory
%% /campus/doc/text/Latex2e/Thesis
%% 
%% This file is part of the LaTeX2e system. 
%% ---------------------------------------- 
%% 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesis}[2002/10/27 Stephen Fegan]
%  Note that the setspace package is built in (code included near the end of 
%  this file) to provide "line-and-a half spacing" (1.4 by default) and also
%  the singlespace environment. 

% RPI option chap:
\newif\ifchap  % true for chap option
  \chapfalse   % false by default
\DeclareOption{chap}{\chaptrue} % option to print "Chapter" at each new chapter
\newcommand\docsize{}  % to allow 10pt or 11pt to be specified as option
\DeclareOption{10pt}{\renewcommand\docsize{10pt}}
\DeclareOption{11pt}{\renewcommand\docsize{11pt}}
\DeclareOption{12pt}{\renewcommand\docsize{12pt}}
%  Prepare to load the standard report class (12pt):
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\def\@optionloadnatbib{}
\DeclareOption{natbib}{\def\@optionloadnatbib{\usepackage[round]{natbib}}}
\ExecuteOptions{12pt}         % define 12pt as the default doc size
\ProcessOptions
\LoadClass[\docsize]{report}  % load report.cls

\@optionloadnatbib

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@autoschapterhead \@autoschapterheadfalse
\newif\if@autoschaptercontinued \@autoschaptercontinuedfalse
\def\@autoschaptertitle{}
\def\@autoschaptercontinuedtitle{}
\def\setautoschapter#1#2{\gdef\@autoschaptertitle{#1}%
  \gdef\@autoschaptercontinuedtitle{#2}%
  \global\@autoschapterheadtrue\global\@autoschaptercontinuedfalse\mark{0}%
}
\def\clearautoschapter{\mark{1}}

\def\@outputpage{%
\begingroup           % the \endgroup is put in by \aftergroup
  \let \protect \noexpand
  \@resetactivechars
  \@parboxrestore
  \shipout \vbox{%
    \set@typeset@protect
    \aftergroup \endgroup
    \aftergroup \set@typeset@protect
                                % correct? or just restore by ending
                                % the group?
  \if@specialpage
    \global\@specialpagefalse\@nameuse{ps@\@specialstyle}%
  \fi
  \if@twoside
    \ifodd\count\z@ \let\@thehead\@oddhead \let\@thefoot\@oddfoot
         \let\@themargin\oddsidemargin
    \else \let\@thehead\@evenhead
       \let\@thefoot\@evenfoot \let\@themargin\evensidemargin
    \fi
  \fi
  \reset@font
  \normalsize
  \normalsfcodes
  \let\label\@gobble
  \let\index\@gobble
  \let\glossary\@gobble
  \baselineskip\z@skip \lineskip\z@skip \lineskiplimit\z@
    \@begindvi
    \vskip \topmargin
    \moveright\@themargin \vbox {%
      \setbox\@tempboxa \vbox to\headheight{%
        \vfil
        \color@hbox
          \normalcolor
          \hb@xt@\textwidth{\@thehead}%
        \color@endbox
        }%                        %% 22 Feb 87
      \dp\@tempboxa \z@
      \box\@tempboxa
      \vskip \headsep
      \if@autoschapterhead
        \if@autoschaptercontinued
          \vbox {\vskip 19pt\chapter*{\@autoschaptercontinuedtitle}\vskip 22pt}
        \else
          \global\@autoschaptercontinuedtrue
%          \vbox {\vskip 19pt \chapter*{\@autoschaptertitle}\vskip 22pt}
        \fi
%        \typeout{Mark\space\topmark\space\botmark}
        \expandafter\ifx\botmark1
%          \typeout{Mark found}
          \global\@autoschapterheadfalse
        \fi
      \fi
      \box\@outputbox
      \baselineskip \footskip
      \color@hbox
        \normalcolor
        \hb@xt@\textwidth{\@thefoot}%
      \color@endbox
      }%
    }%
  \global\let\if@newlist\@@if@newlist
  \global \@colht \textheight
  \stepcounter{page}%
  \let\firstmark\botmark
}


%  The following sections are revisions or additions to report.cls
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FOOTNOTES:   make them continuously numbered throughout document
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% define command that can undo having footnotes reset with each chapter:
% (taken from removefr.sty by Donald Arseneau) 
\def\@removefromreset#1#2{\let\@tempb\@elt
   \expandafter\let\expandafter\@tempa\csname c@#1\endcsname
   \def\@elt##1{\expandafter\ifx\csname c@##1\endcsname\@tempa\else
         \noexpand\@elt{##1}\fi}%
   \expandafter\edef\csname cl@#2\endcsname{\csname cl@#2\endcsname}%
   \let\@elt\@tempb}
% use the command \@removefromreset to undo the \@addtoreset in report.cls:
\@removefromreset{footnote}{chapter}
%
% define command to allow people to reset footnote counter at will: 
\def\resetfootnote{\setcounter{footnote}{0}}  % definition to reset footnote


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PAGE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SIDE MARGINS:

\newlength{\thesistopmargin}
\newlength{\thesisbottommargin}
\newlength{\thesisleftmargin}
\newlength{\thesisrightmargin}
\setlength{\thesistopmargin}{1.5in}
\setlength{\thesisbottommargin}{1in}
\setlength{\thesisleftmargin}{1.5in}
\setlength{\thesisrightmargin}{1.0in}

\setlength{\headheight}{14pt}
\setlength{\headsep}{0.5in}
\addtolength{\headsep}{-\headheight}

\setlength{\topskip}{0in}
\setlength{\footskip}{30pt}

\setlength{\topmargin}{-1in}
\addtolength{\topmargin}{\thesistopmargin}
\addtolength{\topmargin}{-\headsep}
\addtolength{\topmargin}{-\headheight}

\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-\thesistopmargin}
\addtolength{\textheight}{-\thesisbottommargin}

\setlength{\evensidemargin}{-1in}
\addtolength{\evensidemargin}{\thesisrightmargin}
\setlength{\oddsidemargin}{-1in}
\addtolength{\oddsidemargin}{\thesisleftmargin}
%\setlength{\oddsidemargin}{\evensidemargin}

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-\thesisleftmargin}
\addtolength{\textwidth}{-\thesisrightmargin}

%\if@twoside                 % Values for two-sided printing:
%   \oddsidemargin .55in     %   Left margin on odd-numbered pages.
%   \evensidemargin .05in    %   Left margin on even-numbered pages.
%   \marginparwidth 40pt     %   Width of marginal notes.
%\else                       % Values for one-sided printing:
%   \oddsidemargin 0.55in    %   Note that \oddsidemargin = \evensidemargin
%   \evensidemargin 0.55in
%   \marginparwidth 40pt
%\fi
%\marginparsep 10pt          % Horizontal space between outer margin and
                            % marginal note
%\textwidth 5.9in            % width of text

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            SECTION HEADINGS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newcommand\chaptersize{\large}
\newcommand\sectionsize{\large}
\newcommand\subsectionsize{\normalsize}
\newcommand\subsubsectionsize{\normalsize}
\newcounter{firstchapter}
\setcounter{firstchapter}{0}

\setcounter{secnumdepth}{3}    % Number subsubsections in the chapters
\setcounter{tocdepth}{3}       % Put subsubsections in the table of contents

% Print "CHAPTER" if chap option is specified:
\ifchap
  \renewcommand\@chapapp{\chaptername}
\else
  \renewcommand\@chapapp{}
\fi

\newif\if@chaptoc \@chaptocfalse

\def\specialhead#1{%   GENERAL HEADING WITHOUT A NUMBER (for abstract, etc.)
     \chapter*{\centering #1 \@mkboth{#1}{#1}}
     \addcontentsline{toc}{chapter}{#1}}

\def\@chapter[#1]#2{\ifnum\c@firstchapter=0%    % start of rpi added stuff
%                      \if@twoside\cleardoublepage\suppressfloats[t]\fi%
%                      \pagenumbering{arabic}
                      \setcounter{firstchapter}{1}%
                    \fi%
                    \renewcommand{\thepage}{\arabic{page}}%
                    \thispagestyle{topright}%
                    \pagestyle{topright}%      % end of rpi added stuff
                    \edef\@temptitleuc{\uppercase{#1}}
                    \ifnum \c@secnumdepth >\m@ne%
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
		    \if@chaptoc%
			  \addcontentsline{toc}{chapter}%
                                   {\protect\uppercase{\@chapapp\space\thechapter.}\space\@temptitleuc}%                         
		    \else%
                         \addcontentsline{toc}{chapter}%
                                   {\protect\numberline{\thechapter.}\@temptitleuc}%
                    \fi%
                    \else%
                      \addcontentsline{toc}{chapter}{\@temptitleuc}%
                    \fi%
                    \chaptermark{\@temptitleuc}% 
%                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
%                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn%
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else%
                      \@makechapterhead{#2}%
                      \@afterheading%
                    \fi}

\def\@schapter#1{\if@twocolumn%
                   \@topnewpage[\@makeschapterhead{#1}]%
                 \else%
                   \@makeschapterhead{#1}%
                   \@afterheading%
                 \fi%
                 \thispagestyle{topright}%
                 \pagestyle{topright}}

\def\@makechapterhead#1{%
  \edef\@temptitleuc{\uppercase{#1}}%
  \vspace*{0\p@}%
  {\parindent \z@ \raggedright \centering \normalfont \chaptersize%
    \ifnum \c@secnumdepth >\m@ne%
      \ifchap%
         \bfseries \@chapapp{} \thechapter    % print "Chapter" and number
         \vskip -3pt%           %\par\nobreak (original)
       \else%
         \bfseries \thechapter.
       \fi%
    \fi%
    \interlinepenalty\@M%
    \bfseries \@temptitleuc\par\nobreak%
    \vskip 15\p@%
  }}

\def\@makeschapterhead#1{%    heading for chapter* command (no numbering)
  \edef\@temptitleuc{\uppercase{#1}}%
  \vspace*{0\p@}%
  {\parindent \z@ \raggedright \centering%
    \normalfont  \chaptersize%
    \interlinepenalty\@M%
    \bfseries \@temptitleuc\par\nobreak%
    \vskip 15\p@%
  }}

\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {3.5ex \@plus 1ex \@minus .2ex}%
                                   {.5ex \@plus .3ex}%{1.4ex \@plus.2ex}%
                                   {\normalfont\sectionsize\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.3ex \@plus .2ex}%{1.2ex \@plus .2ex}%
                                     {\normalfont\subsectionsize\bfseries}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {3.25ex\@plus 1ex \@minus .2ex}%
                                     {.2ex \@plus .1ex}%{1ex \@plus .2ex}%
                                     {\normalfont\subsubsectionsize\bfseries}}
% \paragraph and \subparagraph headings unchanged from report.cls.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  APPENDIX
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\appendix{\par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \chaptrue
  \@chaptoctrue
  \renewcommand\@chapapp{\appendixname}%
  \renewcommand\thechapter{\@Alph\c@chapter}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FIGURES and TABLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%control float placement:
%
\setcounter{topnumber}{2}
\renewcommand\topfraction{.8}
\setcounter{bottomnumber}{2}
\renewcommand\bottomfraction{.8}
\setcounter{totalnumber}{4}
\renewcommand\textfraction{.2}
\renewcommand\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.8}
\renewcommand\dblfloatpagefraction{.5}

\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\boldmath\bfseries#1:~~#2}%   Make caption bold
  \ifdim \wd\@tempboxa >\hsize
   {\boldmath\bfseries #1:~~#2}\par%            Make caption bold
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  TABLE of CONTENTS,  LIST OF TABLES,  LIST OF FIGURES 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\@toctitle{}
\newlength{\@oldtextheight}

\def\@starttoc#1{%
  \begingroup%
    \chapter*{\@toctitle}
    \setlength{\@oldtextheight}{\textheight}%
    \addtolength{\textheight}{-76pt}%
%    \enlargethispage{-76pt}
    \edef\@temptitleuc{\uppercase{\@toctitle}}%
    \addcontentsline{toc}{chapter}{\@temptitleuc}%
    \setautoschapter{\@toctitle}{\@toctitle\ -- continued}%
    \makeatletter%
    \@input{\jobname.#1}%
    \if@filesw%
      \expandafter\newwrite\csname tf@#1\endcsname%
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax%
    \fi%
    \@nobreakfalse%
    \setlength{\textheight}{\@oldtextheight}%
    \clearautoschapter%
    \clearpage
  \endgroup}

% Quiet version that does not put entry in TOC
\def\@starttocqt#1{%
  \begingroup%
    \chapter*{\@toctitle}
    \setlength{\@oldtextheight}{\textheight}%
    \addtolength{\textheight}{-76pt}%
%    \enlargethispage{-76pt}
    \edef\@temptitleuc{\uppercase{\@toctitle}}%
    \setautoschapter{\@toctitle}{\@toctitle\ -- continued}%
    \makeatletter%
    \@input{\jobname.#1}%
    \if@filesw%
      \expandafter\newwrite\csname tf@#1\endcsname%
      \immediate\openout \csname tf@#1\endcsname \jobname.#1\relax%
    \fi%
    \@nobreakfalse%
    \setlength{\textheight}{\@oldtextheight}%
    \clearautoschapter%
    \clearpage
  \endgroup}

\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \def\@toctitle{\contentsname}
    \vskip -1em \begin{singlespace}      % singlespacing
    \@starttocqt{toc}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }
 
\renewcommand*\l@chapter{\pagebreak[3]\vskip 10pt plus 1pt minus 1pt
                         \@dottedtocline{0}{0em}{1.4em}}
\renewcommand*\l@section{\vskip 6pt plus 1pt minus 1pt
                         \@dottedtocline{1}{1.5em}{2.3em}}
\renewcommand*\l@subsection{\ifnum\c@tocdepth>1\vskip 4pt minus 1pt \fi
                         \@dottedtocline{2}{3.8em}{3.2em}}
\renewcommand*\l@subsubsection{\ifnum\c@tocdepth>2 \vskip 3pt minus 1pt \fi
                         \@dottedtocline{3}{7.0em}{4.1em}}

% The following removed because it's not consistent with entries from longtable
%% modify the definition below (taken from latex.ltx) to include 
%% "Table" and "Figure" in entries for lot and lof: 
%\long\def\@caption#1[#2]#3{%\baselineskip 14.5 pt
%  \addcontentsline{\csname ext@#1\endcsname}{#1}%
%  {\protect\numberline{\csname fnum@#1\endcsname}{\ignorespaces #2}}%
%  \begingroup
%    \@parboxrestore
%    \normalsize
%    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
%  \endgroup}
 
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \def\@toctitle{\listfigurename}
    \vskip -1em \begin{singlespace}  % singlespacing
    \thispagestyle{topright}
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }

\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \def\@toctitle{\listtablename}
    \vskip -1em \begin{singlespace}  % singlespacing
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \end{singlespace}
    }

%remove following at same time as remove code to put "Figure" in LOF
%\renewcommand*\l@figure{\vskip 10pt plus 1pt minus 1pt
%                       \@dottedtocline{1}{0em}{5.8em}}
 
\renewcommand*\l@figure{\vskip 10pt plus 1pt minus 1pt
                       \@dottedtocline{1}{0em}{2.8em}}
\let\l@table\l@figure

\let\rpicaption\caption
\let\lrpicaption\caption


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  BIBLIOGRAPHY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RPI def: for use in making an unnumbered bibliography with hanging indents
\def\bibentry{\vskip10pt\par\noindent\hangindent=40pt\frenchspacing}

% report definition modified for no automatic heading and use ragged right
\newcommand{\bibalign}{\raggedright}


\@ifpackageloaded{natbib}
{\renewenvironment{thebibliography}[1]{%
      \edef\@temptitleuc{\uppercase{\bibname}}%
      \chapter*{\bibname}\vspace*{-18pt}%
      \addcontentsline{toc}{chapter}{\@temptitleuc}%
      \begin{singlespace}%
   \parindent \z@\bibpreamble\bibfont\list
   {\@biblabel{\arabic{NAT@ctr}}}{\@bibsetup{#1}%
    \setcounter{NAT@ctr}{0}}%
    \ifNAT@openbib
      \renewcommand\newblock{\par}
    \else
      \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
    \fi
    \sloppy\clubpenalty4000\widowpenalty4000
    \sfcode`\.=1000\relax
    \let\citeN\cite \let\shortcite\cite
    \let\citeasnoun\cite
 }{\def\@noitemerr{%
  \PackageWarning{natbib}
     {Empty `thebibliography' environment}}%
  \endlist\vskip-\lastskip\end{singlespace}}}%
{\renewenvironment{thebibliography}[1]
     {\edef\@temptitleuc{\uppercase{\bibname}}%
      \chapter*{\bibname}%
      \addcontentsline{toc}{chapter}{\@temptitleuc}
      \begin{singlespace}
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy
      \clubpenalty4000
      \@clubpenalty \clubpenalty
      \widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist\end{singlespace}}}



%\renewenvironment{thebibliography}[1]
%     {\bibalign\frenchspacing
%      \list{\@biblabel{\@arabic\c@enumiv}}%
%           {\settowidth\labelwidth{\@biblabel{#1}}%
%            \leftmargin\labelwidth
%            \advance\leftmargin\labelsep
%            \@openbib@code
%            \usecounter{enumiv}%
%            \let\p@enumiv\@empty
%            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
%      \sloppy\clubpenalty4000\widowpenalty4000%
%      \sfcode`\.=\@m}
%     {\def\@noitemerr
%       {\@latex@warning{Empty `thebibliography' environment}}%
%      \endlist}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  FOR RPI TITLEPAGE, ABSTR. TITLEPAGE & COPYRIGHT PAGE 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 \def\thesistitle#1{\gdef\@thesistitle{#1}}
 \def\author#1{\gdef\@author{#1}}
 \def\degree#1{\gdef\@degree{#1}}
 \def\department#1{\gdef\@department{#1}}
 \def\major#1{\gdef\@major{#1}}
 \newcount\numcomm \numcomm=1
 \def\signaturelines#1{\numcomm=#1}
 \def\thadviser#1{\gdef\@thadviser{#1}} 
 \def\projadviser#1{\gdef\@projadviser{#1}} \projadviser{*}
 \def\cothadviser#1{\gdef\@cothadviser{#1}} \cothadviser{*} 
 \def\coprojadviser#1{\gdef\@coprojadviser{#1}} \coprojadviser{*}
 \def\doctype{\if \@projadviser *Dissertation \else Project \fi}
 \def\adviser{\if \@projadviser *\@thadviser \else \@projadviser\fi}
 \def\coadviser{\if \@coprojadviser *\@cothadviser\else \@coprojadviser\fi}
 \def\memberone#1{\gdef\@memberone{#1}}
 \def\membertwo#1{\gdef\@membertwo{#1}}
 \def\memberthree#1{\gdef\@memberthree{#1}}
 \def\memberfour#1{\gdef\@memberfour{#1}}
 \def\memberfive#1{\gdef\@memberfive{#1}}
 \def\membersix#1{\gdef\@membersix{#1}}
 \def\copyrightyear#1{\gdef\@copyrightyear{#1}} \copyrightyear{\the\year}
 \def\submitdate#1{\gdef\@submitdate{#1}}

\newcount\numcount
\def\sigblock{
   \ifnum\numcomm < 3  % master's thesis or project
     \vskip .8in plus 24pt minus 24pt
     \if \coadviser *  % no coadviser
       \leftline{Approved: \hfil}\vskip 48pt
       \hrule width2.8in\hfil \vskip -3pt
       \leftline{\adviser \hfil}
       \leftline{\doctype Adviser \hfil}
       \vskip 6pt 
     \else
       \leftline{Approved: \hfil}\vskip 48pt
       \hrule width2.8in\hfil \vskip -3pt
       \leftline{\adviser, \doctype Adviser\hfil}
%      \leftline{\adviser, Co-\doctype Adviser\hfil}   % this puts in "Co"
       \vskip 36pt  \hrule width 2.8in\hfil \vskip -3pt
       \leftline{\coadviser, \doctype Adviser\hfil}
%      \leftline{\coadviser, Co-\doctype Adviser\hfil} % this puts in "Co"
       \vskip 6pt       
     \fi
   \else  % PhD thesis
      \numcount=\numcomm
      \leftline{Approved by the\hfil}
      \leftline{Examining Committee:\hfil}
      \vskip 28pt \vfil 
      \hrule width 2.8in \hfil \vskip -3pt
      \leftline{\adviser, \doctype Adviser\hfil} 
%     \leftline{\adviser, Co-\doctype Adviser\hfil} % put "Co-" in the line
      \advance \numcount by -1
      \if \coadviser * \else % there's a co-adviser
        \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
        \leftline{\coadviser, \doctype Adviser\hfil}
%       \leftline{\coadviser, Co-\doctype Adviser\hfil} % put "Co-" in the line
        \advance \numcount by -1
      \fi
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberone, Member\hfil}
      \advance \numcount by -1
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@membertwo, Member\hfil}
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberthree, Member\hfil}  \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberfour, Member\hfil}   \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@memberfive, Member\hfil}  \fi
      \advance \numcount by -1 \ifnum\numcount > 0
      \vskip 19pt\vfil\hrule width 2.8in\hfil\vskip -3pt
      \leftline{\@membersix, Member\hfil} \fi
      \fi} 

 \def\titlepage{%
     \thispagestyle{empty}
     \ifnum\numcomm<3 \vglue .5in\vfil \fi  % masters
     \ifnum\numcomm>5 \hbox{ } \vspace{-24pt}\fi % make more space on page
     \begin{singlespace}
     \begin{center}
         \parindent=0pt
         \vspace*{1in}
         {\large\MakeUppercase{\expandafter{\@thesistitle}}}\\ [12pt]
         By \\ [12pt]
         \@author \\
         \vspace*{1in}
         \vspace*{\fill}
	 \rule{2in}{0.5pt} \\
         \vspace*{\fill}
         A \doctype Submitted to the Faculty of the \\[12pt]
         \MakeUppercase{\expandafter{\@department}} \\[12pt]
         In Partial Fulfillment of the Requirements \\ 
         For the Degree of \\ [12pt]
         \MakeUppercase{\expandafter{\@degree}}\\[12pt]
%         WITH A MAJOR IN \MakeUppercase{\expandafter{\@major}}\\ [12pt]
         In the Graduate College \\[12pt]
         THE UNIVERSITY OF ARIZONA\\
         \vspace*{\fill}
         \@submitdate
     \end{center}
     \end{singlespace}
     \newpage
     \pagestyle{topright}
     \pagenumbering{arabic}
     \setcounter{page}{2}}

\renewenvironment{abstract}{%
    \edef\@temptitleuc{\uppercase{\abstractname}}
    \chapter*{\abstractname}
    \addcontentsline{toc}{chapter}{\@temptitleuc}
    \begin{doublespace}}
    {\end{doublespace}}

\def\approvalpage{
    \thispagestyle{topright}
    \@makeschapterhead{Approval form}
    \sigblock
    \newpage}

\def\statementpage{
    \thispagestyle{topright}
    \vspace*{1in}
    \@makeschapterhead{Statement by author}
    \vspace*{12pt}

    This dissertation has been submitted in partial fulfillment of
    requirements for an advanced degree at The University of
    Arizona and is deposited in the University Library to be
    made available to borrowers under rules of the Library.

    Brief quotations from this thesis are allowable without
    special permission, provided that accurate acknowledgment of
    source is made.  Requests for permission for extended
    quotation from or reproduction of this manuscript in whole
    or in part may be granted by the head of the major
    department or the Dean of the Graduate College when in his
    or her judgment the proposed use of the material is in the
    interests of scholarship.  In all other instances, however,
    permission must be obtained from the author.
    \newpage}
 
\def\copyrightpage{
    \hbox{ }
    \vfill
    \begin{center}
    \copyright\ Copyright \@copyrightyear \\
    by \\
    \@author \\
    All Rights Reserved \\ [12pt]
    \end{center}
    \clearpage}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The CODE FROM SETSPACE.STY:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\setspace@size{%
  \ifx \@currsize \normalsize
    \@normalsize
  \else
    \@currsize
  \fi
}

\def\doublespacing{%
  \ifcase \@ptsize \relax % 10pt
    \def \baselinestretch {1.667}%
  \or % 11pt
    \def \baselinestretch {1.618}%
  \or % 12pt
    \def \baselinestretch {1.655}%
  \fi
  \setspace@size
}

\def\onehalfspacing{%
  \ifcase \@ptsize \relax % 10pt
    \def \baselinestretch {1.25}%
  \or % 11pt
    \def \baselinestretch {1.213}%
  \or % 12pt
    \def \baselinestretch {1.241}%
  \fi
  \setspace@size
}

\def\singlespacing{%
  \def \baselinestretch {1}%
  \setspace@size
  \vskip \baselineskip  % Correction for coming into singlespace
}

\def\setstretch#1{%
  \renewcommand{\baselinestretch}{#1}}

%---Stretch the baseline BEFORE calculating the strut size. This improves
%   spacing below tabular environments etc., probably...
%   Comments are welcomed.

\def\@setsize#1#2#3#4{%
  % Modified 1993.04.07--GDG per KPC
  \@nomath#1%
  \let\@currsize#1%
  \baselineskip #2%
  \baselineskip \baselinestretch\baselineskip
  \parskip \baselinestretch\parskip
  \setbox\strutbox \hbox{%
    \vrule height.7\baselineskip depth.3\baselineskip width\z@}%
  \skip\footins \baselinestretch\skip\footins
  \normalbaselineskip\baselineskip#3#4}

%---Increase the space between last line of text and footnote rule.
%\skip\footins 20pt plus4pt minus4pt

%---Reset baselinestretch within floats and footnotes.

% GT:  This is where the conflict with the combination of the color
% package and the figure environment used to occur.

\let\latex@xfloat=\@xfloat
\def\@xfloat #1[#2]{%
  \latex@xfloat #1[#2]%
  \def \baselinestretch {1}\@normalsize  %%  GT: need \@normalsize?
  \normalsize
}

\def\ps@topright{\let\@mkboth\@gobbletwo
    \def\@oddhead{\rm\hfil\thepage}\let\@evenhead\@oddhead
    \def\@evenfoot{}\def\@oddfoot{}}

\long\def\@footnotetext#1{%
  \insert\footins{%
    \def\baselinestretch {1}%
    \reset@font\footnotesize
    \interlinepenalty\interfootnotelinepenalty
    \splittopskip\footnotesep
    \splitmaxdepth \dp\strutbox \floatingpenalty \@MM
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@footnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
        \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
    \color@endgroup}}

\long\def\@mpfootnotetext#1{%
  \global\setbox\@mpfootins\vbox{%
    \unvbox \@mpfootins
    \def\baselinestretch {1}%
    \reset@font\footnotesize
    \hsize\columnwidth
    \@parboxrestore
    \protected@edef\@currentlabel{%
      \csname p@mpfootnote\endcsname\@thefnmark}%
    \color@begingroup
      \@makefntext{%
       \rule\z@\footnotesep\ignorespaces#1\@finalstrut\strutbox}%
   \color@endgroup}}

% A single spaced quote (say) is done by surrounding singlespace with quote.
%
\def\singlespace{%
  \vskip \baselineskip
  \def\baselinestretch {1}%
  \setspace@size
  \vskip -\baselineskip
}

\def\endsinglespace{\par}

%  spacing, doublespace and onehalfspace all are meant to INCREASE the
%  spacing (i.e. calling onehalfspace from within doublespace will not
%  produce a graceful transition between spacings)
%
% Next two definitions fixed for consistency with TeX 3.x

\def\spacing#1{%
  \par
  \begingroup             % moved from \endspacing by PGBR 29-1-91
    \def\baselinestretch {#1}%
    \setspace@size
}

\def\endspacing{%
    \par
    \vskip \parskip
    \vskip \baselineskip
  \endgroup
  \vskip -\parskip
  \vskip -\baselineskip
}

% one and a half spacing is 1.5 x pt size
\def\onehalfspace{%
  \ifcase \@ptsize \relax  % 10pt
    \spacing{1.25}%
  \or % 11pt
    \spacing{1.213}%
  \or % 12pt
    \spacing{1.241}%
  \fi
}

\let\endonehalfspace=\endspacing

% double spacing is 2 x pt size
\def\doublespace{%
  \ifcase \@ptsize \relax % 10pt
    \spacing{1.667}%
  \or % 11pt
    \spacing{1.618}%
  \or % 12pt
    \spacing{1.655}%
  \fi
}

\let\enddoublespace=\endspacing

% GT:  EMSH chose to omit display math part that follows.
% She wrote (see above) that the "altered spacing before and after displayed
% equations ... just looked too much".
%
% Fix up spacing before and after displayed math
% (arraystretch seems to do a fine job for inside LaTeX displayed math,
% since array and eqnarray seem to be affected as expected).
% Changing \baselinestretch and doing a font change also works if done here,
% but then you have to change @setsize to remove the call to @nomath)
%
\everydisplay\expandafter{%
  \the\everydisplay
  \abovedisplayskip \baselinestretch\abovedisplayskip
  \belowdisplayskip \abovedisplayskip
  \abovedisplayshortskip \baselinestretch\abovedisplayshortskip
  \belowdisplayshortskip \baselinestretch\belowdisplayshortskip
}
%%%%%%%%%%%%%%%%%%%%%%  End of setspace.sty %%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SOME INITIALIZATIONS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make the following names uppercase:
\renewcommand\contentsname{Table of Contents}
\renewcommand\listfigurename{List of figures}
\renewcommand\listtablename{List of tables}
\renewcommand\bibname{References}
\renewcommand\indexname{Index}
\renewcommand\partname{Part}
\renewcommand\chaptername{Chapter}
\renewcommand\appendixname{APPENDIX}
\renewcommand\abstractname{Abstract}

\renewcommand\chaptersize{\large}
\renewcommand\sectionsize{\large}
\renewcommand\subsectionsize{\normalsize}
\renewcommand\subsubsectionsize{\normalsize}

\raggedbottom

\setstretch{1.4}        % at 11 or 12pt this is line-and-a-half spacing
\parindent .4in         % Width of paragraph indentation

\markboth{}{}           % Do not include chapter titles in headers;
\pagestyle{topright}  % include just page numbers in upper right

\endinput
%% 
%% End of file `thesis.cls'.
