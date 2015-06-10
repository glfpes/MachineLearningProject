fid = fopen('I:\ml project\100K\dota2_100K.txt','r');

datamat = zeros(10,11,100000);
a = fgets(fid);

for dep = 1:100000
    dep
    a = fgets(fid);
    a = fgets(fid);
    a = fgets(fid);
    a = fgets(fid);
    a = fgets(fid);
    for row = 1:10
        a = fgets(fid);
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(14:cc-3);
        datamat(row,1,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(18:cc-3);
        datamat(row,2,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(19:cc-3);
        datamat(row,3,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(13:cc-3);
        datamat(row,4,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(13:cc-3);
        datamat(row,5,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(14:cc-3);
        datamat(row,6,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(19:cc-3);
        datamat(row,7,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(17:cc-3);
        datamat(row,8,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(15:cc-3);
        datamat(row,9,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(20:cc-3);
        datamat(row,10,dep) = str2num(char(temp));
        
        a = fgets(fid);
        [rr,cc] = size(a);
        temp = a(20:cc-1);
        datamat(row,11,dep) = str2num(char(temp));
        
        a = fgets(fid);
    end
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
end