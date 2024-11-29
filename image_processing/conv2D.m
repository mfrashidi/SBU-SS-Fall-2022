function [feature_map] = conv2D(img, filters, stride, padding)
    [f, ~, number_of_filters] = size(filters);
    [M, N, C] = size(img);
    if (strcmp(padding, "same"))
        p = (f - 1) / 2;
        tmp = zeros(M + p * 2, N + p * 2, C);
        for channel = 1:C
            tmp(p + 1:M + p, p + 1:N + p, channel) = img(:, :, channel);
        end
        img = tmp;
    end
    [M, N, C] = size(img);
    M_New = floor((M - f) / stride) + 1;
    N_New = floor((N - f) / stride) + 1;
    feature_map = zeros(M_New, N_New, number_of_filters);
    for filter = 1:number_of_filters
        for x = 1:stride:M_New
            for y = 1:stride:N_New
                for s = 1:f
                    for t = 1:f
                        for channel = 1:C
                            feature_map(x, y, filter) = feature_map(x, y, filter) + double(img(x + s - 1, y + t - 1, channel)) * filters(s, t, filter);
                        end
                    end
                end
            end
        end
    end
end