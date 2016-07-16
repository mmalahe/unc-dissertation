%% This is a class file for dissertations and theses at the University of North Carolina at Chapel Hill
%% (specifically, for the Department of Mathematics). This version is `unc_dissertation.cls', based on `jakeuncdiss.cls', based on 
%% `pikeuncdiss.cls'. Previous revisions by those listed below.
%%
%% It is based on the report class, from LaTeX v2.1 (LaTeX 2e).
%%
%% Please do not change this file without renaming it first.
%%
%%
%% Last Modified November, 2013 by Jake Fowler
%%				       July, 2010 by Brian Pike
%%				       April, 2007 by Liz Bouzarth
%%               April, 2007 by Liz Sell
%%               March, 2006 by Emily Gamber
%%				       May, 2003 by Bryan Sheldon
%
%
%---------------------------------------------REVISION HISTORY----------------------------------------------
%
% 2013/11/14: *Completely rewritten from scratch. The new version is configurable by parameters, so 
%              there should not be so much need to edit this class file. See the readme.txt for info.
%
% 2010/07/12: *Make bibliography, list of references, etc., lowercase
%
% 2007/04/02: *Added option for a dedication page.
%             *Changed list of figures.
%
% 2006/01/18: *Changed abstract format to print only Advisor and not also Reader.
%             *Add page number (ii) on copyright page and single space, if it's included.
%
% 2006/03/12: *Added option for electronic submission title page, since this requires no signature lines.  
%              Option is "electronicsig".
%
% 2003/5/1:   *Changed page margins to reflect increased pickyness in the graduate school.
%             *Guaranteed 2'' top margin before all chapters including Title page, abstract, toc, etc.
%             *Changed advisor/reader wording before the abstract for Masters theses.
%
% 1999/3/1:   *Changed some things for List of Tables and List of Figures; in particular, the spacing was 
%              changed and these lists now print either the word table or figure before the reference 
%              number. These changes made by Robert Keller.
%
% 1998/4/14:  *Added page numbers to the copyright page (this is contrary to the sample page in the 
%              dissertation handbook, but is required by the graduate school).
%
% 1998/4/8:   *Changed font size in bibliography to same size as rest of text.
%             *Fixed spacing in list of figures and list of tables.
%             *Set default font size to 12pt, with warning if using 11pt. Also disallowed using 10pt -- use 
%              11pt instead.
%
% 1998/4/5:   *Fixed a bug introduced when fixing the amsbook bug (ugh).
%
% 1998/4/1:   *Fixed a ``bug'' in the amsbook.cls (not recognizing that a new section should be started 
%              when starting a new chapter).
%
% 1998/3/30:  *Changed default font size to 11pt.
%             *Switched chapter numbers in toc back to arabic (approved by graduate school).
%             *Set spacing in toc (allows for long titles).
%             *Added option (datestamp) to print date at top (for drafts only).
%             *Changed spacing in footnotes to single (with a little extra between entries).
%             *Set default footnote symbol to arabic numbers.
%             *Changed some margins (some margins are slightly larger than required by the graduate school).
%
% 1998/3/11:  *Set bibliography spacing (single within entries, double between entries).
%
% 1998/3/3:   *Fixed problem with page numbers on the first page of a chapter (number should't be printed).
%              [set pagestyle to empty]
%
% 1998/2/5:   *Fixed theorem, definition, etc. headings to print in bold face and no indentations proof 
%              heading prints in italics.
%
% 1997/11/16: *Trying to fix spacing in toc -- may have done it with a minimum of fuss.
%             *Fixed list of figures spacing (same trick as for toc).
%             *Adjusted vertical spacing for index head.
%             *Added warnings for missing advisor or readers.
%
% 1997/11/15: *Completed significant changes in the way abstract and preface is handled.
%             *Fixed vertical spacing at chapter heads.
%
% 1997/11/11: *Started fixing vertical spacing problem at chapter heads.
%             *Added option for signature names on one line
%
% 1997/11/10: *Fixed "\DeclareOption{doctoral}{\doctrue}.
%             *Fixed problem with printing appendix number in toc.
%




%------------------------------------------------DECLARATION------------------------------------------------
\NeedsTeXFormat{LaTeX2e}% LaTeX 2.09 can't be used (nor non-LaTeX)
[1994/12/01]% LaTeX date must December 1994 or later
\ProvidesClass{unc_dissertation}[2015/11/20 v1.0]






%--------------------------------------------------OPTIONS--------------------------------------------------
%This package allows us to process options of the form `key=value' (see http://ctan.math.utah.edu/ctan/tex-archive/macros/latex/contrib/oberdiek/kvoptions.pdf).
\RequirePackage{kvoptions}

