function ee550hw2
% ONUR POYRAZ 2010401036
% PERCEPTRON MODEL
w=zeros(1,3);
for i=1:3
    w(i)=(rand+1)/10;
end

x=zeros(50,3);
X=zeros(50,3);
A=zeros(25,3);
B=zeros(25,3);
d=zeros(50,1);
for i=1:2:49
    for j=1:3
        X(i,j)=rand;
        x(i,j)=abs(X(i,j));
        A((i+1)/2,j)=x(i,j);
        d(i)=1;
        
        X(i+1,j)=rand;
        x(i+1,j)=-abs(X(i+1,j));
        B((i+1)/2,j)=x(i+1,j);
        d(i+1)=-1;
    end
end

while (1)
y=zeros(50,1);
Y=zeros(50,1);
e=zeros(50,1);
lf=1/length(d);
w_old=w;
    for i=1:50
        for j=1:3
            Y(i,1)=Y(i,1)+x(i,j).*w(j);
        end
        if Y(i,1)>0
            y(i,1)=1;
        else
            y(i,1)=-1;
        end
        e(i,1)=d(i,1)-y(i,1);
        for j=1:3
            w(j)=w(j)+ lf.*(e(i).*x(i,j));
        end
    end
    if w==w_old
        break;
    end
end

normal=w;
[xx,yy]=ndgrid(-1:1,-1:1);
z=(-normal(1)*xx - normal(2)*yy)/normal(3);

figure
surf(xx,yy,z)
hold on;
plot3(A(:,1),A(:,2),A(:,3),'bo'); 
hold on;
plot3(B(:,1),B(:,2),B(:,3),'rx'); 
hold on;
xlabel('\it x1');
ylabel('\it x2');
zlabel('\it x3');
title('Perceptron Learning Model');
legend('Perceptron Decision Layer','Class A Sample Vector (1st Quadrant)','Class B Sample Vector (8th Quadrant)')
