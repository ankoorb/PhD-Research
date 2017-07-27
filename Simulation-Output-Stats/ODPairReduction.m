clc;
clear all;

ODPair = load('ODPair.csv') % OD Pair file with 1st col: Orid, 2nd col: Des
[r,c] = size(ODPair);
alpha = 0.5 % Reduction percent

for g=23:52
    s1=int2str(g);
    s2=strcat('demands_',s1,'.txt');
    Ankoor=load(s2);
    [p,q] = size(Ankoor);
    
      for i = 1:r
        for j = 1:p
            if Ankoor(j,1)==ODPair(i,1) % Searching for Ori
                if Ankoor(j,2)==ODPair(i,2) % Searching for Des
                    for class = 1:6
                        Ankoor(j,class+2)=Ankoor(j,class+2)*alpha; % Applying reduction
                    end
                    break
                end
            end
        end
      end
      
    s3=strcat('demands_',s1,'.txt');
    dlmwrite(s3,Ankoor,'delimiter',',','newline','pc');
    
end