#include<iostream>
#include "binary.tab.hh"

void yy::parser::error(std::string const&err)
{
	std::cout << err << std::endl;
}

int main(int argc, char **argv)
{
	yy::parser parser;
	if(!parser.parse())
	return 0;
}

