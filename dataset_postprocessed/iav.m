function iavout = iav( data )
    size = length(data);
    sum = 0;
    for t = 1:size
        sum = sum + abs(data(t));
    end
    iavout = sum;
end

