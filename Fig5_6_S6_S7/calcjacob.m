function jacs= calcjacob(datastruct,Ks,Bs)
%Parameter Values
alphay = 1;
alphaz = 1;
betay = 1;
betaz = 1;
H = 2;
op=1;
for i = 1:2
    for j = 1:2
        for k =1:2
            for l =1:2
                
                key = i*1000+j*100+k*10+l;
                K=Ks(op,:);
                
                Kxy = K(1);%.1;
                Kyz = K(2);%.1;
                Kxz = K(3);%.1;

%                 ijklstruct = ffldata.datas{1,1}(key);
                ijklstruct = datastruct(key);
                T = ijklstruct.T;
                Y0 = ijklstruct.Y;
                
%                 display(length(T))
                
                x = Y0(:,1);
                y = Y0(:,2);
                z = Y0(:,3);
                
                jac = zeros(9,length(T));
                
                jac(1,:) = -1;
                jac(2,:) = 0;
                jac(3,:) = 0;
                jac(5,:) = -1;
                jac(6,:) = 0;
                jac(9,:) = -1;
                
                if i == 1       %% X -> Y Activator
                   
                    for t = 1:length(T)
                        
                        jac(4,t) = (H*x(t)^(H-1)/(Kxy^H))/(1+(x(t)/Kxy)^H)^2;
%                         jac(4,t) = (H*x(t)^(H-1)/((Kxy^H)*(1+(x(t)/Kxy)^H)^2));

                                            
                    end
                                        
                else            %% X -> Y Repressor
                                        
                    for t = 1:length(T)
                        
                        jac(4,t) = (-H*x(t)^(H-1)/(Kxy^H))/(1+(x(t)/Kxy)^H)^2;
                                            
                    end
                    
                end
                
                if j == 1       %% AND Gate
                    
                    if k == 1 && l == 1         %% %% X -> Z Activator  Y -> Z Activator
                    
                        for t = 1:length(T)
                        
                            jac(7,t) = (H*x(t)^(H-1)/Kxz^H)*(y(t)^H/Kyz^H)/(((1+x(t)^H/Kxz^H)^2)*((1+y(t)^H/Kyz^H)));
                            
                            jac(8,t) = (x(t)^H/Kxz^H)*(H*y(t)^(H-1)/Kyz^H)/(((1+x(t)^H/Kxz^H))*((1+y(t)^H/Kyz^H)^2));                            
                            
                        end
                                      
                    elseif k == 1 && l == 2     %% X -> Z Activator  Y -| Z Repressor
                        
                        for t = 1:length(T)
                        
                            jac(7,t) = (H*x(t)^(H-1)/Kxz^H)/(((1+x(t)^H/Kxz^H)^2)*((1+y(t)^H/Kyz^H)));
                            
                            jac(8,t) = (-1)*(x(t)^H/Kxz^H)*(H*y(t)^(H-1)/Kyz^H)/(((1+x(t)^H/Kxz^H))*((1+y(t)^H/Kyz^H)^2));                            
                            
                        end
                      
                    elseif k == 2 && l == 1     %% X -| Z Repressor  Y -> Z Activator

                        for t = 1:length(T)
                        
                            jac(7,t) = (-1)*(H*x(t)^(H-1)/Kxz^H)*(y(t)^H/Kyz^H)/(((1+x(t)^H/Kxz^H)^2)*((1+y(t)^H/Kyz^H)));
                            
                            jac(8,t) = (H*y(t)^(H-1)/Kyz^H)/(((1+x(t)^H/Kxz^H))*((1+y(t)^H/Kyz^H)^2));                            
                            
                        end  
                        
                    else                        %% X -| Z Repressor  Y -| Z Repressor
                        
                        for t = 1:length(T)
                        
                            jac(7,t) = (-1)*(H*x(t)^(H-1)/Kxz^H)/(((1+x(t)^H/Kxz^H)^2)*((1+y(t)^H/Kyz^H)));
                            
                            jac(8,t) = (-1)*(H*y(t)^(H-1)/Kyz^H)/(((1+x(t)^H/Kxz^H))*((1+y(t)^H/Kyz^H)^2));                            
                            
                        end
                        
                    end
                    
                else            %% OR Gate
                    
                    if k == 1 && l == 1         %% %% X -> Z Activator  Y -> Z Activator
                    
                        for t = 1:length(T)
                        
                            jac(7,t) = (H*x(t)^(H-1)/Kxz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);

                            jac(8,t) = (H*y(t)^(H-1)/Kyz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                        end
                                      
                    elseif k == 1 && l == 2     %% X -> Z Activator  Y -| Z Repressor
                        
                        for t = 1:length(T)
                        
                            jac(7,t) = (H*x(t)^(H-1)*y(t)^H/(Kxz^H*Kyz^H))/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);

                            jac(8,t) = (-H*x(t)^H*y(t)^(H-1)/(Kxz^H*Kyz^H)-H*y(t)^(H-1)/Kyz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                        end
                      
                    elseif k == 2 && l == 1     %% X -| Z Repressor  Y -> Z Activator

                        for t = 1:length(T)
                        
                            jac(7,t) = (-H*x(t)^H*y(t)^(H-1)/(Kxz^H*Kyz^H)-H*x(t)^(H-1)/Kxz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                            jac(8,t) = (H*x(t)^H*y(t)^(H-1)/(Kxz^H*Kyz^H))/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                        end  
                        
                    else                        %% X -| Z Repressor  Y -| Z Repressor
                        
                        for t = 1:length(T)
                        
                            jac(7,t) = (-2*H*x(t)^(H-1)/Kxz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                            jac(8,t) = (-2*H*y(t)^(H-1)/Kyz^H)/((1+x(t)^H/Kxz^H+y(t)^H/Kyz^H)^2);
                            
                        end
                        
                    end                    
                    
                end
                
                Stim1= ones(11,1);
                Stim2= zeros(11,1);
                Stim3= zeros(11,1);
                jacinv = jac';

                jacs(16,9)=zeros();
                jacs(:,1)=-1;
                jacs(:,5)=-1;
                jacs(:,5)=-1;
                jacs(op,4)=mean(jac(4,:));
                jacs(op,7)=mean(jac(7,:));
                jacs(op,8)=mean(jac(8,:));
                op=op+1;

%                 suptitle(strcat('FFL Case ',num2str(key)));
%                 set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 10, 0.96]);
%                 saveas(gcf,strcat('FFLCase',num2str(key),'.tif'));
            end
        end
    end
end
