clc 
clear
close all
%%grensebetingelser
a = 3*pi;
b=pi;

%%antall steg
nx = 100;
ny = 50;
%%lengde mellom steg
dx = a/nx;
dy = b/ny;
%%lager en liste for x
x = 0:dx:a;
y = 0:dy:b;
u = zeros(ny+1, nx +1);

%%analytisk 
for i=1:ny+1
    for j=1:nx+1
        u(i,j) = sin(x(j))./sin(a).*sinh(y(i))./sinh(b);
    end
end

maxu = max(u,[], 'all');
nu = u/maxu;
contourf(nu, 200,'linecolor','non')
title('Analytisk')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar
caxis([-1,1])

%%Nummerisk

Co = 1/(2*(dx^2+dy^2));
U = zeros(ny+1,nx+1);

%%Grensebetingelse

U (1,:) = 0;
U (ny+1,:) = sin(x)/sin(a);
U (:,1) = 0;
U (:,nx+1) = sinh(y)/sinh(b);
iter_number = 1000;
for k = 1:iter_number
    for i=2:ny
        for j =  2:nx
          U(i,j) = Co*(dx^2*(U(i+1,j)+U(i-1,j)) + dy^2*(U(i,j+1)+U(i,j-1)));
        end
    end
end

maxU = max(U,[], 'all');
nU = U/maxU;
figure()
contourf(nU, 200,'linecolor','non')
title('Nummerisk')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar
caxis([-1,1])


%%error
E = nu-nU;
figure()
contourf(E, 200,'linecolor','non')
title('Usikkerhet')
xlabel('x')
ylabel('y')
colormap(jet(256))
colorbar
caxis([-1,1])


