N0=50; % pocetni broj jedinki u populaciji
K=1000; % maksimalni broj jedinki
K0=2*K; % maksimalni broj jedniki za vreme zakupa
p=1; % prirodni prirastaj
r=p; % reproduktivna stopa
t0=1; % pocetno vreme
h=1; % korak
tmax=10; % kraj intervala
N=zeros(10,10); % matrica broja jedinki nakon svake godine i za svaku godinu zakupa
poslednje=50;


% primena Verhulstovog (logistickog) modela

for vreme_zakupa=1:1:10
    poslednje=50;
    for t=t0:h:tmax
        if vreme_zakupa<=t && vreme_zakupa+5>t
            N(vreme_zakupa,t)=K0/(1+(K0/poslednje-1)*exp(-r));
            poslednje=N(vreme_zakupa,t);
        else
            N(vreme_zakupa,t)=K/(1+(K/poslednje-1)*exp(-r));
            poslednje=N(vreme_zakupa,t);
        end
    end
end


% racunanje najveceg broja zivotinja posle 10. godine i vremena zakupa kada se ostvaruje najveci broj zivotinja posle 10. godine

max_posle_10=0;
max_i_posle_10=-1;
maksimumi=zeros(10,1);

fprintf('Broj zivotinja nakon svake godine,za svaku mogucu godinu zakupa zemljista:\n');
for i=1:10
    maksimumi(i)=N(i,end);
    if N(i,end)>max_posle_10
        max_posle_10=N(i,end);
        max_i_posle_10=i;
    end
    fprintf('N%d:[',i);
    fprintf('%.3f, ',N(i,1:end-1));
    fprintf('%.3f]\n',N(i,end));
end

fprintf('Najveci broj zivotinja posle 10 godina ce biti kada poljoprivrednik zakupi zemljiste posle %d. godine i taj broj zivotinja ce biti %.3f.\n',max_i_posle_10-1,max_posle_10);


% racunanje najveceg prosecnog broja zivotinja u toku 10 godina i vremena zakupa kada se ostvaruje najveci prosecan broj zivotinja

max_prosek=0;
max_i_prosek=-1;
suma=0;
prosek=0;
proseci=zeros(10,1);

for i=1:10
	suma=0;
	for j=1:10
		suma=suma+N(i,j);
	end
	prosek=suma/10;
    proseci(i)=prosek;
	if prosek>max_prosek
		max_prosek=prosek;
		max_i_prosek=i;
	end
end

fprintf('Najveci prosecan broj zivotinja u toku 10 godina ce biti kada poljoprivrednik zakupi zemljiste posle %d. godine i taj broj zivotinja ce biti %.3f.\n',max_i_prosek-1,max_prosek);


% grafik zavisnosti broja zivotinja tokom svih 10 godina od godine zakupa zemljista

boje={'red','green','blue','cyan','magenta','yellow','black',[0.4660 0.6740 0.1880],[0.8500 0.3250 0.0980],[0 0.4470 0.7410]};
t=t0:h:tmax;
figure
for i=1:10
	plot(t,N(i,:),'color',boje{i});
    hold on
	lgd=legend(gca);
    txt=sprintf('Zakup posle %d. godine',i-1);
    lgd.String{i}=txt;
end
lgd.Location='southeast';
set(lgd,'fontsize',8);
title('Grafik broja zivotinja tokom vremena u zavisnosti od godine zakupa');
xlabel('Godina');
ylabel('Broj zivotinja');


% bar plot prosecnog broja zivotinja u periodu od 10 godina u zavisnosti od godine zakupa zemljista

figure
b1=bar(t,proseci);
xlabel('Godina zakupa');
ylabel('Prosecan broj zivotinja');
ylim([0,1300]);
xtips1=b1(1).XEndPoints;
ytips1=b1(1).YEndPoints;
labels1=compose("%.3f",string(b1(1).YData));
text(xtips1,ytips1,labels1,'HorizontalAlignment','center','VerticalAlignment','bottom','Fontsize',7);
title('Prosecan broj zivotinja u zavisnosti od vremena zakupa');
b1.BarWidth=0.7;


% bar plot broja zivotinja posle 10. godine u zavisnosti od godine zakupa zemljista

figure
b2=bar(t,maksimumi);
xlabel('Godina zakupa');
ylabel('Broj zivotinja');
ylim([0,2200]);
xtips2=b2(1).XEndPoints;
ytips2=b2(1).YEndPoints;
labels2=compose("%.3f",string(b2(1).YData));
text(xtips2,ytips2,labels2,'HorizontalAlignment','center','VerticalAlignment','bottom','Fontsize',7);
title('Broj zivotinja posle posle 10. godine u zavisnosti od vremena zakupa');
b2.BarWidth=0.7;
