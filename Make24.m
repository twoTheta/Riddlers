%% Initialize Array
% Put doubles in the middle to avoid double counting on number of ways.
r1 = [2 3 3 4]; % Tracks numeric values
r1L={'2','3','3','4'};  % Tracks arithmetic process
num4=[1 2 3 4]; % Used to find which elements are NOT used in the arithemtic step

%% First Arithmetic Combination
r2=[]; % Will be filled with triplets after one arithmetic step
r2L=cell(0,3); % Will be filled with the aritmetic process which produces the values in r2

% I don't want to double count the processes with two of the same number.
% Since I am keeping the doubles in the middle, I won't iterate the first
% loop to the third value if the second and third have the same value.
if r1(2)==r1(3)
    W=2;
else
    W=3;
end

for i = 1:W
    for j = 3:4
        rest = num4(num4~=i & num4~=j); % Determines which indexes are NOT used in this step.
        
        % Using the ith and jth elements, perform ALL arithmetic possible
        % and make triples. The unused elements come first and second and
        % the combination comes third. Note that + and * are communative so
        % the order doesn't matter. -, /, and ^ are not communative so they
        % must be evaluated in BOTH orders.
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(i)+r1(j)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{i},'+',r1L{j},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(i)*r1(j)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{i},'*',r1L{j},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(i)-r1(j)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{i},'-',r1L{j},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(j)-r1(i)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{j},'-',r1L{i},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(i)/r1(j)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{i},'/',r1L{j},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(j)/r1(i)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{j},'/',r1L{i},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(i)^r1(j)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{i},'^',r1L{j},')')}];
        
        r2 = [r2; r1(rest(1)) r1(rest(2)) r1(j)^r1(i)];
        r2L= [r2L; {r1L{rest(1)} r1L{rest(2)} strcat('(',r1L{j},'^',r1L{i},')')}];
        
    end
end


%% Second Arithmatic Step
% This is functionally identical to the first step but now with four
% elements instead of three. This seems like an ideal candidate for
% recursion....

num3=[1 2 3];
r3=[];
r3L=cell(0,2);
for k=1:length(r2)
    r2u=r2(k,:);
    r2Lu=r2L(k,:);
    if r2u(1)==r2u(2)
        M=1;
    else
        M=2;
    end
    for i = 1:M
        for j = i+1:3
            rest = num3(num3~=i & num3~=j);
            r3 = [r3; r2u(rest) r2u(i)+r2u(j)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{i},'+',r2Lu{j},')')}];
            r3 = [r3; r2u(rest) r2u(i)*r2u(j)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{i},'*',r2Lu{j},')')}];
            r3 = [r3; r2u(rest) r2u(i)-r2u(j)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{i},'-',r2Lu{j},')')}];
            r3 = [r3; r2u(rest) r2u(j)-r2u(i)];            
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{j},'-',r2Lu{i},')')}];
            r3 = [r3; r2u(rest) r2u(i)/r2u(j)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{i},'/',r2Lu{j},')')}];
            r3 = [r3; r2u(rest) r2u(j)/r2u(i)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{j},'/',r2Lu{i},')')}];
            r3 = [r3; r2u(rest) r2u(i)^r2u(j)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{i},'^',r2Lu{j},')')}];
            r3 = [r3; r2u(rest) r2u(j)^r2u(i)];
            r3L=[r3L; {r2Lu{rest} strcat('(',r2Lu{j},'^',r2Lu{i},')')}];
        end
    end
end

%% Third Arithmatic Step
% Same as before. Now only two values to combine so fewer loops are needed.


r4=[];
r4L={};
for k=1:length(r3)
    r3u=r3(k,:);
    r3Lu=r3L(k,:);
    r4 = [r4; r3u(1)+r3u(2)];
    r4L = [r4L; {strcat(r3Lu(1),'+',r3Lu(2))}];
    r4 = [r4; r3u(1)*r3u(2)];
    r4L = [r4L; {strcat(r3Lu(1),'*',r3Lu(2))}];
    r4 = [r4; r3u(1)-r3u(2)];
    r4L = [r4L; {strcat(r3Lu(1),'-',r3Lu(2))}];
    r4 = [r4; r3u(2)-r3u(1)];
    r4L = [r4L; {strcat(r3Lu(2),'-',r3Lu(1))}];
    r4 = [r4; r3u(1)/r3u(2)];
    r4L = [r4L; {strcat(r3Lu(1),'/',r3Lu(2))}];
    r4 = [r4; r3u(2)/r3u(1)];
    r4L = [r4L; {strcat(r3Lu(2),'/',r3Lu(1))}];
    r4 = [r4; r3u(1)^r3u(2)];
    r4L = [r4L; {strcat(r3Lu(1),'^',r3Lu(2))}];
    r4 = [r4; r3u(2)^r3u(1)];
    r4L = [r4L; {strcat(r3Lu(2),'^',r3Lu(1))}];
end

%% Determine number of ways to make integers
ways=[];
for ValToMake=1:100
    ways(ValToMake)=size(r4(real(r4)==ValToMake),1);
end
bar(ways)
xlabel('Value Combined to Get')
ylabel('Number of Ways to Get It')
xlim([0 100])

