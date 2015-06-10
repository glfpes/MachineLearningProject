clear;
clc;
fid = fopen('I:\ml project\100K\dota2_100K.txt','r');
fidout  = fopen('datalabel.txt','wt');
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

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);

        
        a = fgets(fid);
    end
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        a = fgets(fid);
        if(a(18)=='f')
            fprintf(fidout,'0\n');
        else
            fprintf(fidout,'1\n');
        end
        a = fgets(fid);
end