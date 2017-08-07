clc;
close all;
clearvars;


%% Ausgangsparameter

prompt = {'Anfangstag eingeben:','Endtag eingeben:', 'Sensor ID: Pippo 957205 Stefan 750396'};
dlg_title = 'Zeitabschnitt';
num_lines = 1;
defaultans = {'yyyy-mm-dd',datestr(datetime('today'),'yyyy-mm-dd'),'750396'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);



start = datetime(answer{1},'InputFormat','yyyy-MM-dd'); % Startzeit
ende =  datetime(answer{2},'InputFormat','yyyy-MM-dd'); % Endzeit
sensor = answer{3};
%% Werte Leer Anlegen
Time = [];
PM10 = [];
PM25 = [];
Temperatur = [];
Luftfeuchtigkeit = [];
WlanSignal = [];
CSV = {};
NichtGeladen = 0;
Anzahl = days(ende-start);


%% Einlesen der Werte
k = waitbar(0,'Lade Tage...');
for i = 0:Anzahl
  waitbar(i / Anzahl)  
  Tag = start + i;
  
  % Herunterladen
  url = strcat('http://www.madavi.de/sensor/data/data-esp8266-',sensor,'-',datestr(Tag,'yyyy-mm-dd'),'.csv');
    
  
  try % Falls Tag nicht geladen werden kann
  CSV = webread(url);
   
  % Speichere ab 
  Time = [Time;datetime(table2cell(CSV(:,1)),'InputFormat','yyyy/MM/dd HH:mm:ss')];
  PM10 = [PM10;table2array(CSV(:,8))];
  PM25 = [PM25;table2array(CSV(:,9))];
  Temperatur = [Temperatur;table2array(CSV(:,10))];
  Luftfeuchtigkeit = [Luftfeuchtigkeit;table2array(CSV(:,11))];
  WlanSignal = [WlanSignal;table2array(CSV(:,20))];
  
  catch
  NichtGeladen = NichtGeladen +1;
      
  end
  
end
close(k);
%Aufgrund Rechenleistung
clear CSV;

    %Warnung, wenn nicht alle Tage geladen
    if NichtGeladen ~=0
        if NichtGeladen == 1
             f =  warndlg(strcat(num2str(NichtGeladen),' Tag nicht geladen'));
        else
             f =  warndlg(strcat(num2str(NichtGeladen),' Tage nicht geladen'));
        end
    drawnow     % Necessary to print the message
    waitfor(f);
    end

    
% Füge bei Lücken NaN ein, sodass kein durchgezogener Strich    
a =  diff(Time)> duration(0,10,0);
PM10(a) = NaN;
PM25(a) = NaN;
Temperatur(a) = NaN;
Luftfeuchtigkeit(a) = NaN;
WlanSignal(a) = NaN;

%% Plot

global z1;
global z2;
global z3;
global z4;

figure('units','normalized','outerposition',[0 0 1 1])
z1 = subplot(2,2,1);
plot(Time, PM10, 'b')
hold on;
plot(Time, PM25,'r')
xlabel('Zeit [GMT]')
ylabel('\mu g/m^3')
legend('PM10','PM2.5')
set(gca,'xGrid','on')
title('Original Daten')


z2 = subplot(2,2,2);
plot(Time, PM10, 'b')
hold on;
plot(Time, PM25,'r')
ylim([0,20]);
xlabel('Zeit [GMT]')
ylabel('\mu g/m^3')
set(gca,'xGrid','on')
title('Datenausschnitt')

z3 = subplot(2,2,3);
Filter = fspecial('average',[1,9]);
PM10blur = conv(PM10,Filter,'same');
PM25blur = conv(PM25,Filter,'same');
plot(Time, PM10blur, 'b')
hold on;
plot(Time, PM25blur,'r')
ylim([0,20]);
xlabel('Zeit [GMT]')
ylabel('\mu g/m^3')
set(gca,'xGrid','on')
title('Daten mit 9er Boxfilter geglättet')

z4 = subplot(2,2,4);
yyaxis right
plot(Time, Temperatur, 'r')
ylabel('Temperatur [°C]')
hold on;
yyaxis left
plot(Time, Luftfeuchtigkeit,'b')
xlabel('Zeit [GMT]')
ylabel('Luftfeuchtigkeit')
set(gca,'xGrid','on')
title('Weitere Daten')


Anzeige3




