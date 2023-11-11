function out = mod_cell2array(x_in)
   for c = 1:size(x_in,2)
       tmp_mod = x_in{c};
       out(c) = min(tmp_mod,[],'all');
   end
end

