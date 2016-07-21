unc_dissertation.cls - README

MAINTENANCE AND DISTRIBUTION
----------------------------
If you've come to this repo from a link in the UNC math grad resources Sakai page, and the person who owns this repo isn't currently a student at UNC, please fork this repo and replace the link with a link to your fork.


----------- USAGE -----------
 
At the beginning of your main .tex file, include the line:

\documentclass[<option1>,<option2>,<etc.>]{unc_dissertation}


The possible <options> will be described below, in the section labeled OPTIONS. However, the defaults should format the thesis appropriately for the graduate school. The only option you probably need to include is the font size, which can be ``10pt'', ``11pt'', or ``12pt'' (without the quotes; 11pt is recommended). If you are writing a master's thesis (as opposed to a doctoral thesis) include the option ``masters'' (again, without the quotes).


Note: The class ``unc_dissertation'' is based on the basic LaTeX class ``report''. So if you write your thesis using the report class, it should be very easy to switch to using unc_dissertation.


At some point in your preamble (before the \begin{document}), you MUST include the following lines:

\title{<your title>}

\author{<your name>}

\abstract{<insert your abstract here>}

Either
\committee{<advisor's name>}{<reader A name>}{<reader B name>}{<reader C name>}{<reader D name>}
or, if you have fewer than 4 readers, you can use
\advisor{<advisor's name>}
optionally followed up to four readers specified by 
\readerA{<reader A name>}
\readerB{<reader B name>}
\readerC{<reader C name>}
\readerD{<reader D name>}


If you wish to include a dedication page, then include the following line in your preamble:

\dedication{<text of the dedication>}


You can customize the text and appearance of the automatically generated pages with additional commands in the preamble; see the section CUSTOMIZATION below.


The main document (between \begin{document} and \end{document}) is divided into four sections:
Front matter: for the title, abstract, preface, table of contents, etc.
Main matter: for the chapters of the thesis.
Appendix: for appendices (optional).
Back matter: for the bibliography.

They are indicated by calling the commands \frontmatter, \mainmatter, \appendix, and \backmatter respectively.


The command \maketitle should be the first thing to appear in the \frontmatter section. It generates the title page, copyright page, abstract page, and dedication page (if specified). See the sample.tex file for an example of how your main .tex file should be organized.


And, that's it! Unless you have some special or unusual scenario, you can stop reading here. See the sample.tex for an example of how to use this class.



----------- OPTIONS -----------

This section lists the possible <options> that can be included in the line:
\documentclass[<option1>,<option2>,<etc.>]{unc_dissertation}

As mentioned before, the defaults should be sufficient for most cases. These options are included in case the graduate school changes their requirements, or if some other special case arises.

Notes: The symbol ``|'' is used to indicate ``or''. Some options are specified in the format ``key=<value>'' where <value> should be replaced with whatever you want to specify.



Title page options:

doctoral | masters
Specifies whether the thesis is a PhD thesis or a master's thesis. Default is doctoral.

copyright=<true|false>
Specifies whether a copyright page should be included (true) or not (false). Default is true.



Formatting options:

allcaps=<true|false>
If true, then the titles of the thesis and of sections such as the table of contents will appear in all caps. Default is true. 

wideleftmargin=<true|false>
If true, the left (or inside, if using ``twoside'' option) margin will be wider (1.25in by default) than the right (1in by default). This should be specified if you intend on printing and binding the thesis. If false, both right and left margins will be the same (1in by default). Default is false.

oneside | twoside
Specifies whether the document should print one-sided or two-sided (this only really matters if you are using ``wideleftmargin=true''. Default is one-sided.

cralignbottom | craligntop
On the copyright page, specifies whether the text should appear aligned to the top or to the bottom of the page. Default is bottom.



Margin options:

margin=<length>
Specifies the uniform margin (all sides) for the entire document. Default is 1in.

left=<length>
right=<length>
top=<length>
bottom=<length>
Specify the size of the margins on the left, right, top, and bottom respectively. If not specified, defaults to the value of the ``margin'' option (which defaults to 1in).

foot=<length>
Specifies the distance from the bottom of the body to the footer (i.e. the page number). 

bindingoffset=<length>
If wideleftmargin=true, then this specifies the amount of extra space to appear in the wider margin. Default is 0.25in.



The following options are used to configure how much ``extra space'' there should be in various spots:

extra=<length>
How much extra space is needed above the titles (in general). Default is 1in.

titleextra=<length>
How much extra space is needed above the main title (on the title page). Defaults to the value of ``extra''.

chaptertitleextra=<length>
How much extra space is needed above chapter titles (in both front and main matter). Defaults to the value of ``extra''.

fronttitleextra=<length>
How much extra space is needed above chapter titles in the frontmatter (abstract, TOC, etc.). Defaults to the value of ``chaptertitleextra''.

listtitleextra=<length>
How much extra space is needed above the list of figures or tables. Defaults to 0in (as per feedback from the graduate school).

maintitleextra=<length>
How much extra space is needed above chapter titles in the mainmatter (i.e. the main chapters). Defaults to the value of ``chaptertitleextra''.

appendixtitleextra=<length>
How much extra space is needed above appendix titles. Defaults to 0in.

backtitleextra=<length>
How much extra space is needed above titles in the backmatter (bibliography, index, etc.). Defaults to 0in.

copyrightextra=<length>
How much extra space is needed on the bottom (or top, if craligntop is specified) of the copyright page. Defaults to 1in.



The following options are inherited from the ``report'' class, and function exactly the same:

10pt | 11pt | 12pt
Specify the font size.

leqno
Puts formula numbers on the left side in equation and eqnarray environments.

fleqn
Left-aligns displayed formulas.

openbib
Causes the bibliography to be formatted in open style.






----------- CUSTOMIZATION -----------

The following commands allow for additional customization of the automatically generated material. These commands may optionally be included in the preamble of the document. You (hopefully) won't have to use any of these except in very special cases.


Title Page:

\disstype{<dissertation type>}
The type of dissertation. For example, ``dissertation'', ``thesis'', ``project'', etc.

\dissdegree{<full name of degree>}
``Doctor of Philosophy'' or ``Masters of Science'', etc. 

\dissdept{<full name of department or school>}
``Department of Mathematics'', etc.

\dissblurb{<text>}
This is the blurb that appears on the title page of the thesis. If it is not specified, it is automatically constructed from the disstype, dissdegree, and dissdept variables. ``A thesis submitted to the faculty...''

\dissloc{<location>}
The name of the city. ``Chapel Hill''

\dissyear{<year>}
The year the thesis is submitted. Defaults to current year.

\approvedby{<text>}
Text to replace ``Approved by:''



Copyright Page:

\cryear{<year>}
The year to appear on the copyright page.

\crauthor{<name>}
The name to appear on the copyright page.

\crblurb{<text>}
``ALL RIGHTS RESERVED.''



Abstract Page:

\absname{<title>}
Title of the abstract page. ``Abstract''.

\abstractblurb{<text>}
Blurb that appears before the abstract. ``Author Name: Title (Under the direction of...)''

\abstractblurbwidth{<length>}
Width of the abstract blurb, specified as a percentage of the width of the body (i.e. the text area, not including margins). At 1.0 the blurb tends to look weird if you have a really long title, so defaults to .75. 



Dedication Page:

\dedicationwidth
Width of the dedication, as a percentage. (Behaves the same as \abstractblurbwidth.)



Titles of various other automatically constructed pages:

\tocname{<title>}
Title of table of contents.

\lofname{<title>} 
Title of list of figures.

\lotname{<title>} 
Title of list of tables.

\bblname{<title>} 
Title of bibliography.






----------- DEPENDENCIES -----------

This class is based off the report class that comes with LaTeX. It requires the following packages: 
kvoptions
geometry
setspace
varwidth
microtype

