#include "node.hh"
#include<iostream>
#include "binary.tab.hh"
extern Node root;
extern unsigned int total;

void yy::parser::error(std::string const&err)
{
	std::cout << "It's one of the bad ones... " << total << std::endl;
}

int main(int argc, char **argv)
{
	yy::parser parser;
	if(!parser.parse())
		root.dump();
	return 0;
}