%change these so that if anyone decides to change the filename in the future, they won't have to change all the variable names.
\SetupKeyvalOptions{
  family=my,
  prefix=my@
}
%Note: \DeclareStringOption[default]{optionname} adds a new option optionname=<whatever>. It creates a new variable \my@optionname that contains the value of the option. It defaults to the value ``default''.
%      \DeclareBoolOption[default]{optionname} adds a new option optionname=true or optionname=false. It defaults to the value ``default''. It creates a new if \ifmy@optionname that may be used to check the value of the option.


%This command nullifys an option, so it doesn't get sent to the base class (report).
\newcommand{\NullOption}[1]{\DeclareVoidOption{#1}{\OptionNotUsed}}




%%% Title page options %%%

%Doctoral or masters thesis?
\DeclareBoolOption[true]{doctoral}  %Defaults to doctoral.
\DeclareComplementaryOption{masters}{doctoral} %Can specify in options either `masters' or `doctoral', or `masters=true', `doctoral=false', etc.

%Do you want to include a copyright page?
\DeclareBoolOption[true]{copyright}




%%% Formatting options %%%

%Should the titles (of the thesis, as well as sections like ``List of Figures'') be in all caps?
\DeclareBoolOption[true]{allcaps}

%Do you want the left (or inside, if using twoside option) margin to be 1in (not wide) or 1.25in (wide)? 
\DeclareBoolOption[false]{wideleftmargin}

%Do you want to print one-sided or two-sided? (Only really matters if you have the one wide margin.)
\DeclareBoolOption[true]{oneside}  %Defaults to one-sided.
\DeclareComplementaryOption{twoside}{oneside}
%We don't actually do anything with this, but report or geometry do.
\ifmy@oneside
  \PassOptionsToClass{oneside}{report}
\else
  \PassOptionsToClass{twoside}{report}
  \PassOptionsToPackage{twoside}{geometry}
\fi

%Do you want to the copyright notice to appear at the top of the page or the bottom?
\DeclareBoolOption[true]{cralignbottom}
\DeclareComplementaryOption{craligntop}{cralignbottom}


%%% Margin options %%%
%The default margins are configured to the requirements of the graduate school as of Nov. 2013. Since it is likely that these requirements will randomly change in the future, you can change the margins via the following options. I assume that the margins will be uniform for the entire document, except for perhaps some extra space at the top and the bottom of certain pages. The terms used are the same as those in the geometry package (see http://www.bakoma-tex.com/doc/latex/geometry/geometry.pdf for details).

%% NOTE: if you need wider margin on the left (inside), use the option wideleftmargin together with setting bindingoffset=<whatever extra space you need on the left>.

%The uniform margin (all sides) for the entire document.
\DeclareStringOption[1in]{margin}

%The left (inner), right (outer), top, and bottom margins separately.
\DeclareStringOption[\my@margin]{left}
\DeclareStringOption[\my@margin]{right}
\DeclareStringOption[\my@margin]{top}
\DeclareStringOption[\my@margin]{bottom}

%How far should the footer (the page number) be from the bottom of the body?
\DeclareStringOption[0.5in]{foot}

%If using wide left margins, how wide should the extra space be?
\DeclareStringOption[0.25in]{bindingoffset}


%%% The following options are used to configure how much ``extra space'' there should be in various spots.

%How much extra space is needed above the titles (in general)?
\DeclareStringOption[1in]{extra}

%How much extra space is needed above the main title (on the title page)?
\DeclareStringOption[\my@extra]{titleextra}

%How much extra space is needed above chapter titles (in both front and main matter)?
\DeclareStringOption[\my@extra]{chaptertitleextra}

%How much extra space is needed above chapter titles in the frontmatter (abstract, TOC, etc.)?
\DeclareStringOption[\my@chaptertitleextra]{fronttitleextra}

%How much extra space is needed above the list of figures or tables?
\DeclareStringOption[0in]{listtitleextra}

%How much extra space is needed above chapter titles in the mainmatter (i.e. the main chapters)?
\DeclareStringOption[\my@chaptertitleextra]{maintitleextra}

%How much extra space is needed above appendix titles?
\DeclareStringOption[0in]{appendixtitleextra}

%How much extra space is needed above titles in the backmatter (bibliography, index, etc.)?
\DeclareStringOption[0in]{backtitleextra}

%How much extra space is needed on the bottom (or top) of the copyright page?
\DeclareStringOption[1in]{copyrightextra}






%We want to ignore the following options, to prevent them from getting sent to the base class.
%Paper must be letterpaper:
\NullOption{a4paper}
\NullOption{a5paper}
\NullOption{b5paper}
\NullOption{letterpaper}
\NullOption{legalpaper}
\NullOption{executivepaper}
%Force portrait mode:
\NullOption{landscape}
\NullOption{portrait}
%We will provide our own titlepage.
\NullOption{notitlepage}
\NullOption{titlepage}
%You can have chapters opening on any page (not just the right). --- Never mind, I'll allow this in case you want it in a print version.
%\NullOption{openright}
%\NullOption{openany}
%One column only.
\NullOption{onecolumn}
\NullOption{twocolumn}


%Any option that is not listed above gets sent along to report. This really only leaves the font size (10pt, 11pt, 12pt), leqno, fleqn, and openbib.
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{report}}

%Process the options.
\ProcessKeyvalOptions{my}\relax

%Load the report class, sending any necessary options along.
\LoadClass{report} 






%-------------------------------------------------MARGINS---------------------------------------------------

% The geometry package makes dealing with margins much much easier. This sets up the basic margins.
\RequirePackage[
  %showframe,%for debugging
  portrait,
  letterpaper,
  margin=\my@margin,
  left=\my@left,
  right=\my@right,
  top=\my@top,
  bottom=\my@bottom,
  foot=\my@foot
	%Extra wide margin on the left, if requested.
	\ifmy@wideleftmargin
	  ,bindingoffset=\my@bindingoffset
	\fi
]{geometry}




%Here we configure some utility functions to provide the extra spaces. (This is necessary to ensure that it works correctly when the extra space is 0pt. It also helps clean up some of the conditionals elsewhere).

%If it's 0pt, we don't want to have a vspace command at all. The * is necessary since it could appear at the top of a page. NOTE: The \hbox{}\kern-\topskip part should make it start at the actual top of the page (without inserting additional space). (See also http://tex.stackexchange.com/questions/7676/why-does-vspace0pt-add-vertical-space).
\newcommand{\my@titlepageextra}{%
	\hbox{}\kern-\topskip
	\ifx\my@titleextra{0pt}%
	\else%
    \vspace*{\my@titleextra}%
	\fi%
}
\newcommand{\my@frontextra}{%
  \hbox{}\kern-2\topskip    %I don't know why I need to double it here and in the rest, but it works.
	\ifx\my@fronttitleextra{0pt}%
	\else%
	  \vspace*{\my@fronttitleextra}%
	\fi%
}
\newcommand{\my@listextra}{%
  \hbox{}\kern-2\topskip
	\ifx\my@listtitleextra{0pt}%
	\else%
	  \vspace*{\my@listtitleextra}%
	\fi%
}
\newcommand{\my@mainextra}{%
  \hbox{}\kern-2\topskip
	\ifx\my@maintitleextra{0pt}%
	\else%
	  \vspace*{\my@maintitleextra}%
	\fi%
}
\newcommand{\my@appendixextra}{%
  \hbox{}\kern-2\topskip
	\ifx\my@appendixtitleextra{0pt}%
	\else%
	  \vspace*{\my@appendixtitleextra}%
	\fi%
}
\newcommand{\my@backextra}{%
  \hbox{}\kern-2\topskip
	\ifx\my@backtitleextra{0pt}%
	\else%
	  \vspace*{\my@backtitleextra}%
	\fi%
}

%For the copyright page, also consider whether its align top or bottom
\newcommand{\my@crtopextra}{%
  \ifmy@cralignbottom%
	  %fill in all the vertical space at the top so that what follows goes as far to the bottom as possible.
	  \vspace*{\fill}%
  \else%
    %provide the extra space 	  
    \hbox{}\kern-2\topskip
    \vspace*{\my@copyrightextra}%
  \fi%
}
\newcommand{\my@crbottomextra}{%
  \ifmy@cralignbottom%
    %provide the extra space 	  
    \hbox{}\kern-2\topskip
    \vspace*{\my@copyrightextra}%
  \fi%
}








%---------------------------------------------OTHER PACKAGES------------------------------------------------
% This package allows double spacing
\RequirePackage{setspace}
\doublespacing

% The varwidth environment is like a minipage, but has the smallest possible width.
\RequirePackage{varwidth}

% This package makes the text prettier.
\RequirePackage[protrusion,expansion,tracking,kerning,letterspace=25]{microtype}

% This package allows for glossaries
\RequirePackage[acronym]{glossaries}

%---------------------------------------------COMMANDS PROVIDED---------------------------------------------

%% This defines commands: 
%%   \DeclareAuthorVariable*{var}   % for a mandatory variable
%%   \DeclareAuthorVariable{var}    % for an optional variable
%% Which are essentially equivalent to doing: 
%%   \newcommand{\my@var}
%%   \newcommand{\var}[1]{\renewcommand{\my@var}{#1}}
%% This code was (mostly) copied from: 
%%   http://tex.stackexchange.com/questions/93908/macro-for-declaring-variables-in-class-files

% Do the branching between * and normal version
\newcommand{\DeclareAuthorVariable}{%
  \@ifstar{\my@DeclareAuthorVariable{\my@mandatory@var}}
          {\my@DeclareAuthorVariable{\my@optional@var}}%
}

% The main command; the internal version of \foo is \my@foo
% The macro \ting@foo is initialized to give an error or an info
% message when used, so if the user doesn't provide a value for a
% mandatory variable, we'll catch the issue. (Modified  to branch 
% according to a variable having been given a value or not.)
\newcommand{\my@DeclareAuthorVariable}[2]{%
  \long\@namedef{my@#2}{#1{#2}}%
  \long\@namedef{#2}##1{\long\@namedef{my@#2}{##1}\long\@namedef{my@#2@defined}{}}%
}
% The error and info messages
\newcommand{\my@mandatory@var}[1]{%
  \ClassError{unc_dissertation}
    {Missing value for mandatory variable
     \expandafter\string\csname#1\endcsname}
    {You have to provide a value with
     \expandafter\string\csname#1\endcsname{...}}%
}
\newcommand{\my@optional@var}[1]{%
  \ClassInfo{unc_dissertation}
    {Missing value for optional variable
     \expandafter\string\csname#1\endcsname}%
}

% To allow for branching based on a variable having a value or not.
\newcommand{\@ifauthorvariable}[3]{\@ifundefined{my@#1@defined}{#3}{#2}}

% Examples:
%   \DeclareAuthorVariable*{var}
%   \DeclareAuthorVariable{optvar}
% To check if a variable is defined:
%   \@ifauthorvariable{optvar}
%      {The optional value is \my@optvar.}
%      {The optional value is missing!}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% THE FOLLOWING VARIABLES MAY BE (RE)DEFINED BY THE USER %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% These variables are used to produce the title page. %%%

%Info for title page (optional, defaualt values are provided, depending on whether doctoral or masters).
%Type of paper (dissertation, thesis, project, etc.).
\DeclareAuthorVariable*{disstype}
%Full name of degree (Doctor of Philosophy, Masters of Science, etc.).
\DeclareAuthorVariable*{dissdegree}
%Full name of department and/or school (Department of Mathematics, Department of Physics, etc.).
\DeclareAuthorVariable*{dissdept}
\ifmy@doctoral
  \disstype{dissertation}
  \dissdegree{Doctor of Philosophy}
\else
  \disstype{thesis}
  \dissdegree{Master of Science}
\fi
\dissdept{Department of Mathematics in the College of Arts and Sciences}

%The blurb on the title page will be automatically constructed from the above information. If you need to change it, you can redefine this variable.
\DeclareAuthorVariable*{dissblurb}
\dissblurb{A \my@disstype{} submitted to the faculty at the University of North Carolina at Chapel Hill in partial fulfillment of the requirements for the degree of \my@dissdegree{} in the \my@dissdept.}

%The location. You shouldn't ever have to change this, unless UNC teleports to some other city or something.
\DeclareAuthorVariable*{dissloc}
\dissloc{Chapel Hill}

%The year the thesis is submitted (defaults to the current year).
\DeclareAuthorVariable*{dissyear}
\dissyear{\the\year}

%Heading above the names of the committee members---hopefully this should never have to be changed.
\DeclareAuthorVariable*{approvedby}
\approvedby{Approved by:}

%Name of advisor.
\DeclareAuthorVariable*{advisor} 
%Names of committee members (a.k.a. ``readers'') These are set as optional in case you have special circumstances in which you do not have 4 readers.
\DeclareAuthorVariable{readerA}
\DeclareAuthorVariable{readerB}
\DeclareAuthorVariable{readerC}
\DeclareAuthorVariable{readerD}

%A shortcut command to quickly set the names of the advisor and the 4 comittee members, in order.
\newcommand{\committee}[5]{%
  \advisor{#1}%
  \readerA{#2}%
  \readerB{#3}%
  \readerC{#4}%
  \readerD{#5}%
}




%%% These variables are used to make the copyright page (you shouldn't have to change these). %%%

%The copyright year (defaults to submission year).
\DeclareAuthorVariable*{cryear}
\cryear{\my@dissyear}

%The name to appear on the copyright page (defaults to the author).
\DeclareAuthorVariable*{crauthor}
\crauthor{\@author}

%The copyright blurb (defaults to ALL RIGHTS RESERVED).
\DeclareAuthorVariable*{crblurb}
\crblurb{\textls*[25]{ALL RIGHTS RESERVED}}




%%% This is used to make the abstract page. The command \abstract (like \title and \author) MUST be called by the user before calling \maketitle. %%%

%The abstract text (mandatory).
\DeclareAuthorVariable*{abstract}

%The abstract blurb (appears after the title of the abstract page, you shouldn't have to change this).
\DeclareAuthorVariable*{abstractblurb}
\abstractblurb{\@author: \@title\par (Under the direction of \my@advisor)} 

% For those of us with two advisors (i.e., Rich and Roberto), comment above and uncomment below.
% Need the { } to force a space between the first advisor's last name and the word "and."
%\abstractblurb{\@author: \@title\par (Under the direction of \my@advisor{ }and \my@readerA)} 

%Width of the abstract blurb, specified as a percentage of the width of the body (i.e. the text area, not including margins). At 1.0 the blurb tends to look weird if you have a really long title, so defaults to .75.  
\DeclareAuthorVariable*{abstractblurbwidth}
\abstractblurbwidth{.75}




%%% This is used to make the dedication page. %%%

%The dedication text (optional).
\DeclareAuthorVariable{dedication}

%Width of the dedication, as a percentage. (Behaves the same as \abstractblurbwidth.)
\DeclareAuthorVariable*{dedicationwidth}
\dedicationwidth{.75}





%%% The titles of various automatically constructed pages. %%%

\DeclareAuthorVariable*{absname}
\absname{Abstract}
\DeclareAuthorVariable*{tocname}
\tocname{Table of Contents} 
\DeclareAuthorVariable*{lofname}
\lofname{LIST OF FIGURES} 
\DeclareAuthorVariable*{lotname}
\lotname{LIST OF TABLES}
\DeclareAuthorVariable*{loaname}
\loaname{LIST OF ABBREVIATIONS} 
\DeclareAuthorVariable*{bblname}
\bblname{REFERENCES} 




























%-----------------------------------------------FRONT MATTER------------------------------------------------
%%% This is the section where all of the front matter pages get formatted and created. If you need to change how these pages are formatted, and you cant do it with the settings, this is where you edit this file. %%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMPORTANT NOTE: THIS IS THE SECTION YOU EDIT IF YOU NEED TO CHANGE THE FORMATTING OF THE TITLE PAGE, ETC.%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






% Redefine what \maketitle does (changed from report). Now it makes a title page in accordance with the UNC thesis dissertation guide. It additionally creates the copyright page, the dedication page (optional), and the abstract page.
\renewcommand\maketitle{%
  \my@maketitlepage%
  \ifmy@copyright%
    \my@makecopyrightpage%
  \fi%
  \my@makeabstractpage%
  \@ifauthorvariable{dedication}{\my@makededicationpage}{}%
  \global\let\thanks\relax%
  \global\let\maketitle\relax%
  \global\let\@thanks\@empty%
  \global\let\@author\@empty%
  \global\let\@date\@empty%
  \global\let\@title\@empty%
  \global\let\title\relax%
  \global\let\author\relax%
  \global\let\date\relax%
  \global\let\and\relax%
}



%This function actually makes the title page.
\newcommand{\my@maketitlepage}{%
%Be careful about extra returns (put % signs at the end of lines). They can throw off the spacing.
  \thispagestyle{empty}%
  %Single space it here.
  \singlespacing%
  \begin{center}%
    %Add the extra space at the top.
    \my@titlepageextra%
    
    %actually display the title
    \my@displaymaintitle \par%
    
    \vspace{1in}
    %display the author
    \@author \par
    \vspace{1in}%
    
    %The blurb
    \my@dissblurb \par
    \vspace{1in}%
    
    %location and year
    \my@dissloc \par
    \my@dissyear \par
    \vspace{1in}%
    
  \end{center}
  %back to double spacing
  \doublespacing
  %List the advisor, followed by the committee members.
  %This varwidth box is as wide as the longest name inside it. The names align left inside the box, but the box itself goes as far right as it can because of the \hfill above.
  \hspace{4.666in}
  \begin{varwidth}{\textwidth} 
	  \my@approvedby \par
	  \my@advisor \par
	  \my@readerA \par
	  \my@readerB \par
	  \my@readerC \par
	  \my@readerD
  \end{varwidth}
  \clearpage
}




%This function makes the copyright page.
\newcommand{\my@makecopyrightpage}{
	\begin{center}
	  %single spacing again
	  \singlespacing
	  %provide the top extra space
	  \my@crtopextra
	  %copyright year
	  \copyright{} \my@cryear \par
	  
	  %copyright name
	  \my@crauthor \par
	  
	  %copyright blurb
	  \my@crblurb \par
	  
    %provide the bottom extra space 	  
	  \my@crbottomextra
  \end{center}
  \clearpage
}







%This function makes the abstract page.
\newcommand{\my@makeabstractpage}{
	\begin{center}
	  %add extra space at top.
	  \my@frontextra
    %display the title
	  \my@displaytitle{\my@absname}
	  
	  %put the blurb in a box because it looks weird when the title is really long. Note that the apparent stupidity of the two nested center environments is due to the fact the box also needs to be centered, not just its contents within the box. The width of the box is controlled by setting \abstractblurbwidth.
	  \begin{minipage}{\my@abstractblurbwidth\textwidth}
	    \begin{center}
		    %single spacing for the blurb
		    \singlespacing
		    \my@abstractblurb
	    \end{center}
	  \end{minipage}
	\end{center}
    
  %double spacing for the text of the abstract
  \doublespacing
  
  %skip a line
  \vspace{\baselineskip}
  
  %display the abstract
  \my@abstract
  \clearpage
}







%This function makes the dedication page.
\newcommand{\my@makededicationpage}{
	\begin{center}
	  %add extra space at top.
	  \my@frontextra
	  %put it in a box
	  \begin{minipage}{\my@dedicationwidth\textwidth}
	    \begin{center}
		    %single spacing 
		    \singlespacing
		    %display the dedication
		    \my@dedication
	    \end{center}
	  \end{minipage}
	\end{center}
	\clearpage
}








%%% Functions for controlling the display format (not positioning) of the main title or chapter title. %%%

% Displays the main title, either in allcaps, large and bold, or in Large font, depending on the allcaps option. The \textls adds letterspacing to the allcaps titles, so they look better.
\newcommand{\my@displaymaintitle}{%
  \ifmy@allcaps%
    {\large \textls*[25]{\textbf{\MakeUppercase{\@title}}}}%
  \else%
    { \textbf{\@title}}%
  \fi%
}

% Displays the title of a \chapter*, either in allcaps and bold, or in Large font, depending on the allcaps option. The \textls adds letterspacing to the allcaps titles, so they look better.
\newcommand{\my@displaytitle}[1]{%
  \ifmy@allcaps%
    \textls*[25]{\textbf{\MakeUppercase{#1}}}%
  \else%
    {\Large #1}%
  \fi%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%             END FRONT MATTER FORMATTING AREA             %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




























%------------------------------------------DOCUMENT ORGANIZATION--------------------------------------------

%%% In order for the document to be formatted correctly, we set up commands that are used to organize the document into 4 sections. %%%

%Set up flags to indicate when we've reached the frontmatter, mainmatter, appendices, or backmatter. To get your formatting right, you MUST use \frontmatter, \mainmatter, \appendix (if you have them), and \backmatter (for bibliography).
\newif\ifmy@frontmatter
\my@frontmatterfalse

\newif\ifmy@mainmatter
\my@mainmatterfalse

\newif\ifmy@appendix
\my@appendixfalse

\newif\ifmy@backmatter
\my@backmatterfalse
    
%Define the commands \frontmatter, etc. (overriding \appendix).
\newcommand\frontmatter{%
	\my@frontmattertrue%
	\my@mainmatterfalse%
	\my@appendixfalse%
	\my@backmatterfalse%
  \cleardoublepage\pagenumbering{roman}}
  
\newcommand\mainmatter{%
	\my@frontmatterfalse%
	\my@mainmattertrue%
	\my@appendixfalse%
	\my@backmatterfalse%
	\cleardoublepage\pagenumbering{arabic}}

\renewcommand\appendix{%
	\my@frontmatterfalse%
	\my@mainmatterfalse%
	\my@appendixtrue%
	\my@backmatterfalse%
  \par
  \setcounter{chapter}{0}%
  \setcounter{section}{0}%
  \gdef\@chapapp{\appendixname}%
  \gdef\thechapter{\@Alph\c@chapter}}
  
\newcommand\backmatter{%
	\my@frontmatterfalse%
	\my@mainmatterfalse%
	\my@appendixfalse%
	\my@backmattertrue%
  \if@openright\cleardoublepage\else\clearpage\fi
  \let\chaptername\relax}

%Except, list of tables and list of figures have their own rules. So add a flag for that.
\newif\ifmy@isalist
\my@isalistfalse

%And set the flag when you call \listoffigures, \listoftables or \listofabbreviations
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \my@isalisttrue
    \chapter*{\listfigurename}%
      \@mkboth{\MakeUppercase\listfigurename}%
              {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    
    \if@restonecol\twocolumn\fi
    \my@isalistfalse
    }
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \my@isalisttrue
    \chapter*{\listtablename}%
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \my@isalistfalse
    }
\providecommand\listofabbreviations{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \my@isalisttrue
    \printglossary[type=\acronymtype,title=\listabbreviationname]
    \if@restonecol\twocolumn\fi
    \my@isalistfalse
    }
    

\newcommand\my@addappropriatespace{%
		\ifmy@isalist%
			\my@listextra%
		\else%
	    \ifmy@frontmatter\my@frontextra\fi%
			\ifmy@mainmatter\my@mainextra\fi%
			\ifmy@appendix\my@appendixextra\fi%
			\ifmy@backmatter\my@backextra\fi%
		\fi%
}





%--------------------------------------------CHAPTER FORMATTING---------------------------------------------


%%% The following commands override those from report to change the display of chapter headers, so that they start 2 inches below the top of the page, and are otherwise formatted appropriately. Hopefully the settings I've provided will allow for a sufficient amount of customization to satisfy the graduate school. If you, you're going to have to wade in to some pretty deep LaTeX stuff here. Additionally we add nonnumbered chapters to the table of contents. %%%

%Now we modify the display of the chapter headings to do the right things.
\def\@makechapterhead#1{%this is for \chapter
  \begin{center}%
    %Add the appropriate extra space at the beginning.
    \my@addappropriatespace%
		%Display ``CHAPTER n'' at the top of the page. (Also letterspace it since it is all caps.)
	  \textls*[25]{{\MakeUppercase{\@chapapp}\enspace\thechapter}}
	   
	  %thought we might need to skip a line, but I like the way it looks better without doing so.
	  %\vspace{\baselineskip}  
	  
	  %Display the actual name of the title in Large font
	  {\large\bfseries #1}
	  \par
	  
  \end{center}
  %\vspace*{\baselineskip}
}
\def\@makeschapterhead#1{%this is for \chapter*
  \begin{center}
    %Add the appropriate extra space at the beginning.
    \my@addappropriatespace%
	  %Display the title, capitalizing if allcaps is specified.
	  \my@displaytitle{#1}
	  \par
  \end{center}
  %\vspace*{\baselineskip}
}










%--------------------------------------------SECTION FORMATTING---------------------------------------------
% The default section and subsection headings from report are too big. So we fix them. (See http://infohost.nmt.edu/tcc/help/pubs/nmtthesis/old/annotated/at.startsection.html).
\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\bfseries\singlespacing}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries\singlespacing}}
%Since the subsubsections are now the same size as the subsections, we make them run-in headings.
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {-1em}%
                                     {\normalfont\normalsize\bfseries}}
%Of course, now subsubsections are formatted the same as paragraphs. But oh well.










%--------------------------------------------TABLE OF CONTENTS----------------------------------------------
%%% OK, so here we're going to try to get the table of contents (and the lists of tables and figures) to display the way we like. %%%


%Set the titles of the various lists to the correct values. 
\renewcommand{\contentsname}{\my@tocname}
\renewcommand{\listfigurename}{\my@lofname}
\renewcommand{\listtablename}{\my@lotname}
\providecommand{\listabbreviationname}{\my@loaname}

% Anything that comes before the table of contents should not have an entry in the toc. To implement this requirement, I define a flag \my@isthereatoc, defaulting to false.

%This flag indicates whether we've reached the table of contents or not
\newif\ifmy@isthereatoc
\my@isthereatocfalse

%I override the \tableofcontents command to set the flag to true when the command \tableofcontents is called.
\renewcommand\tableofcontents{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname
      \@mkboth{%
         \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi%
  \my@isthereatoctrue%
}

%Change the display of the TOC so that chapter lines have leading.
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak
      \leaders\hbox{$\m@th
        \mkern \@dotsep mu\hbox{.}\mkern \@dotsep
        mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
  
%changed \chapter* to add line to toc, if the chapter occurs after the table of contents already exists.
\def\@schapter#1{%
  \ifmy@isthereatoc%
    \addcontentsline{toc}{chapter}{#1}%
  \fi%
	\if@twocolumn
	 \@topnewpage[\@makeschapterhead{#1}]%
	\else
	 \@makeschapterhead{#1}%
	 \@afterheading
  \fi
}

%changed \chapter to print ``Chapter 1.  Title of chapter'' to table of contents instead of just ``1. Title of Chapter''. (Similarly for Appendix A.)
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \ifmy@isthereatoc
                           \addcontentsline{toc}{chapter}{\MakeUppercase{\@chapapp{ }\protect\numberline{\thechapter:}#1}}%
                         \fi
                    \else
                      \ifmy@isthereatoc
                        \addcontentsline{toc}{chapter}{#1}%
                      \fi
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}











%-------------------------------------------------FOOTNOTES-------------------------------------------------

%The following code runs when \begin{document} is called.
\AtBeginDocument{%
	% Change the footnote marker to arabic numbers
	\renewcommand{\thefootnote}{\arabic{footnote}}%
}

%Double space between footnotes.
\setlength{\footnotesep}{\baselineskip}
%Additional space between the bottom of the text and the first footnote.
\skip\footins=2\baselineskip






%------------------------------------------------BIBLIOGRAPHY-----------------------------------------------

% Set the bibliography title
\renewcommand{\bibname}{\my@bblname}

%Change spacing of bibliography entries (one line added from report.cls).
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname}%
      \@mkboth{\MakeUppercase\bibname}{\MakeUppercase\bibname}%
      \singlespacing    %make bib entries single spaced
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
      \endlist}









%-----------------------------------------------HYPHENATION-------------------------------------------------

%Show LaTeX how to hyphenate certain words. (Copied from amsbook.)
\hyphenation{acad-e-my acad-e-mies af-ter-thought anom-aly anom-alies
an-ti-deriv-a-tive an-tin-o-my an-tin-o-mies apoth-e-o-ses
apoth-e-o-sis ap-pen-dix ar-che-typ-al as-sign-a-ble as-sist-ant-ship
as-ymp-tot-ic asyn-chro-nous at-trib-uted at-trib-ut-able bank-rupt
bank-rupt-cy bi-dif-fer-en-tial blue-print busier busiest
cat-a-stroph-ic cat-a-stroph-i-cally con-gress cross-hatched data-base
de-fin-i-tive de-riv-a-tive dis-trib-ute dri-ver dri-vers eco-nom-ics
econ-o-mist elit-ist equi-vari-ant ex-quis-ite ex-tra-or-di-nary
flow-chart for-mi-da-ble forth-right friv-o-lous ge-o-des-ic
ge-o-det-ic geo-met-ric griev-ance griev-ous griev-ous-ly
hexa-dec-i-mal ho-lo-no-my ho-mo-thetic ideals idio-syn-crasy
in-fin-ite-ly in-fin-i-tes-i-mal ir-rev-o-ca-ble key-stroke
lam-en-ta-ble light-weight mal-a-prop-ism man-u-script mar-gin-al
meta-bol-ic me-tab-o-lism meta-lan-guage me-trop-o-lis
met-ro-pol-i-tan mi-nut-est mol-e-cule mono-chrome mono-pole
mo-nop-oly mono-spline mo-not-o-nous mul-ti-fac-eted mul-ti-plic-able
non-euclid-ean non-iso-mor-phic non-smooth par-a-digm par-a-bol-ic
pa-rab-o-loid pa-ram-e-trize para-mount pen-ta-gon phe-nom-e-non
post-script pre-am-ble pro-ce-dur-al pro-hib-i-tive pro-hib-i-tive-ly
pseu-do-dif-fer-en-tial pseu-do-fi-nite pseu-do-nym qua-drat-ic
quad-ra-ture qua-si-smooth qua-si-sta-tion-ary qua-si-tri-an-gu-lar
quin-tes-sence quin-tes-sen-tial re-arrange-ment rec-tan-gle
ret-ri-bu-tion retro-fit retro-fit-ted right-eous right-eous-ness
ro-bot ro-bot-ics sched-ul-ing se-mes-ter semi-def-i-nite
semi-ho-mo-thet-ic set-up se-vere-ly side-step sov-er-eign spe-cious
spher-oid spher-oid-al star-tling star-tling-ly sta-tis-tics
sto-chas-tic straight-est strange-ness strat-a-gem strong-hold
sum-ma-ble symp-to-matic syn-chro-nous topo-graph-i-cal tra-vers-a-ble
tra-ver-sal tra-ver-sals treach-ery turn-around un-at-tached
un-err-ing-ly white-space wide-spread wing-spread wretch-ed
wretch-ed-ly Eng-lish Euler-ian Feb-ru-ary Gauss-ian
Hamil-ton-ian Her-mit-ian Jan-u-ary Japan-ese Kor-te-weg
Le-gendre Mar-kov-ian Noe-ther-ian No-vem-ber Rie-mann-ian Sep-tem-ber}


%Added by JRF.
\hyphenation{sin-gu-lar-i-ties sin-gu-lar-ity ho-mo-ge-neous sur-face weighted ra-tio-nal ho-mol-ogy smooth-ing smooth-ings com-po-nent com-po-nents ir-re-duc-ible affine va-ri-ety va-ri-eties pro-jec-tive pro-jec-tiv-i-za-tion com-pact-i-fied com-pact-i-fi-ca-tion al-ge-braic}





\endinput
%end of unc_dissertation.cls file































