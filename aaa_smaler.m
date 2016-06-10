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

broj=[0:4:28 1 2]; %vektor koji odgovara gubicima u odnosu na broj kaplera

%% for -3 mmi loss
%figure(3)
for i=1:8
%hold all
Am=importdata(strcat(text1,text3,text5,int2str(i),text6));
p = polyfit(Am(:,1),Am(:,2),3);
f = polyval(p,Am(:,1));
smaller(i,:)=f;
%t=find(Am(:,1)>1.5496e-6 & Am(:,1)<1.5504e-6);
t=find(Am(:,1)==1.55e-6);
%lossm(i)=mean(f(t));
%plot(Am(:,1),f)
end
%hold off
%legend('0','4','8','12','16','20','24','28')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')


%figure(88)
%% out1 and out2 for -3
A1m=importdata('mmi-3out1_IL.csv');
A2m=importdata('mmi-3out2_IL.csv');
p1 = polyfit(A1m(:,1),A1m(:,2),4);
f1 = polyval(p1,A1m(:,1));
p2 = polyfit(A2m(:,1),A2m(:,2),4);
f2 = polyval(p2,A2m(:,1));
smaller(9,:)=(f1+f2)./2-3;
%plot(A1m(:,1),A1m(:,2),A2m(:,1),A2m(:,2),A1m(:,1),f1,A2m(:,1),f2)

%broj1=[broj(1:2) broj(4) broj(6:end)];
%lossm1=[lossm(1:2) lossm(4) lossm(6:end)];


%% MZI balanced und unbalanced for -3
Abm=importdata('MZI-3bal_IL.csv');
Aum=importdata('MZI-3unbal_IL.csv');
p = polyfit(Abm(:,1),Abm(:,2),3);
f = polyval(p,Abm(:,1));
smaller(10,:)=f;

% optimalna prava za -3
lossm=smaller(:,t)';
aa=find(lossm<30);
lossm=lossm(aa);
broj1=broj(aa);
pi = polyfit(broj1,lossm,1);
fi = polyval(pi,broj1);
figure(23)
plot(broj1,lossm,'*',broj1,fi);
xlabel('broj kaplera');
ylabel('gubici [dB]]');


figure(26)
hold all
for i=1:length(smaller(:,1))
  plot(Am(:,1),smaller(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

figure(5)
plot(Aum(:,1).*1e6,Aum(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')