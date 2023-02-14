clear all
close all

%% Plot simples de Temperatura na superfície do mar em mapa 2D
%% Dados adqueridos em formato NetCDF

%% Visualizando os dados
ncdisp('oceano.nc');

%% Carregando os dados
temp_dados = ncread('oceano.nc','POT_L160_FcstAvg1hr'); % Acessando a variável de temperatura
lon = ncread('oceano.nc','lon'); % Acessando a variável de longitudde
lat = ncread('oceano.nc','lat'); % Acessando a variável de latitude
lat = lat'; % Gerando transposta da latitude

%% Filtrando
%temp_dia2 = temp_dados(:,:,:,2); % Selecionando o dia 2
temp_dias_m = mean(temp_dados,4); % Tirando a média de dias da temperatura
temp_m_sup = temp_dias_m(:,:,1:3); % Esscolhendo temperatura de superfície
tempm = temp_m_sup-273.15; % Convertendo fahrenheit em celsius
tempm = mean(tempm,3); % Tirando a média da temperatura de superfície
tempm = tempm'; % Gerando transposta

%% Checando o plot
imagesc(tempm)

%% Eliminando matrizes em excesso
clear temp_dias_m
clear temp_m_sup
clear temp_dados

%% Plotando figura temperatura
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
set(h,'ytick',[24 25 26 27 28],'yticklabel',[24 25 26 27 28],'tickdir','out','fontsize',12); % Setar a legenda
set(get(h,'ylabel'),'String','Temperatura (°C)','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

title('Temperatura Janeiro de 2021','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
