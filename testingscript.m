w1=10;
w2=20;
Tspan1=0:0.01:100;
Tspan2= 100.01:0.1:200;
fi1 = cos(w1*Tspan1);
fi2 = cos(w2*Tspan2);
Tspan=[Tspan1 Tspan2];
fi=[fi1 fi2]
ti=Tspan;
[T,Y]=ode45(@(t,y) myeqd(t,y,ti,fi),Tspan,[1;1;30]);
plot (T,Y)