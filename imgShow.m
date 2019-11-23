%this function is used to show the image of bangla alphabets based on prediction
function imgShow(class)

switch class
    case 1
        subplot(2,2,4);imshow('banglaPics\oo.png');
        return
    case 2
        subplot(2,2,4);imshow('banglaPics\ka.png');
        return
    case 3
        subplot(2,2,4);imshow('banglaPics\i.png');
        return
    case 4
        subplot(2,2,4);imshow('banglaPics\oi.png');
        return
    case 5
        subplot(2,2,4);imshow('banglaPics\ou.png');
        return
    case 6
        subplot(2,2,4);imshow('banglaPics\uo.png');
        return
    case 7
        subplot(2,2,4);imshow('banglaPics\g.png');
        return
    case 8
        subplot(2,2,4);imshow('banglaPics\m.png');
        return
    case 9
        subplot(2,2,4);imshow('banglaPics\l.png');
        return
    case 10
        subplot(2,2,4);
        imshow('banglaPics\aa.png');
        return
    
    
    otherwise
        return
end

end

