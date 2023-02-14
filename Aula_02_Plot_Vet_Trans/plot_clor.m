clear all
close all

cd('C:\Users\pazui\OneDrive\Documentos\Geomatica II\Aula_02_Plot_Vet_Trans\Dados')

%% Plot de clorofila
%% Visualizando os dados

ncdisp('Chlor.nc');

Cl=ncread('Chlor.nc','MODISA_L3m_CHL_8d_4km_2018_chlor_a');
lon=ncread('Chlor.nc','lon');
lat=ncread('Chlor.nc','lat');
lat=lat';

%% Dimensionando matrizes de lon,lat
lon=repmat(lon,1,421); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat=repmat(lat,591,1); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites

%% Gerar figuras clorofila
latlim = [-28 -11];
lonlim = [-49 -25];

figure % Abre uma Figura
m_proj('Equidistant Cylindrical','lon',lonlim,'lat',latlim); % Cria a projeção cartografica
m_pcolor(lon,lat,Cl(:,:)); %plota uma figura com paleta de cores
shading interp, % Interpola os dados
colormap(parula);
m_gshhs_i('patch',[0.7 0.7 0.7]); % Aplicação de linha de costa
m_gshhs_i('color','k');
m_grid('box','fancy','tickdir','out'); %Grid box com as coordenadas lat e lon

caxis([0 2]); %escolha do range da paleta de cores
h=colorbar; 
set(h,'ytick',([0 0.5 1 1.5 2]),'yticklabel',[0 0.5 1 1.5 2],'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Clorofila (mg/m³)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

title('Concentração de Clorofila','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

%saveas(gcf, 'tsm_01-03out-2015', 'tiff')
