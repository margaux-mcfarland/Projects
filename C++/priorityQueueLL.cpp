#include "priorityQueueLL.hpp"
#include <iostream>
using namespace std;

	
priorityQueueLL::priorityQueueLL(){
	//default constructor
}

priorityQueueLL::priorityQueueLL(string name, int priority, int treatmentTime){
	//overloaded constructor
	head = createNode(name, priority, treatmentTime, NULL);
}	

priorityQueueLL::~priorityQueueLL(){
	//destructor
}	

void priorityQueueLL::enqueue(string name,int priority, int treatmentTime){
	//given name of patient, adds to queue based on priority 
	Node *newNode = createNode(name,priority,treatmentTime,NULL);
	Node *current = head;
	Node *prev = NULL;
	bool isAdded = false;
	if(head == NULL){
		//empty queue
		head = newNode;
		isAdded = true;
		
	}else{

		while(current != NULL && !isAdded){
			if(current->priority > priority){
				//when current has a larger time to birth 
				//add new patient before this
				if(prev != NULL){
					prev->next = newNode;
				}else{
					//change head
					head = newNode;
				}
				newNode->next = current;
				isAdded = true;
			}else if(current->priority == priority){
				while(current != NULL && current->priority == priority && !isAdded){
					if(treatmentTime <= current->treatmentTime ){
						//if treatment time of patient being added is less than patient already in queue
						//add patient before existing patient
						if(prev != NULL){
							prev->next = newNode;
						}else{
							//change head
							head = newNode;
						}
						newNode->next = current;
						isAdded = true;
					}
					prev = current;
					current = current->next;
				}
				continue;
			}
			if(current != NULL){
				prev = current;
				current = current->next;
			}
			
		}
	}
	if(!isAdded){
		//add to end of queue
		prev->next = newNode;
	}
}

Node* priorityQueueLL::createNode(string name, int priority, int treatmentTime, Node* next){
	Node *newNode = new Node;
	newNode->name = name;
	newNode->priority = priority;
	newNode->treatmentTime = treatmentTime;

	return newNode;
}

void priorityQueueLL::dequeue(){
	//deletes node at top of queue
	if(head == NULL){
		cout<<"Queue is empty"<<endl;
	}else{
		head = head->next;
	}
}

void priorityQueueLL::printLL(){
	Node *current = head;
	int rank = 1;
	while(current != NULL){
		cout<<rank<<": "<<current->name<<", "<<current->priority<<", "<<current->treatmentTime<<endl;;
		current = current->next;
		rank++;
	}
}