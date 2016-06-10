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
lamfull=importdata(strcat(text1,text5,int2str(1),text6));
lam=lamfull(1:faktor:end,1).*1e6;

%% for original mmi loss
for i=1:8
Ai=importdata(strcat(text1,text5,int2str(i),text6));
p = polyfit(Ai(:,1),Ai(:,2),3);
f = polyval(p,Ai(:,1));
orig(i,:)=f(1:faktor:end);
end


%% out1 and out2 for original
A1i=importdata('mmi3out1_IL.csv');
A2i=importdata('mmi3out2_IL.csv');
p1 = polyfit(A1i(:,1),A1i(:,2),3);
f1 = polyval(p1,A2i(:,1));
p2 = polyfit(A2i(:,1),A2i(:,2),3);
f2 = polyval(p2,A2i(:,1));
orig(9,:)=(f1(1:faktor:end)+f2(1:faktor:end))./2-3;


%% MZI balanced und unbalanced for original
Abi=importdata('MZIbal_IL.csv');
Aui=importdata('MZIunbal_IL.csv');
p = polyfit(Abi(:,1),Abi(:,2),3);
f = polyval(p1,Abi(:,1));
orig(10,:)=f(1:faktor:end);



%% optimalna prava za original
loss_spectrum=zeros(2,0);%gornji red nagiib prave, donji vrednost u nuli

for j=1:length(lam)
lossi=orig(:,j)';
pi = polyfit(broj,lossi,1);
fi = polyval(pi,broj);
loss_spectrum(:,end+1)=pi';
end


% plot spektar gubitaka po kapleru
figure(23)
plot(lam,loss_spectrum(1,:),[1.55 1.55],[1.67 1.69]);
xlabel('talasna duzina[μm]');
ylabel('gubici po kapleru[dB]]');


% plot spektar gubitaka sprezanja
figure(24)
plot(lam,loss_spectrum(2,:),[1.55 1.55],[10 12]);
xlabel('talasna duzina[μm]');
ylabel('gubici sprezanja[dB]]');


% plot srednji gubici po talasnoj duzini
figure(26)
hold all
for i=1:length(orig(:,1))
  plot(lam,orig(i,:))
end
hold off
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')
legend('0','4','8','12','16','20','24','28','1','2')

% plot unbalanced MZI korigovano
figure(7)
normal=Aui(1:faktor:end,2)'-loss_spectrum(2,:);
plot(lam,normal);
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')

% plot za out1 i out2 na jednom grafiku sa fitovanim vrednostima
figure(5)
plot(lam,A1i(1:faktor:end,2),lam,A2i(1:faktor:end,2),lam,f1(1:faktor:end),lam,f2(1:faktor:end))
legend('izlaz 1','izlaz 2','fitovan izlaz 1','fitovan izlaz 2')
xlabel('talasna dužina [μm]')
ylabel('gubici [dB]')


%figure(22) %zumirano
%plot(A1i(:,1).*1e6,f1,A2i(:,1).*1e6,f2)
%legend('izlaz 1','izlaz 2')
%xlabel('talasna dužina [μm]')
%ylabel('gubici [dB]')
%xlim([1.549 1.551]);
%ylim([17.2 17.6]);

%plot za imbalance
figure(10)
imbalance=10*log10(f1(1:faktor:end)./f2(1:faktor:end));
plot(lam,imbalance,lam,zeros(1,length(lam)),[1.55 1.55],[0 0.1])
xlabel('talasna dužina [μm]')
ylabel('odnos snaga na izlazima [dB]')