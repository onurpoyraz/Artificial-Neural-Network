clear;
clc;
%ONUR POYRAZ
%CONTÝNUOUS HOPFÝELD
r1=1;
r2=1;
c1=1;
c2=1;
T=[0 1;1 0];
lambda=1.2;
func=@(x) 2/pi*atan(lambda*pi*x/2);
inv_func=@(x) 2/(lambda*pi)*tan(pi*x/2);
energy= @(x,y) -1/2*(x*y+y*x)+integral(inv_func,0,x)/r1+integral(inv_func,0,y)/r2;
epoch=1;
x(epoch,:)=[0.95 -0.75];
y(epoch,:)=func(x(epoch,:));
e(epoch)=energy(y(1),y(2));
while (1)
    epoch=epoch+1;
    delta=[0 0];
    delta(1,1)=r1*y(epoch-1,2)*T(2,1)-r1*c1*x(epoch-1,1);
    delta(1,2)=r2*y(epoch-1,1)*T(1,2)-r2*c2*x(epoch-1,2);
    x(epoch,1)=x(epoch-1,1)+delta(1,1);
    x(epoch,2)=x(epoch-1,2)+delta(1,2);
    y(epoch,:)=func(x(epoch,:));
    e(epoch)=energy(y(epoch,1),y(epoch,2));
    out=e(epoch)-e(epoch-1);
    if abs(e(epoch)-e(epoch-1))<0.0001
        break
    end
end
figure(1);
plot(y(1,1),y(1,2),'ro',y(:,1),y(:,2));
hold on;
l=length(e);
plot(y(l,1),y(l,2),'kx',y(l-1,1),y(l-1,2),'kx');
energyMatrix = zeros(l,l);
v1 = linspace(-1,1,l);
v2 = linspace(-1,1,l);
for i=1:l
    for j=1:l
        if(i==j)
            continue;
        end
        energyMatrix(i,j)=energy(v1(i),-v2(j));
    end
end
v=0:0.25:1;
figure(2)
    contour(v1,v2,energyMatrix,v,'ShowText','on');
figure(3)
    contour3(v1,v2,energyMatrix,'ShowText','on');