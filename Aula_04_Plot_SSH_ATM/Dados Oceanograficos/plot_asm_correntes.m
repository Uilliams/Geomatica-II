close all
clear all

cd('C:\Users\pazui\OneDrive\Documentos\2022.2\Geomatica II\Aula_04_Plot_SSH_ATM\Dados Oceanograficos\Alta (14_09 até 16_09)')

ncdisp('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc');

%% Plot da Altura da Superfície do Mar do satelite 
%% Visualizando os dados
alt_sat = ncread('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc','zos');
u_sat = ncread('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc','uo');
v_sat = ncread('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc','vo');
lat_sat = ncread('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc','latitude');
lon_sat = ncread('cmems_mod_glo_phy_my_0.083_P1D-m_1651537454695.nc','longitude');

%% Dimensionando matrizes
u_sat = squeeze(u_sat(:,:,1,:)); % Dimensionando os dados de corrente horizontal para 3D
v_sat = squeeze(v_sat(:,:,1,:)); % Dimensionando os dados de corrente vertical para 3D
lon_sat = repmat(lon_sat,1,541); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat_sat = repmat(lat_sat,1,361); % Coloca as matrizes de(lon,lat) em duas dimensões para terem os msms limites
lat_sat = lat_sat';

%% Transformando dados single em double da lon:lat
lon_sat = double(lon_sat);
lat_sat = double(lat_sat);

%% Gerar figuras temperatura
latlim = [-70 -25];
lonlim = [-70 -40];

fig = figure; % Abre uma Figura
for t = 1:3 % Range pra plotar ao longo dos dias
%     if find(t<=8)
        m_proj('Equidistant Cylindrical','lon_sat',lonlim,'lat_sat',latlim); % Cria a projeção cartografica
%         m_pcolor(lon_sat,lat_sat,alt_sat(:,:,t)); %plota uma figura com paleta de cores
%         shading interp, % Interpola os dados
%         colormap(jet);
        m_gshhs_i('patch',[0.9 0.9 0.9]); % Aplicação de linha de costa
        m_gshhs_i('color','k');
        m_grid('tickdir','out','fontsize',8); %Grid box
    
%         caxis([-2 1]); %escolha do range da paleta de cores
%         h=colorbar; 
%         set(h,'ytick',([-2 -1.5 -1 -0.5 0 0.5 1]),'yticklabel',([-2 -1.5 -1 -0.5 0 0.5 1]),'tickdir','out'); % Setar a legenda
%         set(get(h,'ylabel'),'String','m','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda
    
     %   k = t + 13
        title(['Correntes'],'FontWeight','bold','FontSize',14,'FontName','Times New Roman')
     %   title(['ASM Dia ' num2str(k) ' de Setembro'],'FontWeight','bold','FontSize',14,'FontName','Times New Roman')
     %   xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
      %  ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
%% Codigo para plotar corrente
        hold on % Comando para editar imagem já aberta
        m_quiver(lon_sat(1:10:361,1:10:541),lat_sat(1:10:361,1:10:541),u_sat(1:10:361,1:10:541,t),v_sat(1:10:361,1:10:541,t),2,'color','k'); % m_quiver comando para plot de vetor com localização e resultante (raiz(vm²*um²))
        m_coast('patch',[.8 .8 .8],'edgecolor','none');
        m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',.02,'fontsize',8);
% 
%         
%         frame = getframe(gcf); % Função pra figura ir vira uma cena
%         img{t} = frame2im(frame); % Função pras cenas virarem um gif
%     
      print(gcf,sprintf('Corrente_%d.jpg',t),'-djpeg','-r300'); %Salvando imagem em alta qualidade
%         print(gcf,sprintf('Correntes_0%d.jpg',t),'-djpeg','-r300'); %Salvando imagem em alta qualidade 
%     else
%         m_proj('Equidistant Cylindrical','lon_sat',lonlim,'lat_sat',latlim); % Cria a projeção cartografica
%         m_pcolor(lon_sat,lat_sat,alt_sat(:,:,t)); %plota uma figura com paleta de cores
%         shading interp, % Interpola os dados
%         colormap(jet);
%         m_gshhs_i('patch',[0.8 0.8 0.8]); % Aplicação de linha de costa
%         m_gshhs_i('color','k');
%         m_grid('tickdir','out','fontsize',8); %Grid box
    
%         caxis([-2 1]); %escolha do range da paleta de cores
%         h=colorbar; 
%         set(h,'ytick',([-2 -1.5 -1 -0.5 0 0.5 1]),'yticklabel',([-2 -1.5 -1 -0.5 0 0.5 1]),'tickdir','out'); % Setar a legenda
%         set(get(h,'ylabel'),'String','m','FontWeight','bold','FontSize',14,'FontName','Times New Roman'); %nome da legenda
    
%         v = t - 8;
%         title(['Correntes'],'FontWeight','bold','FontSize',14,'FontName','Times New Roman')
%         title(['Correntes Dia ' num2str(v) ' de Setembro'],'FontWeight','bold','FontSize',14,'FontName','Times New Roman')
%         xlabel('Longitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
%         ylabel('Latitude','FontWeight','bold','FontSize',14,'FontName','Times New Roman');

%% Codigo para plotar corrente
%         hold on % Comando para editar imagem já aberta
%         m_quiver(lon_sat(1:10:361,1:10:541),lat_sat(1:10:361,1:10:541),u_sat(1:10:361,1:10:541,t),v_sat(1:10:361,1:10:541,t),2,'color','k'); % m_quiver comando para plot de vetor com localização e resultante (raiz(vm²*um²))
%         m_coast('patch',[.8 .8 .8],'edgecolor','none');
%         m_grid('tickdir','out','yticklabels',[],'xticklabels',[],'linestyle','none','ticklen',.02,'fontsize',8);
% 
%         
%         frame = getframe(gcf); % Função pra figura ir vira uma cena
%         img{t} = frame2im(frame); % Função pras cenas virarem um gif
%     
%         print(gcf,sprintf('Corrente_%d.jpg',t),'-djpeg','-r300'); %Salvando imagem em alta qualidade 
%         print(gcf,sprintf('Corrente_0%d.jpg',t),'-djpeg','-r300'); %Salvando imagem em alta qualidade 
%     end
    close
end 

for t = 1:t
    subplot(3,4,t)
    imshow(img{t});
end

filename = 'testAnimated.gif'; % Specify the output file name
for t = 1:t
    [A,map] = rgb2ind(img{t},256);
    if t == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',1);
    end
end