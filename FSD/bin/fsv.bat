echo off

rem Feature Structure Validator
rem    Gary Simons (SIL International)
rem    4 Oct 2002
rem
rem Validates the TEI feature strucures in an XML document 
rem against definitions in a Feature System Declaration
rem
rem Usage: fsv %1 %2
rem    where %1 is the document, %2 is the FSD
rem Resulting report is in temp_report.htm

rem Set the filepath for the directory in which FSV is installed
set bin=C:\-\Projects\Sgml\TEI\FSD\bin\

echo on
\msxsl %2 %bin%fsv_compile_defaults.xsl -o temp_add_defaults.xsl
\msxsl %2 %bin%fsv_compile_tests.xsl -o temp_test_validity.xsl bin=%bin% data=%1 fsd=%2
\msxsl %1 temp_add_defaults.xsl -o temp_data.xml
\msxsl temp_data.xml temp_test_validity.xsl -o temp_report.htm
