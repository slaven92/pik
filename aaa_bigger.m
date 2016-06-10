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

% for +3 mmi loss
%figure(4)
%hold all
for i=1:8
Ap=importdata(strcat(text1,text4,text5,int2str(i),text6));
%t=find(Ap(:,1)>1.5496e-6 & Ap(:,1)<1.5504e-6);
t=find(Ap(:,1)==1.55e-6);
p = polyfit(Ap(:,1),Ap(:,2),4);
f = polyval(p,Ap(:,1));
bigger(i,:)=f;
%lossp(i)=mean(f(t));
%plot(Ap(:,1),f)
end
%hold off
%legend('0','4','8','12','16','20','24','28')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')






%% out1 and out2 for +3
A1p=importdata('mmi3out1_IL.csv');
A2p=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1p(:,1),A1p(:,2),2);
f1 = polyval(p1,A2p(:,1));
p2 = polyfit(A2p(:,1),A2p(:,2),2);
f2 = polyval(p2,A2p(:,1));
bigger(9,:)=(f1+f2)./2-3;
%plot(A1p(:,1),A1p(:,2),A2p(:,1),A2p(:,2),A1p(:,1),f1,A2p(:,1),f2)

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


figure(26)
hold all
for i=1:length(bigger(:,1))
  plot(Ap(:,1),bigger(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

figure(6)
plot(Aup(:,1).*1e6,Aup(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')