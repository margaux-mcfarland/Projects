#include "priorityQueueHeap.hpp"
#include <iostream>
using namespace std;

priorityQueueHeap::priorityQueueHeap(){
	//default constructor
}

priorityQueueHeap::priorityQueueHeap(int cap){
	//overloaded constructor takes in capacity
	capacity = cap;
	currentSize = 0;
	HeapNode heap [capacity];
	heapArray = heap;
}

priorityQueueHeap::~priorityQueueHeap(){
//destructor
}

void priorityQueueHeap::push(string name,int priority,int treatmentTime){
	//given name of patient, prirority, and treatment time, adds to queue based on priority 
	//chack if full
	HeapNode newNode = createNode(name, priority, treatmentTime);
	if(currentSize == capacity){
		cout<<"Heap is full"<<endl;
	}else{
		currentSize++;
		int i = currentSize;
		heapArray[i] = newNode;

		//move to  correct index
		while(i > 1 && heapArray[i/2].priority >= heapArray[i].priority){
			//parent's time till birth is longer than child..then swap
			if(heapArray[i/2].priority == heapArray[i].priority){

				while(i > 1 && heapArray[i/2].treatmentTime >  heapArray[i].treatmentTime && heapArray[i/2].priority == heapArray[i].priority){
					//swap(heapArray[i],heapArray[i/2]);
					HeapNode temp = heapArray[i];
					heapArray[i] = heapArray[i/2];
					heapArray[i/2] = temp;
					i = i/2;
				}
				break;
			}
			//swap(heapArray[i],heapArray[i/2]);
			HeapNode temp = heapArray[i];
			heapArray[i] = heapArray[i/2];
			heapArray[i/2] = temp;
			i = i/2;
		}
	}


}

HeapNode priorityQueueHeap::createNode(string name,int priority,int treatmentTime){
	HeapNode newNode;
	newNode.name = name;
	newNode.priority = priority;
	newNode.treatmentTime = treatmentTime;

	return newNode;
}

HeapNode priorityQueueHeap::pop(){
//deletes node at top of queue
	if(currentSize == 0){
		cout<<"Heap is empty"<<endl;
	}else if(currentSize == 1){
		currentSize--;
		return heapArray[1];
	}else{
		HeapNode popNode = heapArray[1];
		heapArray[1] = heapArray[currentSize];
		currentSize--;
		heapify(1);
		return popNode;
	}
	
}

void priorityQueueHeap::heapify(int i){
	int left = 2*i;
	int right = 2*i + 1;
	int smallest = i;

	//find smallest
	if(left <= currentSize && heapArray[left].priority <= heapArray[i].priority){
		if(heapArray[left].priority == heapArray[i].priority){
			if(heapArray[left].treatmentTime < heapArray[i].treatmentTime){
				smallest = left;
			}
		}else{
			smallest = left;
		}
		
	}
	if(right <= currentSize && heapArray[right].priority <= heapArray[smallest].priority){
		if(heapArray[right].priority == heapArray[smallest].priority){
			if(heapArray[right].treatmentTime < heapArray[smallest].treatmentTime){
				smallest = right;
			}
		}else{
			smallest = right;
		}
	}
	
	if(smallest != i){
		//if there was a child smaller than parent
		//swap(heapArray[i],heapArray[smallest]);
		HeapNode temp = heapArray[i];
		heapArray[i] = heapArray[smallest];
		heapArray[smallest] = temp;
		heapify(smallest);
	}
}

void priorityQueueHeap::printHeap(){
	
	for(int i = 1; i < 881; i++){
		HeapNode current = pop();
		cout<<i<<": "<<current.name<<", "<<current.priority<<", "<<current.treatmentTime<<endl;
	}
}

void priorityQueueHeap::swap(HeapNode n1, HeapNode n2){
	HeapNode temp = n1;
	n1 = n2;
	n2 = temp;
}