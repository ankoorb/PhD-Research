
function transmodeler

clear
clc
N1=11;
N2=11;
dt=1;
M1=100;
avgEmission_Tog=zeros(M1,1);
avgEmission_Nox=zeros(M1,1);
avgEmission_Co2=zeros(M1,1);
avgEmission_Pm10=zeros(M1,1);


for i=N1:N2
    s=num2str(i);
    s1=strcat(s,'.csv');
    data=csvread(s1);
    
    emission_Tog=zeros(M1,1);
    emission_Nox=zeros(M1,1);
    emission_Co2=zeros(M1,1);
    emission_Pm10=zeros(M1,1);
    
    M2=4000;
    tem_time=zeros(M2,1);
    tem_Tog=zeros(M2,1);
    tem_Nox=zeros(M2,1);
    tem_Co2=zeros(M2,1);
    tem_Pm10=zeros(M2,1);
    size1=size(data);
    row=size1(1);
    
    numTimeStep=1;
    for j=1:row	 
         symbol=0;
         for k=1:numTimeStep
             if(tem_time(k,1)==data(j,1))
                 currentStep=k;
                 symbol=1;
                 break;
             end
         end

         if (symbol==0)
             tem_time(numTimeStep,1)=data(j,1);
             currentStep=numTimeStep;
             numTimeStep=numTimeStep+1;
         end
         [coeffTog,coeffNox,coeffCo2,coeffPM10]=emissionEMFAC(data(j,2));
         tem_Tog(currentStep,1)=tem_Tog(currentStep,1)+dt*coeffTog*data(j,2);
         tem_Nox(currentStep,1)=tem_Nox(currentStep,1)+dt*coeffNox*data(j,2);
         tem_Co2(currentStep,1)=tem_Co2(currentStep,1)+dt*coeffCo2*data(j,2);
         tem_Pm10(currentStep,1)=tem_Pm10(currentStep,1)+dt*coeffPM10*data(j,2);
    end
	
    minTimeStep=tem_time(1,1);
    maxTimeStep=tem_time(1,1);
    numTimeStep=numTimeStep-1;
    
    for j=1:numTimeStep
        if(minTimeStep>tem_time(j,1))
            minTimeStep=tem_time(j,1);
        end
        if(maxTimeStep<tem_time(j,1))
            maxTimeStep=tem_time(j,1);
        end
    end
    totalMinute=floor((maxTimeStep-minTimeStep)/60)+1;
    
    for j=1:totalMinute
        for k=1:numTimeStep
            if(tem_time(k,1)>minTimeStep+(j-1)*60&&tem_time(k,1)<minTimeStep+j*60)
                emission_Tog(j,1)=emission_Tog(j,1)+tem_Tog(k,1);
                emission_Nox(j,1)=emission_Nox(j,1)+tem_Nox(k,1);
                emission_Co2(j,1)=emission_Co2(j,1)+tem_Co2(k,1);
                emission_Pm10(j,1)=emission_Pm10(j,1)+tem_Pm10(k,1);
            end
        end
    end
    
    for j=1:totalMinute
        emission_Tog(j,1)=emission_Tog(j,1)/3600;
        emission_Nox(j,1)=emission_Nox(j,1)/3600;
        emission_Co2(j,1)=emission_Co2(j,1)/3600;
        emission_Pm10(j,1)=emission_Pm10(j,1)/3600;
    end
    for j=1:totalMinute
        avgEmission_Tog(j,1)=avgEmission_Tog(j,1)+emission_Tog(j,1);
		avgEmission_Nox(j,1)=avgEmission_Nox(j,1)+emission_Nox(j,1);
		avgEmission_Co2(j,1)=avgEmission_Co2(j,1)+emission_Co2(j,1);
		avgEmission_Pm10(j,1)=avgEmission_Pm10(j,1)+emission_Pm10(j,1);
    end
    
    emission1=zeros(totalMinute,4);
    for t=1:totalMinute
        emission1(t,1)=emission_Tog(t,1);
        emission1(t,2)=emission_Nox(t,1);
        emission1(t,3)=emission_Co2(t,1);
        emission1(t,4)=emission_Pm10(t,1);
    end
    
    s2=strcat('emission',s,'.xlsx');   
    xlswrite(s2,emission1);
    
    clear data;
    clear  emission_Tog;
    clear  emission_Nox;
    clear  emission_Co2;
    clear  emission_Pm10;
    clear  tem_time;
    clear  tem_Tog;
    clear  tem_Nox;
    clear  tem_Co2;
    clear  tem_Pm10;
    clear emission1;
end
        
for i=1:totalMinute
   avgEmission_Tog(i,1)=avgEmission_Tog(i,1)/(N2-N1+1);
   avgEmission_Nox(i,1)=avgEmission_Nox(i,1)/(N2-N1+1);
   avgEmission_Co2(i,1)=avgEmission_Co2(i,1)/(N2-N1+1);
   avgEmission_Pm10(i,1)=avgEmission_Pm10(i,1)/(N2-N1+1); 
