function simplex_method(num,real_num,z_cof,x_cof,test_flag)

    if(exist('test_flag','var'))
        
        num =5;
        z_cof = [0 1 -2 0 0 0];
        x_cof = [1 -2  1  0  0 2;
                 0  1 -3  1  0 1;
                 0  1 -1  0  1 2];
    end

    equal_num = size(x_cof,1);
    x_cof = [x_cof(:,1:end-1),eye(equal_num),x_cof(:,end)];
    g = [zeros(1,num),-1*ones(1,equal_num),0];
    % 阶段一
    B_col = num+1:1:num+equal_num;
    phase1_finish_flag = 0;
    while true
        for i=1:equal_num
            k = B_col(i);
            g = g-x_cof(i,:)*g(k)/x_cof(i,k);
        end
        [kexi,n] = max(g(1:end-1));  % n为入的基
        if kexi<= 0
            if phase1_finish_flag
                fprintf('最优值：%f\n',g(end))
                fprintf('最优解：\n')
                solut = zeros(1,real_num);
                for i=1:real_num
                    solut(i) = (x_cof(:,i)')*x_cof(:,end);
                end
                solut
                break
            end
            phase1_finish_flag = 1;
            g = z_cof;
        else
            if all(x_cof(:,n)<=0)
                fprintf('无界\n')
                return;
            else
                b_a = x_cof(:,end)./x_cof(:,n);
                b_a_temp = b_a;
                b_a_temp(find(b_a<=0)) = max(b_a) +1;
                [~,r] = min(b_a_temp);

            if ~phase1_finish_flag  % 删除辅助向量
                tmp_col = B_col(r);
                B_col(B_col>B_col(r)) = B_col(B_col>B_col(r))-1;
                if tmp_col > num
                    g(:,tmp_col) = [];
                    x_cof(:,tmp_col) = [];
                end
            end
            
            B_col(r) = n;    %B_col(r)出基,n入基
            x_cof(r,:) = x_cof(r,:) / x_cof(r,n);
            g = g - g(n)*x_cof(r,:);
            
            for i=1:equal_num
                if i ==r
                    continue
                else
                    x_cof(i,:) = x_cof(i,:) - x_cof(i,n)*x_cof(r,:);
                end
            end
        end
    end
    end
end
%phase2 = [z_cof;phase1(:,2:end)];


