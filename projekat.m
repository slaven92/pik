clear all
clc
close all

set (0, "defaultaxesfontname", "/usr/share/fonts/truetype/msttcorefonts/arial.ttf")
set (0, "defaultaxesfontsize", 12)
set (0, "defaulttextfontname", "arial")
set (0, "defaulttextfontsize", 5) 

text1='mmi';
text2='MZI';
text3='-3';
text4='3';
text5='loss';
text6='_IL.csv';

broj=[0:4:28 1 2];
%% for original mmi loss
figure(1)
hold all
for i=1:8
Ai=importdata(strcat(text1,text5,int2str(i),text6));
%t=find(Ai(:,1)>1.5496e-6 & Ai(:,1)<1.5504e-6);
p = polyfit(Ai(:,1),Ai(:,2),3);
f = polyval(p,Ai(:,1));
orig(i,:)=f;
t=find(Ai(:,1)==1.55e-6);
lossi(i)=mean(f(t));
%plot(Ai(:,1),Ai(:,2),Ai(:,1),f)
plot(Ai(:,1).*1e6,f)
end
hold off
legend('0','4','8','12','16','20','24','28')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

figure(2)
%% out1 and out2 for original
A1i=importdata('mmi3out1_IL.csv');
A2i=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1i(:,1),A1i(:,2),3);
f1 = polyval(p1,A2i(:,1));
p2 = polyfit(A2i(:,1),A2i(:,2),3);
f2 = polyval(p2,A2i(:,1));
orig(9,:)=(f1+f2)./2-3;
plot(A1i(:,1).*1e6,A1i(:,2),A2i(:,1).*1e6,A2i(:,2),A1i(:,1).*1e6,f1,A2i(:,1).*1e6,f2)
legend('izlaz 1','izlaz 2')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

figure(22)%zumirano
plot(A1i(:,1).*1e6,f1,A2i(:,1).*1e6,f2)
legend('izlaz 1','izlaz 2')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')
xlim([1.549 1.551]);
ylim([17.2 17.6]);


%% MZI balanced und unbalanced for original
Abi=importdata('MZIbal_IL.csv');
Aui=importdata('MZIunbal_IL.csv');
p = polyfit(Abi(:,1),Abi(:,2),3);
f = polyval(p1,Abi(:,1));
orig(10,:)=f;

%% optimalna prava za original

lossi=orig(:,t)';
aa=find(lossi<30);
lossi=lossi(aa);
broj1=broj(aa);
pi = polyfit(broj1,lossi,1);
fi = polyval(pi,broj1);
figure(23)
plot(broj1,lossi,'*',broj1,fi);
xlabel('broj kaplera');
ylabel('gubici [dB]]');















%% for -3 mmi loss
figure(3)
for i=1:8
hold all
Am=importdata(strcat(text1,text3,text5,int2str(i),text6));
p = polyfit(Am(:,1),Am(:,2),3);
f = polyval(p,Am(:,1));
smaller(i,:)=f;
%t=find(Am(:,1)>1.5496e-6 & Am(:,1)<1.5504e-6);
t=find(Am(:,1)==1.55e-6);
lossm(i)=mean(f(t));
plot(Am(:,1),f)
end
hold off
hold off
legend('0','4','8','12','16','20','24','28')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')


figure(88)
%% out1 and out2 for -3
A1m=importdata('mmi-3out1_IL.csv');
A2m=importdata('mmi-3out2_IL.csv');
p1 = polyfit(A1m(:,1),A1m(:,2),4);
f1 = polyval(p1,A1m(:,1));
p2 = polyfit(A2m(:,1),A2m(:,2),4);
f2 = polyval(p2,A2m(:,1));
smaller(9,:)=(f1+f2)./2-3;
plot(A1m(:,1),A1m(:,2),A2m(:,1),A2m(:,2),A1m(:,1),f1,A2m(:,1),f2)

broj1=[broj(1:2) broj(4) broj(6:end)];
lossm1=[lossm(1:2) lossm(4) lossm(6:end)];


%% MZI balanced und unbalanced for -3
Abm=importdata('MZI-3bal_IL.csv');
Aum=importdata('MZI-3unbal_IL.csv');
p = polyfit(Abm(:,1),Abm(:,2),3);
f = polyval(p,Abm(:,1));
smaller(10,:)=f;














%% for +3 mmi loss
figure(4)
hold all
for i=1:8
Ap=importdata(strcat(text1,text4,text5,int2str(i),text6));
%t=find(Ap(:,1)>1.5496e-6 & Ap(:,1)<1.5504e-6);
t=find(Ap(:,1)==1.55e-6);
p = polyfit(Ap(:,1),Ap(:,2),4);
f = polyval(p,Ap(:,1));
bigger(i,:)=f;
lossp(i)=mean(f(t));
plot(Ap(:,1),f)
end
hold off
legend('0','4','8','12','16','20','24','28')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')






%% out1 and out2 for +3
A1p=importdata('mmi3out1_IL.csv');
A2p=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1p(:,1),A1p(:,2),2);
f1 = polyval(p1,A2p(:,1));
p2 = polyfit(A2p(:,1),A2p(:,2),2);
f2 = polyval(p2,A2p(:,1));
bigger(9,:)=(f1+f2)./2-3;
plot(A1p(:,1),A1p(:,2),A2p(:,1),A2p(:,2),A1p(:,1),f1,A2p(:,1),f2)

%% MZI balanced und unbalanced for 3
Abp=importdata('MZI3bal_IL.csv');
Aup=importdata('MZI3unbal_IL.csv');
p = polyfit(Abp(:,1),Abp(:,2),3);
f = polyval(p,Abp(:,1));
bigger(10,:)=f;

%% optimalna prava za +3
lossp=bigger(:,t)';
aa=find(lossp<30);
lossp=lossp(aa);
broj1=broj(aa);
pp = polyfit(broj1,lossp,1);
fp = polyval(pp,broj1);
figure(664)
plot(broj1,lossp,'*',broj1,fp);
xlabel('broj kaplera');
ylabel('gubici [dB]]');












figure(5)
plot(Aum(:,1).*1e6,Aum(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')


figure(6)
plot(Aup(:,1).*1e6,Aup(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')


figure(7)

plot(Aui(:,1).*1e6,Aui(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

