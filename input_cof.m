function [num_new,real_num,z_cof,x_cof] = input_cof()
    num = input('请输入变量x个数: ');
    real_num = num;
    fprintf('变量x个数: %d\n', num);
    
    z_cof = input('输入目标函数的系数\n如：z = 2x1 + 0x2 + 4x3\n 则输入： [2 0 4]\n');
    while length(z_cof) ~=num
        fprintf("输入的变量数错误\n 目标变量数位 %d , 你输入了 %d 个变量\n",num,length(z_cof))
        z_cof = input('重新输入\n');
    end
    z_cof = [-z_cof ,0];
    x_cof = [];
    first_flag = 1;
    % 输入等式方程
    while true
        if first_flag
            line = input('输入等式的系数，一次一个方程\n如：2x1 + 0x2 + 4x3 = 4\n 则输入： [2 0 4 4]\n结束按回车，进入不等式输入\n');
            first_flag = 0;
        else
            line = input('输入下一个等式方程，结束按回车，进入不等式输入:\n');
        end
    
        while length(line) ~=num+1 && (~isempty(line)) 
            fprintf("输入的变量数错误\n 目标变量数位 %d , 你输入了 %d 个变量\n",num+1,length(line))
            line = input('重新输入\n');
        end
       if isempty(line)
            break
       end
       if line(end) <0
           line = -line; 
       end
       x_cof = [x_cof;line];
    end

    % 输入不等式方程
    num_new  = num;
    first_flag = 1;
    while true
        if first_flag
            line = input('输入不等式，化为<=形式\n如：2x1 + 0x2 + 4x3 <= 4\n 则输入： [2 0 4 4]\n');
            first_flag = 0;
        else
            line = input('输入下一个等式方程，结束按回车:\n');
        end
    
        while length(line) ~=num+1 && (~isempty(line)) 
            fprintf("输入的变量数错误\n 目标变量数位 %d , 你输入了 %d 个变量\n",num+1,length(line))
            line = input('重新输入\n');
        end
       if isempty(line)
            break
       end
       % 引入新变量
       num_new =num_new +1;
       z_cof = [z_cof(1:end-1),0,z_cof(end)];
       line = [line(1:end-1),zeros(1,num_new-num-1),1,line(end)];
       if ~isempty(x_cof)
            x_cof = [x_cof(:,1:end-1),zeros(size(x_cof,1),1),x_cof(:,end)];
       end 
       if line(end) <0
           line = -line; 
       end
       x_cof = [x_cof;line];
    end
    
end