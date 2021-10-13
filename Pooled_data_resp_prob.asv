%combine 10 s and 3 s data
data3=load('WIN_20211007_14_56_14_Pro_analyzed.mat');
data10=load('WIN_20211007_15_26_36_Pro_analyzed.mat');
figure; 
%plot(1:20,[1,mean(Resp(:,1:19),1)])
x=(1:20)';
y=(mean(data3.Resp(:,1:20),1))';
f=fit(x,y,'exp1');
plot(x,y)
hold on
plot(f,x,y,'b')

x=(25:44)';
y=(mean(data3.Resp(:,21:40),1))';
f=fit(x,y,'exp1')
plot(x,y,'b')
plot(f,x,y)

x=(50:69)';
y=(mean(data3.Resp(:,41:60),1))';
f=fit(x,y,'exp1')
plot(x,y,'b')
plot(f,x,y)

x=(75:94)';
y=(mean(data3.Resp(:,60:79),1))';
f=fit(x,y,'exp1')
plot(x,y,'b')
plot(f,x,y)
legend off
%% load the ISI = 10 s data
hold on%plot(1:20,[1,mean(Resp(:,1:19),1)])
x=(1:20)';
y=(mean(data10.Resp(:,1:20),1))';
f=fit(x,y,'exp1');
plot(x,y,'g*')
hold on
plot(f,x,y,'g')

x=(25:44)';
y=(mean(data10.Resp(:,21:40),1))';
f=fit(x,y,'exp1')
plot(x,y,'g*')
plot(f,x,y,'g')

x=(50:69)';
y=(mean(data10.Resp(:,41:60),1))';
f=fit(x,y,'exp1')
plot(x,y,'g*')
plot(f,x,y,'g')

x=(75:94)';
y=(mean(data10.Resp(:,60:79),1))';
f=fit(x,y,'exp1')
plot(x,y,'g*')
plot(f,x,y,'g')

legend off