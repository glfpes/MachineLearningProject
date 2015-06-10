function res = MLcnn_compute_deriv(net, x)

n = numel(net.layers) ;
res=[];
res = struct(...
    'x', cell(1,n+1), ...
    'dzdx', cell(1,n+1), ...
    'dzdw', cell(1,n+1), ...
    'aux', cell(1,n+1), ...
    'time', num2cell(zeros(1,n+1)), ...
    'backwardTime', num2cell(zeros(1,n+1))) ;
res(1).x = x ;

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



 res(n+1).dzdx = single(1) ;
  for i=n:-1:1
    l = net.layers{i} ;
    switch l.type
      case 'conv'
        [res(i).dzdx, res(i).dzdw{1}, res(i).dzdw{2}] = ...
            vl_nnconv(res(i).x, l.filters, l.biases, ...
                      res(i+1).dzdx, ...
                      'pad', l.pad, 'stride', l.stride) ;
      case 'pool'
        res(i).dzdx = vl_nnpool(res(i).x, l.pool, res(i+1).dzdx, ...
          'pad', l.pad, 'stride', l.stride, 'method', l.method) ;
      case 'softmax'
        res(i).dzdx = vl_nnsoftmax(res(i).x, res(i+1).dzdx) ;
      case 'loss'
        res(i).dzdx = vl_nnloss(res(i).x, l.class, res(i+1).dzdx) ;
      case 'relu'
        res(i).dzdx = vl_nnrelu(res(i).x, res(i+1).dzdx) ;
    end
  end
end
