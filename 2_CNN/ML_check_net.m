function [wj,lossf] = ML_check_net(net,input,label)

net.layers{end}.class = label ;
n = numel(net.layers) ;
res=[];
res = struct(...
    'x', cell(1,n+1), ...
    'dzdx', cell(1,n+1), ...
    'dzdw', cell(1,n+1), ...
    'aux', cell(1,n+1), ...
    'time', num2cell(zeros(1,n+1)), ...
    'backwardTime', num2cell(zeros(1,n+1))) ;
res(1).x = input;

for i=1:n
  l = net.layers{i} ;
  switch l.type
    case 'conv'
      res(i+1).x = vl_nnconv(res(i).x, l.filters, l.biases, 'pad', l.pad, 'stride', l.stride) ;
    case 'pool'
      res(i+1).x = vl_nnpool(res(i).x, l.pool, 'pad', l.pad, 'stride', l.stride, 'method', l.method) ;
    case 'softmax'
      res(i+1).x = vl_nnsoftmax(res(i).x) ;
    case 'loss'
      res(i+1).x = vl_nnloss(res(i).x, l.class) ;
    case 'relu'
      res(i+1).x = vl_nnrelu(res(i).x) ;
    otherwise
      error('Unknown layer type %s', l.type) ;
  end
end


lossf=res(n+1).x;
[~,jclass]=max(res(n).x,[],3);
tmp=(jclass~=label);
wj=sum(tmp(:))/numel(label);