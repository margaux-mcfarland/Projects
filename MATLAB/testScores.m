%testScores.m
%reads an excel spreadsheet of exam answers and computes the final grade
%Margaux McFarland, CSCI 1320-112, ID: 107731341


%gets data from file
[nums,txt,raw] = xlsread('Section9_data.xlsx');

%get vector for answer key
key = raw(2,7:23);

%loops through each student to get num of correct answers
%preallocate correctScores vec to num of students
correctScores = zeros(1,101);

%holds place for index in correctScores
count = 1;

for i = 3:103 %loops through rows (students)
    correctScores(1,count) = sum(strcmp(key,raw(i,7:23)));
    count = count + 1;
end


%compute final score
finalScores = correctScores*5 + nums(2:102,3);


%plot
histogram(finalScores);
hold;
title('Final exam scores for Section 9');
xlabel('student');
ylabel('Final Score');


%%
%find frequency of questions missed and plots the number
%of times each question was missed

%preallocates vec for freqeuncy of missed question to num of questions
incorrectFreq = zeros(1,17);

%holds place for index in inccorectFreq
count2 = 1;

for i = 3:103 %loops through rows (students)
    for j = 7:23 %loops through cols (each question)
        count2 = j - 6;
        if strcmp(key(count2),raw(i,j)) ~= 1
            
            incorrectFreq(count2) = incorrectFreq(count2) + 1;
        end
    end
end

%plot
figure;
plot(1:17,incorrectFreq);
title('Frequency of each question missed');
xlabel('Question Number (1-17)');
ylabel('Number of times missed');



