clear all;
close all;

f = 3e9 ;  % czestotoliwosc: 3 GHz
c = physconst('lightspeed'); % predkosc swiatla
lambda = c / f ; % dlugosc fali


% pojedynczy element antenowy - dipol, jego dlugosc i srednica:
antena = dipole ;
antena.Length = lambda/8 ;
antena.Width = lambda/1000 ;

% diagram kierunkowy dipola w plaszczyznie horyzontalnej:
figure;
pattern (antena, f, 0:1:360, 0) ;

% diagram promieniowania dipola 3D:
% pattern (antena, f) ;



% uklad anten-dipoli, 
% podajemy liczbe elementow w ukladzie, odstep miedzy nimi i ich przesuniecia fazowe w stopniach:
uklad_anten = linearArray('Element', antena, 'NumElements', 2, 'ElementSpacing', lambda/4, 'PhaseShift', [0 90] );

% wyswietlenie ukladu anten (rzut z gory):
figure;
layout (uklad_anten) ;

% diagram kierunkowy calego ukladu dwoch anten w plaszczyznie horyzontalnej:
figure;
pattern (uklad_anten, f, 0:1:360, 0) ;

% diagram kierunkowy calego ukladu dwoch anten 3D:
% pattern (uklad_anten, f) ;
