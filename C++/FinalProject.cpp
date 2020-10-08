//author: Margaux McFarland
//date: May 2018

#include <iostream>
#include <fstream>
#include <sstream>
#include "priorityQueueLL.hpp"
#include "priorityQueueHeap.hpp"
#include <queue>
#include <time.h>
#include <math.h>


using namespace std;

//each patient has a name, priority, and treatment time
struct patient{
	string name;
	int priority;
	int treatmentTime;
	patient(string inName, int inPri, int inTreat){
		name = inName;
		priority = inPri;
		treatmentTime = inTreat;
	}
};


//comparing patients
struct compare{
	bool operator()(const patient &a, const patient &b){
		if(a.priority > b.priority){
			return true;
		}else if(a.priority == b.priority){
			return a.treatmentTime > b.treatmentTime;
		}else{
			return false;
		}
	}
};


float runProgram(int implementation, string file_name, int num_lines){
	clock_t t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12;

	priorityQueueLL p_q_LL;
	priorityQueueHeap p_q_Heap(1000);
	priority_queue<patient, vector<patient>, compare> p_q_STL;
	//linked list
	if(implementation == 1 || implementation == 4){
		//linked list
		t1 = clock();
	}else if(implementation == 2 || implementation == 5){
		//heap
		t2 = clock();
	}else if(implementation == 3 || implementation == 6){
		//STL
		t3 = clock();
	}


	//open file
	ifstream myfile;
	myfile.open(file_name);
	string data;

	string name;
	int priority;
	int treatmentTime;

	int line_count = 0;

	if(myfile.is_open()){
		getline(myfile,data,'\r');
		//if(!deleting){
			while(getline(myfile,data,'\r') && line_count < num_lines){

				line_count++;
				stringstream ss;

				ss<<data;
				//get patient name
				string parse;
				getline(ss,parse,',');
				name = parse;
				//get patient priority (time till birth)
				getline(ss,parse,',');
				priority = stoi(parse);
				//get patient treatment time
				getline(ss,parse,',');
				treatmentTime = stoi(parse);

				//add patient to queue
				if(implementation == 1 || implementation == 4){
					p_q_LL.enqueue(name,priority,treatmentTime);
					t4 = clock();	
				}else if(implementation == 2 || implementation == 5){
					p_q_Heap.push(name,priority,treatmentTime);
					t5 = clock();
				}else if(implementation == 3 || implementation == 6){
					patient p = patient(name, priority,treatmentTime);
					p_q_STL.push(p);
					t6 = clock();
				}
			
			
			}
	//	}else{
			//remove 
			if(implementation == 4){
				p_q_LL.dequeue();
				t7 = clock();
			}else if(implementation == 5){
				p_q_Heap.pop();
				t8 = clock();
			}else if(implementation == 6){
				p_q_STL.pop();
				t9 = clock();
			}
	//	}
		
	}

	if(implementation == 1){
		return ((float)t4-(float)t1) / CLOCKS_PER_SEC;
	}else if(implementation == 2){
		return ((float)t5-(float)t2) / CLOCKS_PER_SEC;
	}else if(implementation == 3){
		return ((float)t6-(float)t3) / CLOCKS_PER_SEC;
	}else if(implementation == 4){
		return ((float)t7-(float)t4) / CLOCKS_PER_SEC;
	}else if(implementation == 5){
		return ((float)t8-(float)t5) / CLOCKS_PER_SEC;
	}else if(implementation == 6){
		return ((float)t9-(float)t6) / CLOCKS_PER_SEC;
	}



	/*p_q_LL.printLL();
	p_q_Heap.printHeap();
	int rank = 1;
	while(!p_q_STL.empty()){
		cout<<rank<<": "<<p_q_STL.top().name<<", "<<p_q_STL.top().priority<<", "<<p_q_STL.top().treatmentTime<<endl;
		p_q_STL.pop();
		rank++;
	}*/

}


