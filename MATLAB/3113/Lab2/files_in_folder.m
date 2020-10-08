function filenames=files_in_folder(foldername)
% file extraction helper function for all OS
    addpath(foldername); % add folder to path
    dirset=dir(foldername); % create directory struct
    
    % use cell function to scrub directory struct for directory signifiers
    s=find(cellfun(@(x)isequal(x(1),'.'),{dirset.name}),1,'last');
    % if file system does not have directory signifiers, scrub for error
    if isempty(s)
        s=1;
    end
    filenames=cell(size(dirset,1)-s,1);% preinit variable
    for i=s+1:size(dirset,1) % add each file name to files matrix
        filenames{i-s}=dirset(i).name;    
    end
end