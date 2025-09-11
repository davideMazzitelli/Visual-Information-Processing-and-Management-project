function [labelled_image, info] = preprocessing(image, info)

    im = imresize(image, [224 224]);
    temp = im;
    r = rand;
    if(r < 0.2)
        temp = imgaussfilt(temp,2*rand);    
    else
        if(r<0.4)
            temp = imnoise(temp,"salt & pepper", 0.05 + (0.3 - 0.05)*rand);
        else
            if (r<0.6)
                nr = 32;
                nim = imresize(temp, [nr nr]);
                temp = imresize(nim, [224 224],"nearest");
            end
        end
    end

    im = temp;

    labelled_image = {im, info.Label};
end