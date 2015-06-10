function [net,testr]= ML_net_train(net,datainput,label,boundry,opts) 

train_in=datainput(:,:,:,1:boundry);
train_out=label(:,:,:,1:boundry);
valin=datainput(:,:,:,boundry:end);
valout=label(:,:,:,boundry:end);
n = numel(net.layers) ;

  testr.wj=[];testr.lossf=[];
% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------
for epoch=1:opts.numEpochs
  switch (epoch)
      case {1,2}
          r=1;
      case {3,4}
          r=0.8;
      case {5,6,7,8}
          r=0.5;
      case {9,10,11,12}
          r=0.1;
      case {13,14,15,16,17}
          r=0.05;
      case {18,19,20,21,22,23}
          r=0.01;
      otherwise
          r=0.001;
  end
  fprintf('start training epoch %d of %d\n', epoch,opts.numEpochs) ;
  train=randperm(size(train_in,4));
  for t=1:opts.batchSize:numel(train)
    % get next image batch and labels
    batch = train(t:min(t+opts.batchSize-1, numel(train))) ;
    batch_time = tic ;
    fprintf('training epoch %02d:batch %3d of %3d ...', epoch, ...
            fix(t/opts.batchSize)+1, ceil(numel(train)/opts.batchSize)) ;
    tin=train_in(:,:,:,batch);
    tground=train_out(:,:,:,batch);
%----------------------------------------------------随机选取训练集，更新一次各层权值-------------------------------------------------------------------------
    % backprop
    net.layers{end}.class = tground ;
    res = MLcnn_compute_deriv(net, tin);
             
    % gradient step
    for l=1:numel(net.layers)-1
        if  strcmp(net.layers{l}.type, 'conv')
      net.layers{l}.filters = net.layers{l}.filters - res(l).dzdw{1}*net.layers{l}.filterlr*r ;
      net.layers{l}.biases = net.layers{l}.biases - res(l).dzdw{2}*net.layers{l}.biaslr*r ;
        end
    end
%--------------------------------------------------------------------------------------------------------------------------------------------------------------
    % print information
    net.err(end+1)=res(n+1).x;
            if isempty(net.rL)
                net.rL(1) = net.err(1);
            end
    net.rL(end + 1) = 0.99 * net.rL(end) + 0.01 * net.err(end);
    [~,jclass]=max(res(n).x,[],3);
    tmp=(jclass~=tground);
    net.wrongj(end+1)=sum(tmp(:))/numel(tground);
             if isempty(net.allwrongj)
                    net.allwrongj(1) = net.wrongj(1);
             end 
    net.allwrongj(end + 1) = 0.99 * net.allwrongj(end) + 0.01 * net.wrongj(end); 
    
    batch_time = toc(batch_time) ;
    speed = numel(batch)/batch_time ;
    fprintf('lossfun %.2f %.2f --- wrong judge  %.2f %.2f ',net.err(end),net.rL(end),net.wrongj(end),net.allwrongj(end)) ;
    fprintf('\n') ;
    
      % 测试一次网络更新效果
  testm=randperm(numel(valout));
  testl=testm(1:1000);
  testinput=valin(:,:,:,testl);
  testlabel=valout(:,:,:,testl);
  [testr.wj(end+1),testr.lossf(end+1)]= ML_check_net(net,testinput,testlabel);
  end 
end
%save opts.dir 'net';
end