int main(int argc, char *argv[]){

	//array of runTimes for each function and implementation

	float runTimes100[6][500];
	float runTimes200[6][500];
	float runTimes300[6][500];
	float runTimes400[6][500];
	float runTimes500[6][500];
	float runTimes600[6][500];
	float runTimes700[6][500];
	float runTimes800[6][500];
	float runTimes880[6][500];

	float sums100[6];
	float sums200[6];
	float sums300[6];
	float sums400[6];
	float sums500[6];
	float sums600[6];
	float sums700[6];
	float sums800[6];
	float sums880[6];	

		
	for(int implementation = 0; implementation < 6; implementation++){
		for(int i = 0; i < 500; i++){
			//run times and sum of run times for 100 lines, 200 lines, etc...
			runTimes100[implementation][i] = runProgram(implementation + 1,argv[1],100);
			runTimes200[implementation][i] = runProgram(implementation + 1,argv[1],200);
			runTimes300[implementation][i] = runProgram(implementation + 1,argv[1],300);
			runTimes400[implementation][i] = runProgram(implementation + 1,argv[1],400);
			runTimes500[implementation][i] = runProgram(implementation + 1,argv[1],500);
			runTimes600[implementation][i] = runProgram(implementation + 1,argv[1],600);
			runTimes700[implementation][i] = runProgram(implementation + 1,argv[1],700);
			runTimes800[implementation][i] = runProgram(implementation + 1,argv[1],800);
			runTimes880[implementation][i] = runProgram(implementation + 1,argv[1],880);

			sums100[implementation] = sums100[implementation] + runTimes100[implementation][i];
			sums200[implementation] = sums200[implementation] + runTimes200[implementation][i];
			sums300[implementation] = sums300[implementation] + runTimes300[implementation][i];
			sums400[implementation] = sums400[implementation] + runTimes400[implementation][i];
			sums500[implementation] = sums500[implementation] + runTimes500[implementation][i];
			sums600[implementation] = sums600[implementation] + runTimes600[implementation][i];
			sums700[implementation] = sums700[implementation] + runTimes700[implementation][i];
			sums800[implementation] = sums800[implementation] + runTimes800[implementation][i];
			sums880[implementation] = sums880[implementation] + runTimes880[implementation][i];
		}
	}

	float means100[6];
	float means200[6];
	float means300[6];
	float means400[6];
	float means500[6];
	float means600[6];
	float means700[6];
	float means800[6];
	float means880[6];

	for(int i = 0; i < 6; i++){
		means100[i] = sums100[i]/500;
		means200[i] = sums200[i]/500;
		means300[i] = sums300[i]/500;
		means400[i] = sums400[i]/500;
		means500[i] = sums500[i]/500;
		means600[i] = sums600[i]/500;
		means700[i] = sums700[i]/500;
		means800[i] = sums800[i]/500;
		means880[i] = sums880[i]/500;
	}


	float std_dev100[6] = {0,0,0,0,0,0};
	float std_dev200[6] = {0,0,0,0,0,0};
	float std_dev300[6] = {0,0,0,0,0,0};
	float std_dev400[6] = {0,0,0,0,0,0};
	float std_dev500[6] = {0,0,0,0,0,0};
	float std_dev600[6] = {0,0,0,0,0,0};
	float std_dev700[6] = {0,0,0,0,0,0};
	float std_dev800[6] = {0,0,0,0,0,0};
	float std_dev880[6] = {0,0,0,0,0,0};

	for(int j = 0; j < 6; j++){ //loops through implementations
		for(int i = 0; i < 500; i ++){ 
			std_dev100[j] = pow(std_dev100[j] - runTimes100[j][i],2);
			std_dev200[j] = pow(std_dev200[j] - runTimes200[j][i],2);
			std_dev300[j] = pow(std_dev300[j] - runTimes300[j][i],2);
			std_dev400[j] = pow(std_dev400[j] - runTimes400[j][i],2);
			std_dev500[j] = pow(std_dev500[j] - runTimes500[j][i],2);
			std_dev600[j] = pow(std_dev600[j] - runTimes600[j][i],2);
			std_dev700[j] = pow(std_dev700[j] - runTimes700[j][i],2);
			std_dev800[j] = pow(std_dev800[j] - runTimes800[j][i],2);
			std_dev880[j] = pow(std_dev880[j] - runTimes880[j][i],2);
		}

		std_dev100[j] = sqrt(std_dev100[j]/500);
		std_dev200[j] = sqrt(std_dev200[j]/500);
		std_dev300[j] = sqrt(std_dev300[j]/500);
		std_dev400[j] = sqrt(std_dev400[j]/500);
		std_dev500[j] = sqrt(std_dev500[j]/500);
		std_dev600[j] = sqrt(std_dev600[j]/500);
		std_dev700[j] = sqrt(std_dev700[j]/500);
		std_dev800[j] = sqrt(std_dev800[j]/500);
		std_dev880[j] = sqrt(std_dev880[j]/500);
	}


	cout<<"Average runtime to build priorityQueueLL: "<<means100[0]<<endl;
	cout<<"Average runtime to build priorityQueueHeap: "<<means100[1]<<endl;
	cout<<"Average runtime to build priorityQueueSTL: "<<means100[2]<<endl;
	cout<<"Average runtime to delete from priorityQueueLL: "<<means100[3]<<endl;
	cout<<"Average runtime to delete from priorityQueueHeap: "<<means100[4]<<endl;
	cout<<"Average runtime to delete from priorityQueueSTL: "<<means100[5]<<endl;
	cout<<"==================================================="<<endl;
	cout<<"Average runtime to build priorityQueueLL: "<<means880[0]<<endl;
	cout<<"Average runtime to build priorityQueueHeap: "<<means880[1]<<endl;
	cout<<"Average runtime to build priorityQueueSTL: "<<means880[2]<<endl;
	cout<<"Average runtime to delete from priorityQueueLL: "<<means880[3]<<endl;
	cout<<"Average runtime to delete from priorityQueueHeap: "<<means880[4]<<endl;
	cout<<"Average runtime to delete from priorityQueueSTL: "<<means880[5]<<endl;


	//create csv file
	ofstream buildFile;
	ofstream deleteFile;
	ofstream std_dev_buildFile;
	ofstream std_dev_deleteFile;
	buildFile.open("RuntimeAnalysisBuild.csv");
	deleteFile.open("RuntimeAnalysisDelete.csv");
	std_dev_buildFile.open("Standard Deviations of Build Runtimes in milliseconds.csv");
	std_dev_deleteFile.open("Standard Deviations of Delete Runtimes in milliseconds.csv");

	buildFile << "Implementation,100 lines,200 lines,300 lines,400 lines,500 lines,600 lines,700 lines,800 lines,880 lines, \n";
	deleteFile << "Implementation,100 lines,200 lines,300 lines,400 lines,500 lines,600 lines,700 lines,800 lines,880 lines, \n";
	std_dev_buildFile << "Implementation,100 lines,200 lines,300 lines,400 lines,500 lines,600 lines,700 lines,800 lines,880 lines, \n";
	std_dev_deleteFile << "Implementation,100 lines,200 lines,300 lines,400 lines,500 lines,600 lines,700 lines,800 lines,880 lines, \n";
	string implementationName[3] = {"Linked List","Heap","STL"};
	string functionNmes[2] = {"Build","Delete"};
	int line_arr[9] = {100,200,300,400,500,600,700,800,880};
	for(int i = 0; i < 3; i++){
		buildFile << implementationName[i]+",";
		deleteFile << implementationName[i]+",";
		std_dev_buildFile << implementationName[i]+",";
		std_dev_deleteFile << implementationName[i]+",";

		buildFile << means100[i] << "," << means200[i]<< "," << means300[i]<<"," << means400[i]<<"," << means500[i]<<"," << means600[i] << "," << means700[i] << "," << means800[i] << "," << means880[i]<<"\n";
		deleteFile << means100[i+3] << "," << means200[i+3]<< "," << means300[i+3]<<"," << means400[i+3]<<"," << means500[i+3]<<"," << means600[i+3]<<"," << means700[i+3]<<"," << means800[i+3]<<"," << means880[i+3]<<"\n";
		std_dev_buildFile << std_dev100[i] << "," << std_dev200[i]<< "," << std_dev300[i]<<"," << std_dev400[i]<<"," << std_dev500[i]<<"," << std_dev600[i]<<"," << std_dev700[i]<<"," << std_dev800[i]<<"," << std_dev880[i]<<"\n";
		std_dev_deleteFile << std_dev100[i+3] << "," << std_dev200[i+3]<< "," << std_dev300[i+3]<<"," << std_dev400[i+3]<<"," << std_dev500[i+3]<<"," << std_dev600[i+3]<<"," << std_dev700[i+3]<<"," << std_dev800[i+3]<<"," << std_dev880[i+3]<<"\n";
		

	}



	buildFile.close();
	deleteFile.close();
	std_dev_buildFile.close();
	std_dev_deleteFile.close();

	return 0;
}