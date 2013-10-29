\msxsl FSD_sample.xml compile_FSD1.xsl -o add_defaults.xsl
\msxsl GPSG_test.xml add_defaults.xsl -o out.xml
\msxsl FSD_sample.xml compile_FSD2.xsl -o test_validity.xsl
\msxsl out.xml test_validity.xsl -o out2.htm
