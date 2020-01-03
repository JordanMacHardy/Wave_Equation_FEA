
%% Jordan MacHardy 
% This FEA program solves the wave equation for light shining trough two
% slits, with reflective boundry conditions on all walls
close all; clear all; clc;


%% Load mesh data
coords = load('dsg-coordinates.dat');
elems = load('dsg-connectivity.dat');
ne = size(elems,1); % 
nn = size(coords,1); % 
elemsD = load('dsg-dirichlet.dat');
elemsN = load('dsg-neumann.dat');



%% User Inputs


% user inputs
answer = inputdlg({'theta value:','time step:'},'Inputs'); % implicit/explicit mixing constant
theta=str2double(answer{1}); % explicit implicit mixing conastant value
dt=str2double(answer{2});    % time step
if theta==0
    mass_lump = questdlg('Use Mass Lumping?','Mass Matrix Condition','Yes','No','No');
else
    mass_lump='No';
end


% Conditions for formating Plots
if theta==0.5
    title_string= ['Crank Nicolson  ' 'dt= ' num2str(dt,'%10.0e\n')];
elseif theta==0 && strcmp(mass_lump,'Yes')
    title_string= ['Fully Explicit With Mass Lumping  ' 'dt= ' num2str(dt,'%10.0e\n')];
elseif theta==0 && strcmp(mass_lump,'No')
    title_string= ['Fully Explicit  ' 'dt= ' num2str(dt,'%10.0e\n')];
elseif theta==1 
    title_string= ['Fully Implicit  ' 'dt= ' num2str(dt,'%10.0e\n')];
else
    title_string= ['theta= ' num2str(theta) num2str(dt,'%10.0e\n')];
end


%% Initialize Video

video = VideoWriter(title_string,'MPEG-4');
open(video)

% makes the video not go to fast
frmrt = 0.005; % 
dtfrframe_time = round(frmrt/dt); 
if dtfrframe_time < 1
    dtfrframe_time = 1;
end

% Time Parameters
tf = 3; % integration time
ts = 1; % time steps between outputs
Nt = tf/dt; % number of time points


%% INITIALIZE

K = sparse(nn,nn); % Stiffness Matrix
M = sparse(nn,nn); % Mass Matrix
d = zeros(nn,1); % soln for current time step
e = zeros(nn,1); % soln vector for v 
dout = zeros(2*nn,round(Nt/ts)+1); % solution vector over time
de = [d;e]; % Vector of d and e
warning('off','MATLAB:singularMatrix'); % gets rid of anoying error
inner_nodes = setdiff(1:size(coords,1),unique(elemsD)); % non-Dirichlet nodes of d
espace = inner_nodes + nn; % makes an "e" node for every iner node
dof = [inner_nodes espace];



%% ASSEMBLY
for i = 1:ne
    nodes = elems(i,:);
    vertices = coords(nodes,:);
    M(nodes,nodes) = M(nodes,nodes) + mlocal(vertices);
    K(nodes,nodes) = K(nodes,nodes) + klocal(vertices);
end

% Mass Lumping
if strcmp(mass_lump,'Yes')
    M = diag(sum(M));
end

% Build Right and Left Hand side
LHS = [M -theta*dt*M; theta*dt*K M]; % left hand matrix 
RHS = [M (1-theta)*dt*M;(theta-1)*dt*K M]; % right hand matrix

%% TIME STEPPING

to=1; % index for saving solution over time
tic

for ti = 0:Nt
    % initialize F
    F = zeros(2*nn,1);
    
    % adds previous solution
    F = F + RHS * de;
    
    
    % add Dirichlet conditions
    
    % Initialize
    u = zeros(nn,1);
    
    % Puts diriclet conditions in curent stp solution 
    % and makes convienent way to put the derichlet BS's into F
    u(unique(elemsD)) = theta * g(coords(unique(elemsD),:),ti*dt)+(1-theta) * g(coords(unique(elemsD),:),(ti-1)*dt);
    Gdot=u; % just to be explicit
    %  makes convienent way to put the derichlet BS's into F
    Gdotdot = zeros(nn,1);
    Gdotdot(unique(elemsD)) = theta * gdotdot(coords(unique(elemsD),:),ti*dt)+(1-theta) * gdotdot(coords(unique(elemsD),:),(ti-1)*dt);
    
    % Build F
    F(nn+1:end) = F(nn+1:end) - dt * (M * Gdotdot + K * Gdot);
    
    de(1:end) = zeros(2*nn,1); % Re-initialize de 
    de(dof) = LHS(dof,dof)\F(dof);
    
    % Saving solution
    
    if ~mod(ti,ts)
        to = to + 1;
        dout(:,to) = de;
    end
    
    if ~mod (ti ,Nt /100)
        string = sprintf ('%d percent complete ' ,100* ti/Nt);
        disp ( string );
    end
end
dout = dout(1:nn,:);
toc

%% Plot and make video

for ti = 1:dtfrframe_time:(round(Nt/ts)+1)
    trisurf(elems,coords(:,1),coords(:,2),dout(:,ti))
    title(title_string)
    view(20,40);
    if theta==0 && strcmp(mass_lump,'No')
        zlim([-.1 .1]);
    else
        zlim([-0.1 0.1]);
    end
    legend(['time = ',num2str(round((ti*dt),1))],'location','northeast');
    drawnow;
    if ~mod (ti ,Nt /100)
        Frame = getframe(gcf);
        writeVideo(video,Frame);
    else
        Frame = getframe(gcf);
        writeVideo(video,Frame);
    end       
end

close(video);