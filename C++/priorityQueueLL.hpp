#ifndef priorityQueueLL_H
#define priorityQueueLL_H
#include <string>

using namespace std;

struct Node {
	string name = "";
	int priority = -1;
	int treatmentTime = -1;
	Node* next = nullptr;
};

class priorityQueueLL {
	private:
		Node* head = nullptr;
	public:
		void enqueue(string,int,int); //given name of patient,priority, and treatment time, adds to queue based on priority 
		priorityQueueLL();	//default constructor
		priorityQueueLL(string, int, int);	//overloaded constructor
		~priorityQueueLL();	//destructor
		Node* createNode(string,int,int,Node*);
		void dequeue();//deletes node at top of queue
		void printLL();

};

#endif