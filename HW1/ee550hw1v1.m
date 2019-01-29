function ee550hw1v1
% HOPFÝELD
one   = [-1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 -1 -1 1 1 -1 -1 -1 -1 -1];
two   = [1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1];
three = [-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 -1 -1];
four  = [-1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 -1 -1 1 -1 -1 -1 -1 1 1 1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 1 -1 -1 -1 -1 -1 -1 -1 -1];
X = [ one ; two ; three ; four ];

figure(1);
plotstablestate(X);
T=zeros(64);
for i=1:64
    for j=1:64
        if i==j
            T(i,j) = 0;
        else
            T(i,j) = one(i)*one(j) + two(i)*two(j) + three(i)*three(j) + four(i)*four(j);
        end
    end
end
x = three;
for i=1:64
    if x(i)==1
        R = normrnd(0,1);
        x(i) = x(i) + R;
        if x(i)>=0
            x(i)=1;
        else
            x(i)=-1;
        end
    end
end
figure(2);
plothopfied(x);
k=2;
xplus= zeros(1,64);
while (1)
    for j=1:64
        sum=0;
        for i=1:64
            sum = sum + T(i,j)*x(i);
        end
        
        if sum>=0
            xplus(j)=1;
        else
            xplus(j)=-1;
        end
    end
    if (all(x==xplus))
        break;    
    end
    x=xplus;
    
    k=k+1;
    figure(k);
    plothopfied(x);
end

function plotstablestate(X)
samplerpatterns = size(X,1);
rows = sqrt(samplerpatterns);
cols = samplerpatterns/rows;
for i=1:samplerpatterns
   subplot(rows, cols, i);
   axis equal;
   plothopfied(X(i,:))
end

function plothopfied(x)
neurons = length(x);
rows = sqrt(neurons);
cols = neurons/rows;
for m=1:rows
   for n=1:cols
      neuronnumber = rows*(m-1)+n;
      if neuronnumber > neurons
         break;
      elseif x(neuronnumber)==1
         rectangle('Position', [n-1 rows-m 1 1], 'FaceColor', 'k');
      elseif x(neuronnumber)==-1
         rectangle('Position', [n-1 rows-m 1 1], 'FaceColor', 'w');         
      end
   end
end
set(gca, 'XLim', [0 cols], 'XTick', []);
set(gca, 'YLim', [0 rows], 'YTick', []);
