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
lamfull=importdata(strcat(text1,text4,text5,int2str(1),text6));
lam=lamfull(1:faktor:end,1).*1e6;

% for +3 mmi loss
for i=1:8
Ap=importdata(strcat(text1,text4,text5,int2str(i),text6));
p = polyfit(Ap(:,1),Ap(:,2),3);
f = polyval(p,Ap(:,1));
bigger(i,:)=f(1:faktor:end);
end



%% out1 and out2 for +3
A1p=importdata('mmi3out1_IL.csv');
A2p=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1p(:,1),A1p(:,2),2);
f1 = polyval(p1,A2p(:,1));
p2 = polyfit(A2p(:,1),A2p(:,2),2);
f2 = polyval(p2,A2p(:,1));
bigger(9,:)=(f1(1:faktor:end)+f2(1:faktor:end))./2-3;


%% MZI balanced und unbalanced for 3
Abp=importdata('MZI3bal_IL.csv');
Aup=importdata('MZI3unbal_IL.csv');
p = polyfit(Abp(:,1),Abp(:,2),3);
f = polyval(p,Abp(:,1));
bigger(10,:)=f(1:faktor:end);

%% optimalna prava za +3
loss_spectrum=zeros(2,0);%gornji red nagiib prave, donji vrednost u nuli

for j=1:length(lam)
lossp=bigger(:,j)';
pp = polyfit(broj,lossp,1);
fp = polyval(pp,broj);
loss_spectrum(:,end+1)=pp';
end

% plot spektar gubitaka po kapleru
figure(23)
plot(lam,loss_spectrum(1,:),[1.55 1.55],[1.505 1.6]);
xlabel('talasna duzina[μm]');
ylabel('gubici po kapleru[dB]]');

% plot spektar gubitaka sprezanja
figure(24)
plot(lam,loss_spectrum(2,:),[1.55 1.55],[15.5 18]);
xlabel('talasna duzina[μm]');
ylabel('gubici sprezanja[dB]]');

% plot srednji gubici po talasnoj duzini
figure(26)
hold all
for i=1:length(bigger(:,1))
  plot(lam,bigger(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')
legend('0','4','8','12','16','20','24','28','1','2')

% plot unbalanced MZI korigovano
figure(7)
normal=Aup(1:faktor:end,2)'-loss_spectrum(2,:);
plot(lam,normal);
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

%plot za imbalance
figure(10)
imbalance=10*log10(f1(1:faktor:end)./f2(1:faktor:end));
plot(lam,imbalance,lam,zeros(1,length(lam)),[1.55 1.55],[0.02 0.07])
xlabel('talasna dužina [μm]')
ylabel('odnos snaga na izlazima [dB]')