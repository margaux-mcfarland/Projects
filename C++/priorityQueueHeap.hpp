#ifndef priorityQueueHeap_H
#define priorityQueueHeap_H
#include <string>

using namespace std;

struct HeapNode {
	string name = "";
	int priority = -1;
	int treatmentTime = -1;
	
};

class priorityQueueHeap {
	private:
		HeapNode *heapArray; //pointer to heap array
		int capacity;
		int currentSize;
		void heapify(int);
	public:
		priorityQueueHeap();	//default constructor
		priorityQueueHeap(int);	//overloaded constructor takes in capacity
		~priorityQueueHeap();	//destructor
		void push(string,int,int); //given name of patient, prirority, and treatment time, adds to queue based on priority 
		HeapNode createNode(string,int,int);
		HeapNode pop();//deletes node at top of queue
		void printHeap();
		void swap(HeapNode,HeapNode);

};

#endif