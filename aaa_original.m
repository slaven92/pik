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

%% for original mmi loss
for i=1:8
Ai=importdata(strcat(text1,text5,int2str(i),text6));
%t=find(Ai(:,1)>1.5496e-6 & Ai(:,1)<1.5504e-6);
p = polyfit(Ai(:,1),Ai(:,2),3);
f = polyval(p,Ai(:,1));
orig(i,:)=f;
t=find(Ai(:,1)==1.55e-6);
%lossi(i)=mean(f(t));
%plot(Ai(:,1),Ai(:,2),Ai(:,1),f)
%plot(Ai(:,1).*1e6,f)
end
%legend('0','4','8','12','16','20','24','28')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')


%figure(2)
%% out1 and out2 for original
A1i=importdata('mmi3out1_IL.csv');
A2i=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1i(:,1),A1i(:,2),3);
f1 = polyval(p1,A2i(:,1));
p2 = polyfit(A2i(:,1),A2i(:,2),3);
f2 = polyval(p2,A2i(:,1));
orig(9,:)=(f1+f2)./2-3;
%plot(A1i(:,1).*1e6,A1i(:,2),A2i(:,1).*1e6,A2i(:,2),A1i(:,1).*1e6,f1,A2i(:,1).*1e6,f2)
%legend('izlaz 1','izlaz 2')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')

%figure(22) %zumirano
%plot(A1i(:,1).*1e6,f1,A2i(:,1).*1e6,f2)
%legend('izlaz 1','izlaz 2')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')
%xlim([1.549 1.551]);
%ylim([17.2 17.6]);


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



figure(26)
hold all
for i=1:length(orig(:,1))
  plot(Ai(:,1),orig(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

figure(7)

plot(Aui(:,1).*1e6,Aui(:,2));
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')