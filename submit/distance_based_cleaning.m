function [ image_in ] = distance_based_cleaning( image_in, ref, distance_threshold )
[m, n] = size(image_in);
for i = 1:m
    for j = 1:n
        if image_in(i, j) == 1
            if has_true_neighbour( i, j, ref, distance_threshold ) == 0
                image_in(i, j) = 0;
                
            end
        end
    end
end
end

function ret = has_true_neighbour( i, j, ref, distance_threshold )
[mm, nn] = size(ref);
ret = 0;
for p = i-distance_threshold:i+distance_threshold
    for q = j-distance_threshold:j+distance_threshold
        if p > mm || p<1 || q < 1 || q > nn
            continue
        end
        
        if ref(p, q) == 1
            ret = 1;
            return
        end
    end
end
end
