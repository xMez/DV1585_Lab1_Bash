#include "node.hh"
#include<iostream>
#include<fstream>
#include "binary.tab.hh"
extern Node root;
extern unsigned int total;

void yy::parser::error(std::string const&err)
{
	std::cout << "It's one of the bad ones... " << total << std::endl;
}

void makeFile()
{
	std::ofstream ofs ("graph.dot", std::ofstream::out);

	ofs << "digraph {" << "\n";
	int depth = 0;
	ofs << root.toStream(depth).str();
	ofs << "}";

	ofs.close();
}

int main(int argc, char **argv)
{
	yy::parser parser;
	if(!parser.parse())
		makeFile();
	return 0;
}

