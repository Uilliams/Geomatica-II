clear all
close all


f=dir('ATM_16_09_2016.jpg');
fil={f.name};  
for k=1:numel(fil)
  file=fil{k}
  new_file=strrep(file,'.jpg','.png')
  im=imread(file)
  imwrite(im,new_file)
end