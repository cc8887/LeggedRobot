%set(gcf, 'doublebuffer', 'on')

% t = 0:pi/100:2*pi;
% y = exp(sin(t));
% h = plot(t,y,'YDataSource','y');
% for k = 1:0.01:10
% 	y = exp(sin(t.*k));
% 	refreshdata(h,'caller') 
% 	drawnow
% end




% Zero = zeros(1,10);
% x = random('Normal',0,10,1,10);
% 
% z = random('Normal',10,10,1,10);
% y = random('Normal',-10,10,1,10);
% 
% 
% 
% 
% for i=1:length(x)
%     %quiver3([0],[0],[0],[10],[10],[10],0.4,'b')
%     quiver3(Zero(1:i),Zero(1:i),Zero(1:i),x(1:i),y(1:i),z(1:i)+10,'b');
%    % axis([-0.5 2.5 -1.0 3.0 2.2 2.5 -1 1]);
%     drawnow;
%     pause(0.1);
% end

% Zero = zeros(1,10);
% x = random('Normal',0,10,2,10);
% 
% z = random('Normal',10,10,2,10);
% y = random('Normal',-10,10,2,10);
% 
%  x = Results(:,1);
%  y = Results(:,2);
%  z = Results(:,3);
%  t = [1:1:10]
%dt = [diff(t);eps]; 

% h = axes('Parent', figure());
% hold(h, 'off');

% for k = 1:10
%     figure(1);
%         plot3(h, x(1:k), y(1:k), z(1:k), '-*k');
%         figure(2)
%         plot(x(2:k),y(2:k));
%         figure(3)
%         scatter3(x(k),y(k),z(k));
%         hold on 
%         %pause(0.1);
%         
% end;

    e1 = [1;0;0;1];
    quiver3(0,0,0,e1(1),e1(2),e1(3),'b')
    hold on 
    T1 = trotx(pi/2);
    e1 = T1 * e1
    quiver3(0,0,0,e1(1),e1(2),e1(3),'b')
    hold on
    T2 = troty(pi/2);
    e1 = T2*e1
    
    quiver3(0,0,0,e1(1),e1(2),e1(3),'b')

