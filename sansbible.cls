\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sansbible}[2018/08/25 A LaTeX Class for typestting Sanskrit Bible]
\RequirePackage{geometry, indentfirst, xparse, fancyhdr, xcolor, tikz, calc, etoolbox}

\usepackage[framemethod=TikZ]{mdframed}
\usetikzlibrary{shapes,shadows,calc,positioning}
\LoadClass{scrbook}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax

\geometry{top=0.9in, bottom=0.6in, left=0.6in, right=0.6in} % Margins
\setlength\parindent{10pt} % Paragraph indent
\renewcommand{\baselinestretch}{1.5} % Line spacing

%Defining colors
\definecolor{myblue}{RGB}{47, 79, 79}
\definecolor{myblue2}{RGB}{60, 100, 100}
\definecolor{mybrown}{RGB}{120, 60, 60}
\definecolor{myblue3}{RGB}{30, 60, 60}

%Defining the fonts
\usepackage{fontspec, polyglossia}
\setmainfont[Script=Devanagari,Mapping=devanagarinumerals]{Shobhika}
\newfontfamily{\Sansk}[Script=Devanagari,Mapping=devanagarinumerals]{Sanskrit 2003}

\newcommand{\eoc}{{\Sansk{\hspace{1em}॥\thesection॥}}} %Defining the text for end of chapter

%Defining a switch ---- This fetches the sanskrit ordinals when the number is given
\usepackage{xifthen}
\newcommand{\ifequals}[3]{\ifthenelse{\equal{#1}{#2}}{#3}{}}
\newcommand{\case}[2]{#1 #2}
\newenvironment{switch}[1]{\renewcommand{\case}{\ifequals{#1}}}{}
%Defining the cases of chapter names in sanskrit
\newcommand{\sansno}[1]{
	\begin{switch}{#1}
		\case{1}{प्रथमोऽध्यायः।}
		\case{2}{द्वितीयोऽध्यायः।}
		\case{3}{तृतीयोऽध्यायः।}
		\case{4}{चतुर्थोऽध्यायः।}
		\case{5}{पञ्चमोऽध्यायः।}
		\case{6}{षष्ठोऽध्यायः।}
		\case{7}{सप्तमोऽध्यायः।}
		\case{8}{अष्टमोऽध्यायः।}
		\case{9}{नवमोऽध्यायः।}
		\case{10}{दशमोऽध्यायः।}
		\case{11}{एकादशोऽध्यायः।}
		\case{12}{द्वादशोऽध्यायः।}
		\case{13}{त्रयोदशोऽध्यायः।}
		\case{14}{चतुर्दशोऽध्यायः।}
		\case{15}{पञ्चदशोऽध्यायः।}
		\case{16}{षोडशोऽध्यायः।}
		\case{17}{सप्तदशोऽध्यायः।}
		\case{18}{अष्ठादशोऽध्यायः।}
		\case{19}{ऊनविंशोऽध्यायः।}
		\case{20}{विंशोऽध्यायः।}
		\case{21}{एकविंशोऽध्यायः।}
		\case{22}{द्वाविंशोऽध्यायः।}
		\case{23}{त्रयोविशोऽध्यायः।}
		\case{24}{चतुर्विंशोऽध्यायः।}
		\case{25}{पञ्चविंशोऽध्यायः।}
		\case{26}{षड्विंशोऽध्यायः।}
		\case{27}{सप्तविंशोऽध्यायः।}
		\case{28}{अष्ठाविंशोऽध्यायः।}
	\end{switch}
}

%%%\renewcommand{\thesection}{\Sansk{\arabic{section}}} % Avoid printing the chapter (grandha) number along with the section (adhyaya) number
\setcounter{secnumdepth}{0} % Set levels of sectioning to be numbered

% Centering the chapter heading
\usepackage{sectsty}
\chapterfont{\centering\color{myblue3}}

%Avoiding displaying chapter number along with the chapter heading
\makeatletter
	\patchcmd{\@makeschapterhead}{\vskip 40\p@}{\vspace*{1\baselineskip}}{}{} % patch the command \@makeschapterhead
	\let\@makechapterhead\@makeschapterhead % make \@makechapterhead act like \@makeschapterhead
\makeatother

%Defining grandha
\newcommand{\grandha}[1]{\chapter{\Sansk{#1}}\vspace{-50pt}}

%This is to be used as a chapter (adhyAya) in Bible
\renewcommand{\thesection}{\arabic{section}}
\newcounter{verse}[section]
\DeclareDocumentCommand{\adhyAya}{}{
	\refstepcounter{section} % Step the chapter counter

	\hspace{0pt}\vspace{-7pt}\\\begin{mdframed}[innertopmargin=5pt, innerbottommargin=5pt, backgroundcolor=myblue,rightline=false,leftline=false, topline=false, bottomline=false]
	\color{white}\textbf{\thesection\sansno{\thesection}}
	\end{mdframed}\vspace{-30pt}
}

% Defining the section heading
\newcommand{\stitle}[1]{\hspace{0pt}\vspace{6pt}\\\centerline{\color{mybrown}\large\Sansk\bfseries#1}\vspace{-3pt}} 

%Defining a vakya
\DeclareDocumentCommand{\vakya}{}{
	\refstepcounter{verse} % Step the verse counter
	\hspace{-10pt}\textsuperscript{\color{myblue2}\arabic{verse}}\hspace{-2pt}
}

%Formatting the header and footer
\pagestyle{fancy}
\cfoot{} % Removing default in center footer.
\fancyhead{}
\fancyhead[RO,LE]{\thepage}
\fancyhead[CO,CE]{\color{myblue3}\Sansk{\leftmark}}
\fancypagestyle{plain}{\fancyhf{}}
\renewcommand{\chaptermark}[1]{\markboth{\textbf{#1}\hspace{1em}}{}}

%Handling Poems
\newenvironment{poem}{
	\newcommand{\startwithline}{&}
	\newcommand{\startwithvakya}{\refstepcounter{verse}\textsuperscript{\color{myblue2}\arabic{verse}}&}
	\newcommand{\pline}{\\\startwithline}
	\renewcommand{\vakya}{\\\startwithvakya}
	\hspace{0pt}\\\begin{tabular}{rc}
	}
	{
	\end{tabular}
	\hspace{0pt}\\
	}

%Loading the files containing the contents
\usepackage{forloop}
\newcounter{cno}
\newcommand{\zeroed}[1]{\ifnum\value{#1}<10 0\fi\arabic{#1}} % Returns the counter value with zero prefixed if it is one digit
\newcommand{\loadbook}[2]{\forLoop{1}{#2}{cno}{
	\input{books/#1/\zeroed{cno}}}} % Loads the files of a book where #1 is the folder name and #2 is the number of chapters of the book.
\newcommand{\getbook}[3]{
	\grandha{#1}
	\loadbook{#2}{#3}} % This retrieves all data of a book where #1 is the book name, #2 is the folder name and #3 is the no of chapters.

%Handling table of contents
\usepackage{tocloft}
\renewcommand*{\contentsname}{\hspace{6em}\color{myblue3}\Sansk{अनुक्रमणिका}}
\renewcommand{\cftchapfont}{\color{blue}\Sansk}
