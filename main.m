clc;
clear all;
S=[];
k=0;
% M = dlmread(filename) reads an ASCII-delimited numeric data file into matrix M. The dlmread function detects the delimiter from the file and treats repeated white spaces as a single delimiter.
X = dlmread('test.txt', ' ', 1, 0);
% [b, a] = butter (n, Wn, ftype) создает фильтр Баттерворта нижних, верхних, полосовых или полосовых помех в зависимости от значения ftype и количества элементов Wn. Результирующие полосовые и полосовые конструкции имеют порядок 2n.
% Примечание. Информацию о численных проблемах, влияющих на формирование передаточной функции, см. В разделе «Ограничения».
[b,a] = butter(4,[5/256 30/256],'bandpass');
% y = filter (b, a, x) фильтрует входные данные x, используя рациональную передаточную функцию, определенную коэффициентами числителя и знаменателя b и a.
X = filter(b,a,X);
% X = zeros (sz1, ..., szN) возвращает массив нулей sz1 by -...- by-szN, где sz1, ..., szN указывают размер каждого измерения. Например, zeros (2,3) возвращают матрицу 2 на 3.
z_act=zeros(140,1);
i=1;
z_act=[];

% for i=1:140
% X = ones (sz1, ..., szN) возвращает массив sz1 by -...- by-szN, где sz1, ..., szN указывает размер каждого измерения. Например, ones (2,3) возвращает массив единиц 2 на 3.
z_req=[ones(20,1)*1;ones(20,1)*2;ones(20,1)*3;ones(20,1)*4;ones(20,1)*5;ones(20,1)*6;ones(20,1)*7];%
% z_req=flipud(z_req);
% z_req(i)=ceil(i/20);
% end
% z_req=[ones(60,1)*1];
% y = buffer (x, n) делит вектор сигнала длины L на неперекрывающиеся сегменты данных (кадры) длины n. Каждый кадр данных занимает один столбец матричного вывода y, который имеет n строк и столбцов ceil (L / n). Если L не делится поровну на n, последний столбец дополняется нулями до длины n.
% y = buffer (x, n, p) перекрывает или перекрывает последовательные кадры в выходной матрице на p выборок:
out = buffer(X(:,18)',511,255);
q = size(out);
while(i<=q(2))
%     z=z+1;
    x=out(:,i);
    
    x=x';
    y=refer(13);
    S(i,1)=(ind(x,y));
    
    y=refer(7.5);
    S(i,2)=(ind(x,y));
    
    y=refer(14);
    S(i,3)=(ind(x,y));
    
    y=refer(8.57);
    
    S(i,4)=(ind(x,y));
    
    y=refer(10);
    S(i,5)=(ind(x,y));
    
    y=refer(12);
    S(i,6)=(ind(x,y));
    
    y=refer(11);
    S(i,7)=(ind(x,y));
    k=k+256;
%     j(z)=max(S(i,:));
    i=i+1;
end
i=1;
while(i<141)
    for j=1:7;%loop to find the index number
        if S(i,j)==max(S(i,:))
            % display(j);
            z_act(i)=j;
           
        end
    end
    i=i+1;
end
% С = confusionmat (group, grouphat) возвращает спутанность матрицу С, определяемой известных и предсказанных группами в group и grouphat, соответственно.
[C,order]=confusionmat(z_req,z_act);