end

emission=zeros(totalMinute,4);
for i=1:totalMinute
   emission(i,1)=avgEmission_Tog(i,1);
   emission(i,2)=avgEmission_Nox(i,1);
   emission(i,3)=avgEmission_Co2(i,1);
   emission(i,4)=avgEmission_Pm10(i,1);
end

xlswrite('Average_Emission.xlsx',emission);

end



function [coeffTog,coeffNox,coeffCo2,coeffPM10]=emissionEMFAC(speed)    
    
    N=21;
	YP1=1*10^30;
	YPN=1*10^30;
    %speed matrix
	speedMatrix=[0,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90];
    %emission factors
	tog=[0.953,0.927,0.881,0.839,0.534,0.343,0.24,0.189,0.154,0.132,0.117,0.11,0.109,0.114,0.126,0.145,0.152,0.161,0.173,0.187,0.203];
	co2=[1552.085,1512.686,1438.809,1370.99,1028.392,805.58,658.158,563.004,499.993,460.234,438.488,431.891,439.299,461.025,498.94,556.952,562.644,569.848,580.533,599.028,633.956];
	nox=[1.225,1.22,1.209,1.199,0.912,0.73,0.644,0.607,0.581,0.566,0.561,0.564,0.579,0.604,0.644,0.702,0.764,0.853,0.983,1.177,1.476];
	pm10=[0.153,0.149,0.142,0.135,0.091,0.062,0.045,0.036,0.03,0.026,0.024,0.023,0.023,0.025,0.028,0.033,0.037,0.041,0.046,0.052,0.059];

	if (speed==0)
		coeffTog=0;
		coeffNox=0;
		coeffCo2=0;
		coeffPM10=0;
    elseif (speed>0 && speed<90)
		[Y2]=cubicSpline(speedMatrix,tog,N,YP1,YPN);
		[coeffTog]=cubicSplint(speedMatrix,tog,Y2,N,speed);

		[Y2]=cubicSpline(speedMatrix,nox,N,YP1,YPN);
		[coeffNox]=cubicSplint(speedMatrix,nox,Y2,N,speed);

		[Y2]=cubicSpline(speedMatrix,co2,N,YP1,YPN);
		[coeffCo2]=cubicSplint(speedMatrix,co2,Y2,N,speed);

		[Y2]=cubicSpline(speedMatrix,pm10,N,YP1,YPN);
		[coeffPM10]=cubicSplint(speedMatrix,pm10,Y2,N,speed);
    else
		coeffTog=tog(N);
		coeffNox=nox(N);
		coeffCo2=co2(N);
		coeffPM10=pm10(N);
    end
end

function [Y2]=cubicSpline(X,Y,N,YP1,YPN)
	Nmax=100;
	if(YP1>=1*10^30)
		Y2(1)=0;
		U(1)=0;
    else
		Y2(1)=-0.5;
		U(1)=(3/(X(2)-X(1)))*((Y(2)-Y(1))/(X(2)-X(1))-YP1);
    end 
    
	for i=2:N-1
		SIG=(X(i)-X(i-1))/(X(i+1)-X(i-1));
		P=SIG*Y2(i-1)+2;
		Y2(i)=(SIG-1)/P;
		U(i)=(6*((Y(i+1)-Y(i))/(X(i+1)-X(i))-(Y(i)-Y(i-1))/(X(i)-X(i-1)))/(X(i+1)-X(i-1))-SIG*U(i-1))/P;
    end
    
	if(YPN>=1*10^30)
		QN=0;
		UN=0;
    else
		QN=0.5;
		UN=(3/(X(N)-X(N-1)))*(YPN-(Y(N)-Y(N-1))/(X(N)-X(N-1)));
    end
    
	Y2(N)=(UN-QN*U(N-1))/(QN*Y2(N-1)+1);
    
	for i=N-1:-1:1  
		Y2(i)=Y2(i)*Y2(i+1)+U(i);
    end
end
    

function [Y]=cubicSplint(XA,YA,Y2A,N,X)
	KLO=1;
	KHI=N;
	    
	while((KHI-KLO)>1)
		K=floor((KHI+KLO)/2);
		if(XA(K)>X)
			KHI=K;
        else
			KLO=K;
        end
    end
    
	H=XA(KHI)-XA(KLO);
	if(H==0)
		disp('Bad XA input');
    end
	A=(XA(KHI)-X)/H;
	B=(X-XA(KLO))/H;
	Y=A*YA(KLO)+B*YA(KHI)+((A^3-A)*Y2A(KLO)+(B^3-B)*Y2A(KHI))*(H^2)/6;
end

