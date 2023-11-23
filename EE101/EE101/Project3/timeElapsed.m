function newArray = timeElapsed(datetime_array)

newArray = second(datetime_array);
arraySize = numel(newArray); 
first = newArray(1);
i = 1;

while i < arraySize
    if newArray(i) > newArray(i+1)
        newArray(i+1) = newArray(i+1) +60;
        i = 1;
    end
    i = i+1;
end

    newArray = newArray - first;  

end
