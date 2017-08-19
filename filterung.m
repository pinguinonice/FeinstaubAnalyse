function  filterung( Anfang, Ende )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

global PM10;
global PM25;
global Time;
global hFig;
global z3;
[~, Anfangspunkt] = min(abs(datenum(Time)-datenum(Anfang)));
[~, Endpunkt] = min(abs(datenum(Time)-datenum(Ende)));


Laenge = Endpunkt- Anfangspunkt;
set(0,'CurrentFigure',hFig);
subplot(z3);
hold off;
Filter = fspecial('average',[1,floor(Laenge/200)]);
PM10blur = conv(PM10,Filter,'same');
PM25blur = conv(PM25,Filter,'same');
title(strcat('Daten mit',{' '},num2str(floor(Laenge/200)),'er Boxfilter geglättet'))
plot(Time, PM10blur, 'b')
hold on;
plot(Time, PM25blur,'r')
%Zwischen = PM10;
%Zwischen(PM10<200) = NaN;
%ylim([nanmean(Zwischen(Anfangspunkt:Endpunkt))-2*nanstd(Zwischen(Anfangspunkt:Endpunkt)),nanmean(Zwischen(Anfangspunkt:Endpunkt))+2*nanstd(Zwischen(Anfangspunkt:Endpunkt))])



end

