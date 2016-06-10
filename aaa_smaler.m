clear all
clc
close all

set (0, "defaultaxesfontname", "/usr/share/fonts/truetype/msttcorefonts/arial.ttf")
set (0, "defaultaxesfontsize", 14)
set (0, "defaulttextfontname", "arial")
set (0, "defaulttextfontsize", 5) 
text1='mmi';
text2='MZI';
text3='-3';
text4='3';
text5='loss';
text6='_IL.csv';

%posto ima puno podataka, treba uvesti faktor koji smanjuje broj podataka
faktor=3;

%vektor koji odgovara gubicima u odnosu na broj kaplera
broj=[0:4:28 1 2];

%talasna duzina
lamfull=importdata(strcat(text1,text3,text5,int2str(1),text6));
lam=lamfull(1:faktor:end,1).*1e6;


for i=1:8
Am=importdata(strcat(text1,text3,text5,int2str(i),text6));
p = polyfit(Am(:,1),Am(:,2),3);
f = polyval(p,Am(:,1));
smaller(i,:)=f(1:faktor:end,1);
end


%% out1 and out2 for -3
A1m=importdata('mmi-3out1_IL.csv');
A2m=importdata('mmi-3out2_IL.csv');
p1 = polyfit(A1m(:,1),A1m(:,2),4);
f1 = polyval(p1,A1m(:,1));
p2 = polyfit(A2m(:,1),A2m(:,2),4);
f2 = polyval(p2,A2m(:,1));
smaller(9,:)=(f1(1:faktor:end,1)+f2(1:faktor:end,1))./2-3;


%% MZI balanced und unbalanced for -3
Abm=importdata('MZI-3bal_IL.csv');
Aum=importdata('MZI-3unbal_IL.csv');
p = polyfit(Abm(:,1),Abm(:,2),3);
f = polyval(p,Abm(:,1));
smaller(10,:)=f(1:faktor:end,1);

%% optimalna prava za +3
loss_spectrum=zeros(2,0);%gornji red nagiib prave, donji vrednost u nuli

for j=1:length(lam)
lossm=smaller(:,j)';
pm = polyfit(broj,lossm,1);
fm = polyval(pm,broj);
loss_spectrum(:,end+1)=pm';
end


% plot spektar gubitaka po kapleru
figure(23)
plot(lam,loss_spectrum(1,:),[1.55 1.55],[1.72 1.78]);
xlabel('talasna duzina[μm]');
ylabel('gubici po kapleru[dB]]');

% plot spektar gubitaka sprezanja
figure(24)
plot(lam,loss_spectrum(2,:),[1.55 1.55],[14.9 18]);
xlabel('talasna duzina[μm]');
ylabel('gubici sprezanja[dB]]');

% plot srednji gubici po talasnoj duzini
figure(26)
hold all
for i=1:length(smaller(:,1))
  plot(lam,smaller(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')
legend('0','4','8','12','16','20','24','28','1','2')

% plot unbalanced MZI korigovano
figure(7)
normal=Aum(1:faktor:end,2)'-loss_spectrum(2,:);
plot(lam,normal);
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

%plot za imbalance
figure(10)
imbalance=10*log10(f1(1:faktor:end)./f2(1:faktor:end));
plot(lam,imbalance,lam,zeros(1,length(lam)),[1.55 1.55],[0.2 0.32])
xlabel('talasna dužina [μm]')
ylabel('odnos snaga na izlazima [dB]')