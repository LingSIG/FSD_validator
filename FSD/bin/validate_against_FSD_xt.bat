echo off
rem validate_against_FSD.bat %1 %2
rem Gary Simons (SIL International), 4 Oct 2002
rem
rem Validates the TEI feature strucures in an XML data file against
rem definitions in an FSD: %1 is the data file, %2 is the FSD
rem Resulting report is in temp_report.htm
rem
set bin=C:\-\Projects\Sgml\TEI\FSD\bin\
set xt=C:\software\xslt\xt
echo on
%xt% %2 %bin%fsd_compile_defaults.xsl temp_add_defaults.xsl bin=%bin%
%xt% %2 %bin%fsd_compile_tests.xsl temp_test_validity.xsl bin=%bin%
%xt% %1 temp_add_defaults.xsl temp_data.xml
%xt% temp_data.xml temp_test_validity.xsl temp_report.htm
