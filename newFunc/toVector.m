function [vector] = toVector(param,variance)
    vector = [param(~isnan(param)); variance];
end
    