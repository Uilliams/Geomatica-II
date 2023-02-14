close all
clear all

cd('C:\Users\pazui\OneDrive\Documentos\2022.2\Geomatica II\Aula_03_Plot_Sat_Mod\Dados')

%% Plot da clorofila do satelite 
%% Visualizando os dados

% ncdisp('A20210322021059.L3m_MO_CHL_chlor_a_4km.nc');
% ncdisp('global-analysis-forecast-bio-001-028-monthly_1650248969426.nc');
% ncdisp('MetO-GLO-PHY-CPL-dm-CUR_1650254366997.nc');

Cl_sat=ncread('A20210322021059.L3m_MO_CHL_chlor_a_4km.nc','chlor_a');
lon_sat=ncread('A20210322021059.L3m_MO_CHL_chlor_a_4km.nc','lon');
lat_sat=ncread('A20210322021059.L3m_MO_CHL_chlor_a_4km.nc','lat');
lat_mod = ncread('global-analysis-forecast-bio-001-028-monthly_1650248969426.nc','latitude');
lon_mod = ncread('global-analysis-forecast-bio-001-028-monthly_1650248969426.nc','longitude');
Cl_mod = ncread('global-analysis-forecast-bio-001-028-monthly_1650248969426.nc','chl');
cur_u= ncread('MetO-GLO-PHY-CPL-dm-CUR_1650254366997.nc','uo');
cur_v = ncread('MetO-GLO-PHY-CPL-dm-CUR_1650254366997.nc','vo');

Cl_mod = (Cl_mod(:,:,:,1)+Cl_mod(:,:,:,2))/2; % Tirando média da clorofila do modelo
cur_u = mean(cur_u,4); % Média da corrente
cur_v = mean(cur_v,4); % Média da corrente

lat_sat = lat_sat(1920:2881); % Selecionando lat do satélite
lon_sat = lon_sat(3168:3744); % Selecionando lon do satélite
Cl_sat = Cl_sat(3168:3744,1920:2881); % Parametrizando lat e lon de clorofila do satélite para ocupar msm espaço do modelo

%% Dimensionando matrizes de lon,lat

lon_mod=repmat(lon_mod,1,161); % Coloca o lon em duas dimensões para ter a msm dimensão da matrix de lat
lat_mod=repmat(lat_mod,1,97); % Coloca o lat em duas dimensões para ter a msm dimensão da matrix de lon
lon_sat=repmat(lon_sat,1,962); % Coloca o lon em duas dimensões para ter a msm dimensão da matrix de lat
lat_sat=repmat(lat_sat,1,577); % Coloca o lat em duas dimensões para ter a msm dimensão da matrix de lon
lat_mod=lat_mod'; % Transpondo a latitude do modelo 
lat_sat=lat_sat'; % Transpondo a latitude do satélite

Cl_interp = griddata(lon_sat,lat_sat,Cl_sat,lon_mod,lat_mod,'nearest'); % Padronizando as dimensões do Cl_sat para o Cl_mod

erro = Cl_mod - Cl_interp; % Encontrando o valor de erro do modelo

%% Gerar figuras clorofila
latlim = [-30 0];
lonlim = [-48 -24];

figure % Abre uma Figura
m_proj('Equidistant Cylindrical','lon_mod',lonlim,'lat_mod',latlim); % Cria a projeção cartografica
m_pcolor(lon_mod,lat_mod,Cl_mod(:,:)); %plota uma figura com paleta de cores
shading interp, % Interpola os dados
cb = colormap(parula);
m_gshhs_i('patch',[0.7 0.7 0.7]); % Aplicação de linha de costa
m_gshhs_i('color','k');
m_grid('box','fancy','tickdir','out'); %Grid box

caxis([-0.5 0.5]); %escolha do range da paleta de cores
h=colorbar; 
set(h,'ytick',([-0.5 -0.25 0 0.25 0.5]),'yticklabel',([-0.5 -0.25 0 0.25 0.5]),'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Concentração Clorofila (mg/m³)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

title('Erro de Conc. Clorofila do Modelo','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

hold on % Comando para editar imagem já aberta
m_quiver(lon_mod(1:3:97,1:3:161),lat_mod(1:3:97,1:3:161),cur_u(1:3:97,1:3:161),cur_v(1:3:97,1:3:161),2,'color','k'); % m_quiver comando para plot de vetor com localização e resultante (raiz(vm²*um²))

print(gcf,'Erro_Clorofila.jpg','-djpeg','-r300'); %Salvando imagem em alta qualidade 

