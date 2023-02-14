clear all
close all

%% Obtendo os dados dos dias
grib='cdas1.t00z.splgrbf06.grib2';
% grib_06='cdas1.t06z.splgrbf06.grib2';
% grib_12='cdas1.t12z.splgrbf06.grib2';
% grib_18='cdas1.t18z.splgrbf06.grib2';

nco=ncgeodataset(grib);
% nco_06=ncgeodataset(grib_00);
% nco_12=ncgeodataset(grib_00);
% nco_18=ncgeodataset(grib_00);
nco.variables

u_param='Temperature_hybrid';
v_param='Temperature_hybrid';
temp_param='Temperature_hybrid';
press_param='Temperature_hybrid';
u=nco{u_param}(1,1,:,:);
v=nco{v_param}(1,1,:,:);
temp=nco{temp_param}(1,1,:,:);
press=nco{press_param}(1,1,:,:);
% param_01=nco{'Temperature_hybrid'};
% param_01={'Temperature_hybrid'};
lat=nco{'lat'}(:);
lon=nco{'lon'}(:);

u=double(squeeze(u));
v=double(squeeze(v));
temp=double(squeeze(v));
press=double(squeeze(v));