#ifndef NODE_HH
#define NODE_HH
#include <iostream>
#include <sstream>
#include <string>
#include <list>
class Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Node(std::string t, std::string v) : tag(t), value(v) {}
	Node() { tag="uninitialized"; value="uninitialized"; }
	void dump(int depth=0)
	{
		for(int i=0; i<depth; i++)
			std::cout << "  ";
		std::cout << tag << ":" << value << std::endl;
		for(auto i=children.begin(); i!=children.end(); i++)
			(*i).dump(depth+1);
	}
	std::ostringstream toStream(int &depth, int parent=0)
	{
		std::ostringstream oss;
		oss << depth << " [label=\"" << tag << ":" << value << "\"];" << "\n";
		for(auto i=children.begin(); i!=children.end(); i++)
		{			
			depth++;
			oss << parent << " -> " << depth << "\n";
			oss << (*i).toStream(depth, depth).str();
		}
		parent++;
		return oss;
	}
	virtual void execute() = 0;
};

class Root : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Root(std::string t, std::string v) : tag(t), value(v) {}
	Root() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Stream : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Stream(std::string t, std::string v) : tag(t), value(v) {}
	Stream() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Optline : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Optline(std::string t, std::string v) : tag(t), value(v) {}
	Optline() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Line : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Line(std::string t, std::string v) : tag(t), value(v) {}
	Line() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Pipe : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Pipe(std::string t, std::string v) : tag(t), value(v) {}
	Pipe() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Equals : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Equals(std::string t, std::string v) : tag(t), value(v) {}
	Equals() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Command : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Command(std::string t, std::string v) : tag(t), value(v) {}
	Command() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Concat : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Concat(std::string t, std::string v) : tag(t), value(v) {}
	Concat() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class WordChar : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	WordChar(std::string t, std::string v) : tag(t), value(v) {}
	WordChar() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class VarChar : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	VarChar(std::string t, std::string v) : tag(t), value(v) {}
	VarChar() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class QuotedChar : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	QuotedChar(std::string t, std::string v) : tag(t), value(v) {}
	QuotedChar() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class EqualChar : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	EqualChar(std::string t, std::string v) : tag(t), value(v) {}
	EqualChar() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};

class Subshell : public Node {
public:
	std::string tag, value;
	std::list<Node> children;
	Subshell(std::string t, std::string v) : tag(t), value(v) {}
	Subshell() { tag="uninitialized"; value="uninitialized"; }
	void execute()
	{

	}
};
#endif
