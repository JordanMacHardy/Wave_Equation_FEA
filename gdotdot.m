function udotdot = gdotdot(x,t)

A = 0.05; 
omega = 3; 
if t <= 3
    udotdot = -4*pi^2*omega^2*A*sin(2*pi*omega*t) .* ones(size(x,1),1);
else
    udotdot = zeros(size(x,1),1);
end