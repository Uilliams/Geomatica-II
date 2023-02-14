
cd('C:\Users\pazui\OneDrive\Documentos\Geomatica II\Aula_02_Plot_Vet_Trans\Dados')

%% Plotando e observando transsector
%% Lembra de dar um setppath na parte NCtoolsbox-20130305 e rodar a rotina setup_nctoolbox.m

ncdisp('oceanset_his.nc'); % Lendo os dados

% Acessando os dados
url='oceanset_his.nc';

% Limitando lon lat
latlim = [-40 -25];
lonlim = [-60 -40];

%% Pegando os dados de temperatura
itime=1;
[data,grd] = nj_tslice(url,'temp',itime); % Armazenando os dados (data) e coordenadas (grd)

%% Plotando a temperatura de superfície 
figure;
pcolorjw(grd.lon,grd.lat,double(data(end,:,:))); % Extraindo os dados de superfície (camada 21 = end):lon:lat
colorbar

%% Criando uma seção transversal vertical especificando a trilha lon lat
track=[   -50.0   -36.0
   -51.5   -36.0
   -53.0   -36.0
   -54.5   -36.5
   -56.0   -36.0
   -57.0   -36.0]; % Pontos de observação do transector
lon=track(:,1); % Longitude do transector
lat=track(:,2); % Latitude do transector

%% Plotando o caminho da seção transversal
hold on; % Habilidade de editar por cima
plot(lon,lat,'-','linewidth',1.3,'color','k') % Configurações dos marcadores no plot
plot(lon,lat,'^','markeredgecolor','k','markerfacecolor','w','markersize',6); % Configurações dos marcadores no plot
title({'Temperatura de Superfície e plot de pontos de perfis verticais';url},'interpreter','none');


%% Criando as matrizes verticais de Temperatura
[x,y,vdata] = vsliceg(data,grd,lon,lat);

%% Plotando o perfil vertical
figure;
pcolorjw(x,y,vdata);ylabel('m');xlabel('km');
%contourf(x,y,vdata);ylabel('m');xlabel('km');
%[C,h] = contour(x,y,vdata,'LevelStep',0.5,'LineWidth',1.5);ylabel('m');xlabel('km');
% [C,h] = contourf(x,y,vdata,'TextList',[29.5 30 30.5 31 31.5 32 32.5 33 33.5 34 34.5 35 35.5 36],'ShowText','on','LevelStep',0.5,'LineWidth',1.5);ylabel('m');xlabel('km');
%clabel(C,h,'FontSize',16,'Color','white');
colorbar
title({'Along-track vertical section of temperature';url},'interpreter','none');
% shading interp
