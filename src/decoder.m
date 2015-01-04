function [ err ] = decoder( audio, pos, watermark )

reduce = 1;
two_D_audio = audio22D(audio);
DC_array = DC(two_D_audio);
DC_cell = splitDxD(DC_array, 4);
DC_cell_size = size(DC_cell);
DCT_cell = {};
for i = 1:DC_cell_size(1)
    row = {};
    for j = 1:DC_cell_size(2)
        tmp = dct2(DC_cell{i,j});
        row = [row,tmp];
    end
    DCT_cell = [DCT_cell;row];
end

err = 0;
for i = 1:size(watermark,2)
    bit = 0;
    for j=1 : floor(size(DCT_cell,2)/reduce)
        if(abs(DCT_cell{i,j}(pos(i,1),pos(i,2))) - ...
            abs(DCT_cell{i,j}(pos(i,3),pos(i,4))) >= 0)
            bit = bit+1;
        else 
            bit = bit-1;
        end
    end
    if((bit < 0&& watermark(i) ==1) || (bit >= 0&& watermark(i) == 0))
        err = err + 1;
    end
end

err = err/size(watermark,2);

end
