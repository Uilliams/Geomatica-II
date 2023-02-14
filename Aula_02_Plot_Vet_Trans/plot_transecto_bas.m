%% Rotina para extrair perfis transversais ROMS
% Using VSLICEG to create a vertical section from a 3D field

clear all
close all

cd('C:\Users\pazui\OneDrive\Documentos\Geomatica II\Aula_02_Plot_Vet_Trans\Dados')

lon=ncread('oceano.nc','lon'); % Acessando a variável de longitudde
lat=ncread('oceano.nc','lat'); % Acessando a variável de latitude
temp=ncread('oceano.nc','POT_L160_FcstAvg1hr'); % Acessando a variável de temperatura
u=ncread('oceano.nc','UOGRD_L160_FcstAvg1hr'); % Acessando a variável de velocidade horizontal (u)
v=ncread('oceano.nc','VOGRD_L160_FcstAvg1hr'); % Acessando a variável de velocidade vertical (v)

%% Leitura do primeiro tempo
temp=temp(:,:,:,1);
u=u(:,:,:,1);
v=v(:,:,:,1);

%% Leitura do dado Superficial
tempsup=temp(:,:,1:3);
usup=u(:,:,1:3);
vsup=v(:,:,1:3);

%% Converter fahrenheit para Celsuis
tempsup=tempsup-273;

%% Calcular média vertical de U e V
um=mean(usup,3);
vm=mean(vsup,3);
tempm=mean(tempsup,3);

lon=repmat(lon,1,15); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat=repmat(lat,1,22); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat=lat';

%% Eliminando matrizes em excesso
clear tempsup
clear vsup
clear usup
clear u
clear v

%% Figura temperatura

latlim = [-24 -10];
lonlim = [310 331];

figure % Abre uma Figura
m_proj('Equidistant Cylindrical','lon',lonlim,'lat',latlim); % Cria a projeção cartografica
m_pcolor(lon,lat,tempm(:,:)); %plota uma figura com paleta de cores
shading interp, % Interpola os dados
colormap(jet);
m_gshhs_i('patch',[0.7 0.7 0.7]); % Aplicação de linha de costa
m_gshhs_i('color','k');
m_grid('box','fancy','tickdir','out'); %Grid box com as coordenadas lat e lon

caxis([24 28]); %escolha do range da paleta de cores
h=colorbar; 
set(h,'ytick',([24 25 26 27 28]),'yticklabel',[24 25 26 27 28],'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Temperatura (°C)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

title('Temperatura Janeiro de 2021','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');


%% Figura transecto 

secao=squeeze(temp(10:19,12,:)); %Definindo localização do perfil vertical

%% Comandos de rotação

secao=rot90(secao); % Rotaciona noventa graus esquerda
% secao=flipud(secao); % Espelha verticalmente o dado
% secao=fliplr(secao); % Espelha horizontalmente o dado
imagesc(secao); % Abre uma figura pra ver o perfil



%% Converter fahrenheit para Celsuis

secao=secao-273;

%% Plotando a figura

figure;

pcolor(secao);
shading interp, % Interpola os dados e suaviza
colormap(jet);

caxis([24 28]); %escolha do range da paleta de cores
h=colorbar; 
set(h,'ytick',([24 25 26 27 28]),'yticklabel',[24 25 26 27 28],'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Temperatura (°C)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); % Nome da legenda

title('Temperatura Janeiro de 2021','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

