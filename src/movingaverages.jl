function sma(x,n)
  [mean(x[i:i+(n-1)]) for i=1:length(x)-(n-1)]
end

function ema(dv::DataArray, n::Int64)

  dv = copy(dv)

  k = 2/(n+1)
  m = sma(dv, n) 

  if n == 1
    [dv[i] = dv[i] for i=1:length(dv)]
  else
    dv[n] = m[1] 
    [dv[i] = dv[i]*k + dv[i-1]*(1-k) for i=(n+1):length(dv)]
  end
  padNA(dv[n:length(dv)], n-1, 0)
end

function ema_unpadded(dv::DataArray, n::Int64)
  k = 2/(n+1)
  m = sma(dv, n) 

  if n == 1
    [dv[i] = dv[i] for i=1:length(dv)]
  else
    dv[n] = m[1] 
  for i=(n+1):length(dv)
    dv[i] = dv[i]*k + dv[i-1]*(1-k) 
  end
  end
  dv[n:length(dv)]
end