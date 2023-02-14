close all
clear all

cd('C:\Users\pazui\OneDrive\Documentos\2022.2\Geomatica II\Aula_03_Plot_Sat_Mod\Dados')

ncdisp('oisst-avhrr-v02r01.20190101.nc');

%% Plot da temperatura do satelite 
%% Visualizando os dados

temp_sat = ncread('oisst-avhrr-v02r01.20190101.nc','sst');
lat_sat = ncread('oisst-avhrr-v02r01.20190101.nc','lat');
lon_sat = ncread('oisst-avhrr-v02r01.20190101.nc','lon');

%% Dimensionando matrizes de lon,lat
lon_sat=repmat(lon_sat,1,720); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat_sat=repmat(lat_sat,1,1440); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat_sat=lat_sat';

%% Gerar figuras temperatura
latlim = [-90 90];
lonlim = [0 360];

figure % Abre uma Figura
m_proj('Equidistant Cylindrical','lon_sat',lonlim,'lat_sat',latlim); % Cria a projeção cartografica
m_pcolor(lon_sat,lat_sat,temp_sat(:,:)); %plota uma figura com paleta de cores
shading interp, % Interpola os dados
colormap(parula);
m_gshhs_i('patch',[0.7 0.7 0.7]); % Aplicação de linha de costa
m_gshhs_i('color','k');
m_grid('box','fancy','tickdir','out'); %Grid box
