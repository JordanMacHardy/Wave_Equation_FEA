function u = g(x,t)

if t <= 3
  u = 0.05*sin(2*pi*3*t) * ones(size(x,1),1);
else
    u = zeros(size(x,1),1);
end