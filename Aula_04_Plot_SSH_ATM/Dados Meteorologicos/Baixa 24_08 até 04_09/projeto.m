clear all
close all

cd('C:\Users\pazui\OneDrive\Documentos\2022.2\Geomatica II\Aula_04_Plot_SSH_ATM\Dados Meteorologicos\Baixa 24_08 até 04_09\cdas1.20160829.splgrbf')

%% Acessando valores grib
grib_00='cdas1.t00z.splgrbf06.grib2';
grib_06='cdas1.t06z.splgrbf06.grib2';
grib_12='cdas1.t12z.splgrbf06.grib2';
grib_18='cdas1.t18z.splgrbf06.grib2';

%% Acessando com NCtoolbox
nco_00=ncgeodataset(grib_00);
nco_06=ncgeodataset(grib_06);
nco_12=ncgeodataset(grib_12);
nco_18=ncgeodataset(grib_18);

%nco_00.variables % Checando variaves

%% Tirando valores de pressão
press_00=nco_00{'Pressure_surface'}(1,:,:);
press_06=nco_06{'Pressure_surface'}(1,:,:);
press_12=nco_12{'Pressure_surface'}(1,:,:);
press_18=nco_18{'Pressure_surface'}(1,:,:);

%% Tirando valores de temperatura
temp_00=nco_00{'Temperature_hybrid'}(1,1,:,:);
temp_06=nco_06{'Temperature_hybrid'}(1,1,:,:);
temp_12=nco_12{'Temperature_hybrid'}(1,1,:,:);
temp_18=nco_18{'Temperature_hybrid'}(1,1,:,:);

%% Tirando valores de u
u_00=nco_00{'u-component_of_wind_hybrid'}(1,1,:,:);
u_06=nco_06{'u-component_of_wind_hybrid'}(1,1,:,:);
u_12=nco_12{'u-component_of_wind_hybrid'}(1,1,:,:);
u_18=nco_18{'u-component_of_wind_hybrid'}(1,1,:,:);

%% Extraindo valores de v
v_00=nco_00{'v-component_of_wind_hybrid'}(1,1,:,:);
v_06=nco_06{'v-component_of_wind_hybrid'}(1,1,:,:);
v_12=nco_12{'v-component_of_wind_hybrid'}(1,1,:,:);
v_18=nco_18{'v-component_of_wind_hybrid'}(1,1,:,:);

%% Pegando Lat e Lon
lat=nco_00{'lat'}(:);
lon=nco_00{'lon'}(:);

%% Convertendo dados single em double
press_00=double(squeeze(press_00));
press_06=double(squeeze(press_06));
press_12=double(squeeze(press_12));
press_18=double(squeeze(press_18));

temp_00=double(squeeze(temp_00));
temp_06=double(squeeze(temp_06));
temp_12=double(squeeze(temp_12));
temp_18=double(squeeze(temp_18));

u_00=double(squeeze(u_00));
u_06=double(squeeze(u_06));
u_12=double(squeeze(u_12));
u_18=double(squeeze(u_18));

v_00=double(squeeze(v_00));
v_06=double(squeeze(v_06));
v_12=double(squeeze(v_12));
v_18=double(squeeze(v_18));

%% Somando para tirar a média do dia
press=(press_00+press_06+press_12+press_18)/4;
temp= (temp_00+temp_06+temp_12+temp_18)/4;
u= (u_00+u_06+u_12+u_18)/4;
v= (v_00+v_06+v_12+v_18)/4;

%% Fechando Matrizes em excesso
clear press_00
clear press_06
clear press_12
clear press_18

clear temp_00
clear temp_06
clear temp_12
clear temp_18

clear u_00
clear u_06
clear u_12
clear u_18

clear v_00
clear v_06
clear v_12
clear v_18

% %% Selecionando região de interesse
lat=lat(563:787);
lon=lon(1419:1570);
press=press(563:787,1419:1570);
temp=temp(563:787,1419:1570);
u=u(563:787,1419:1570);
v=v(563:787,1419:1570);

%% Convertendo Temperatura
temp=temp-273;

%% Padronizando Lat e Lon
lon=repmat(lon,1,225);
lat=repmat(lat,1,152);
lon=lon';

%% Área no plot
latlim = [-70 -25];
lonlim = [290 320];

%% Abrindo figura
figure 
m_proj('Equidistant Cylindrical','lon',lonlim,'lat',latlim);

m_pcolor(lon,lat,temp(:,:));
colormap(jet);
m_coast('patch',[.8 .8 .8],'edgecolor','none');
m_grid('tickdir','in','yaxislocation','left','xaxislocation','bottom','xlabeldir','middle','ticklen',.02,'fontsize',8);

title('Temperatura Atm. Dia 29 de Agosto','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
% title('Vento Dia 29 de Agosto','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
% title('Pressão[Pa] Dia 29 de Agosto','FontWeight','bold','FontSize',14,'FontName','Times New Roman')
xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

caxis([-20 25]); %escolha do range da paleta de cores
h=colorbar;
set(h,'ytick',([-25 -20 -10 0 10 20 25]),'yticklabel',([-25 -20 -10 0 10 20 25]),'tickdir','out'); % Setar a legenda
set(get(h,'ylabel'),'String','Temperatura °C','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda

% hold on;
% m_quiver(lon(1:4:225,1:4:152),lat(1:4:225,1:4:152),u(1:4:225,1:4:152),v(1:4:225,1:4:152),2);
% 
% hold on;
% [cs,h]=m_contour(lon,lat,press,[50000:10000:100000]);
% clabel(cs,h,'fontsize',6);

print(gcf,'Temperatura_29_08_2006.jpg','-djpeg','-r300')
% print(gcf,'Vento_29_08_2006.jpg','-djpeg','-r300')
% print(gcf,'Pressão_29_08_2006.jpg','-djpeg','-r300')
