%adjustable_rate_mortgage.m

%how much borrower pays per month
p = 4000;
h = 0.5;
t = 0;
y = 750000;
n = 0;
r = 0.03;
rTotal = 0;
while y>0
    if t>5
        r = 0.03 +0.015*sqrt(t-5);
        rTotal = rTotal + r;
    end
    t = t+h;
    y = y+h*(r*y-12*p);
    n = n+1;
end

fprintf('It takes %.3f years to pay off $750,000\nwith a total interest of %.3f\n', t, rTotal);
t1 = linspace(0,t,n);
y1 = 1:n;
h = 0.5;
t = 0;
y = 750000;
p = 4000;
r = 0.03;

for i = 1:n
    if t > 5
        r = 0.03 + 0.015*sqrt(t-5);
    end
    y = y + h*(r*y-12*p);
    y1(i) = y;
    t = t+h;
end

%how much borrower pays per month pt2
p = 4500;
h = 0.5;
t = 0;
y = 750000;
n = 0;
r = 0.03;
rTotal2 =0;
while y>0
    if t>5
        r = 0.03 +0.015*sqrt(t-5);
        rTotal2 = rTotal2 + r;
    end
    t = t+h;
    y = y+h*(r*y-12*p);
    n = n+1;
end

fprintf('It takes %.3f years to pay off $750,000\nwith a total interest of %.3f\n', t, rTotal2);
t2 = linspace(0,t,n);
y2 = 1:n;
h = 0.5;
t = 0;
y = 750000;
p = 4500;
r = 0.03;

for i = 1:n
    if t > 5
        r = 0.03 + 0.015*sqrt(t-5);
    end
    y = y + h*(r*y-12*p);
    y2(i) = y;
    t = t+h;
end

figure, plot(t1,y1,'r')
hold on
plot(t2,y2,'b');

title('Outstanding Balance vs time');
xlabel('time (years)');
ylabel('Outstanding balance (dollars)');

        
        
        
        
        





