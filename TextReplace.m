fid  = fopen('input.txt','r');
f=fread(fid,'*char')';
fclose(fid);

%% Import data from text file.
filename = 'List.txt';
delimiter = ',';
formatSpec = '%s%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);
fclose(fileID);
%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.

[Entries, ~] = size(dataArray{1});
 raw = repmat({''},Entries, 2);
 for col=1:2
     raw(1:Entries, col) = cellstr(dataArray{1, col});
     % raw(1:Entries,col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
 end

% numericData = NaN(size(dataArray{1},1),size(dataArray,2));


%% Split data into numeric and string columns.
%rawNumericColumns = {};
rawStringColumns = string(raw(:, [1,2]));


%% Create output variable
list1 = table;
list1.Find = rawStringColumns(:, 1);
list1.Replace = rawStringColumns(:, 2);

%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawNumericColumns rawStringColumns;

length = size(list1(:,1));
numValues = length(1,1);

for iters=1:numValues
    f = strrep(f,char(cellstr(table2cell(list1(iters, 1)))),char(cellstr(table2cell(list1(iters, 2)))));
end

fid  = fopen('output.txt','w');
fprintf(fid,'%s',f);
fclose(fid);
clearvars length numValues;