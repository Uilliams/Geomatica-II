close all
clear all

cd('C:\Users\pazui\OneDrive\Documentos\Geomatica II\Aula_03_Plot_Sat_Mod\Dados')

%ncdisp('MetO-GLO-PHY-CPL-dm-CUR_1650055465108.nc');

%% Dados de temperatura e corrente (Satélite e modelo)
%% Carregamento dos dados
lat_sat = ncread('oisst-avhrr-v02r01.20190101.nc','lat');
lon_sat = ncread('oisst-avhrr-v02r01.20190101.nc','lon');
tsm_sat = ncread('oisst-avhrr-v02r01.20190101.nc','sst');
lat_mod = ncread('MetO-GLO-PHY-CPL-dm-TEM_1650055659308.nc','lat');
lon_mod = ncread('MetO-GLO-PHY-CPL-dm-TEM_1650055659308.nc','lon');
tsm_mod = ncread('MetO-GLO-PHY-CPL-dm-TEM_1650055659308.nc','thetao');
cur_u= ncread('MetO-GLO-PHY-CPL-dm-CUR_1650055465108.nc','uo');
cur_v = ncread('MetO-GLO-PHY-CPL-dm-CUR_1650055465108.nc','vo');

%% Configurando longitude e latitude
%% Configurando coordenadas do satélite para o formato do modelo
lat_sat = lat_sat(28:520); % Selecionando a latitude do satélite 40°N até -83°S
lon_sat01 = lon_sat(1201:1440);
lon_sat02 = lon_sat(1:121)+360; 
lon_sat=[lon_sat01;lon_sat02]; % Selecionando a longitude do satélite 30°L até -60°W
tsm_sat01 = tsm_sat(1201:1440,28:520);
tsm_sat02 = tsm_sat(1:121,28:520);
tsm_sat= [tsm_sat01;tsm_sat02];


%% Matriz de dados da superfície
u = squeeze(cur_u(:,:,1)); % Dimensionando os dados de corrente horizontal para 2D
v = squeeze(cur_v(:,:,1)); % Dimensionando os dados de corrente vertical para 2D
tsm_mod = squeeze(tsm_mod(:,:,1)); % Dimensionando os dados de tsm_modelo em 2D

%% Dimensionando matrizes de lon,lat
lon_mod=repmat(lon_mod,1,493); % Coloca o lon em duas dimensões para ter a msm dimensão da matrix de lat
lat_mod=repmat(lat_mod,1,361); % Coloca o lat em duas dimensões para ter a msm dimensão da matrix de lon
lon_sat=repmat(lon_sat,1,493); % Coloca o lon em duas dimensões para ter a msm dimensão da matrix de lat
lat_sat=repmat(lat_sat,1,361); % Coloca o lat em duas dimensões para ter a msm dimensão da matrix de lon
lat_mod=lat_mod'; % Transpondo a latitude do modelo 
lat_sat=lat_sat'; % Transpondo a latitude do satélite

% %% Eliminando matrizes em excesso
clear cur_u
clear cur_v
clear lon_sat01
clear lon_sat02
clear tsm_sat01
clear tsm_sat02

%% Transformando dados single em double da lon:lat
lon_mod = double(lon_mod);
lon_sat = double(lon_sat);
lat_mod = double(lat_mod);
lat_sat = double(lat_sat);

tsm_interp = griddata(lon_sat,lat_sat,tsm_sat,lon_mod,lat_mod,'nearest'); % Padronizando as dimensões do tsm_sat para o tsm_mod

erro = tsm_mod - tsm_interp; % Encontrando o valor de erro do modelo

%% Gerar figuras temperatura
latlim = [-30 0];
lonlim = [310 340];

figure % Abre uma Figura
m_proj('Equidistant Cylindrical','lon_mod',lonlim,'lat_mod',latlim); % Cria a projeção cartografica
m_pcolor(lon_mod,lat_mod,erro(:,:)); %plota uma figura com paleta de cores
shading interp, % Interpola os dados
colormap(jet);
m_gshhs_i('patch',[0.7 0.7 0.7]); % Aplicação de linha de costa
m_gshhs_i('color','k');
m_grid('box','fancy','tickdir','out'); %Grid box

caxis([-2 2]); %escolha do range da paleta de cores
h=colorbar; 
set(h,'ytick',([-2 -1.5 -1 -0.5 0 0.5 1 1.5 2]),'yticklabel',([-2.5 -1.5 -1 -0.5 0 0.5 1 1.5 2]),'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Temperatura (°C)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

title('Erro de Temperatura do Modelo','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

hold on % Comando para editar imagem já aberta
m_quiver(lon_mod(1:4:361,1:4:493),lat_mod(1:4:361,1:4:493),u(1:4:361,1:4:493),v(1:4:361,1:4:493),2,'color','k'); % m_quiver comando para plot de vetor com localização e resultante (raiz(vm²*um²))

print(gcf,'Erro_tsm.jpg','-djpeg','-r300'); %Salvando imagem em alta qualidade 
