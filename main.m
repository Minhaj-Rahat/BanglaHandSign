clear all;clc;
%load the trained model
load model.mat
imaqreset

depthVid=videoinput('kinect',2);
%% 
triggerconfig(depthVid,'manual');
depthVid.FramesPerTrigger=1;
depthVid.TriggerRepeat=inf;
set(getselectedsource(depthVid),'TrackingMode','Skeleton')

start(depthVid);
himg=figure;
while ishandle(himg)
    trigger(depthVid);
    [depthMap,~,depthMetaData]=getdata(depthVid);
    
    
    idx = find(depthMetaData.IsSkeletonTracked);
    
    
    subplot(2,2,1);
    imshow(depthMap,[0 4096]);
    
    if idx~=0
        righthand = depthMetaData.JointDepthIndices(12,:,idx);
        sh_left = depthMetaData.JointDepthIndices(5,:,idx);
        head = depthMetaData.JointDepthIndices(4,:,idx);
        A=righthand-head;
        B=sh_left-head;
        de=abs(det([A;B]));
        angle=atan2(de,dot(A,B));
        rightelbow = depthMetaData.JointDepthIndices(10,:,idx);
        rightHandWorldCoordinate = depthMetaData.JointWorldCoordinates(12,:,idx);
        zCoord=1e3*min(depthMetaData.JointWorldCoordinates(12,:,idx));
        radius=round(90-zCoord/50);
        rightHandBox=[righthand-.5*radius 1.2*radius 1.2*radius];
        rectangle('position',rightHandBox,'EdgeColor',[1 1 0]);
        im = imcrop(depthMap,rightHandBox);
        subplot(2,2,2);
        imshow(im,[0 4096]);
		if righthand>rightelbow | angle<.6 | angle>1.9
            subplot(2,2,4);imshow('banglaPics\noSign.png');
        
        elseif ~isempty(im)
            imSize = size(im);
            for k=1:imSize(1)
                for j=1:imSize(2)
                    if im(k,j)>1500
                        im(k,j)=0;
                    end
                end
            end
            subplot(2,2,3);
            imshow(im,[0,4096]);
            img = preprocess(im);
            % extract features
            features =double(extractHOGFeatures(img, 'CellSize', [4 4]));
            %classify the image
            [class,~,~]=svmpredict(1,features,classifier,'-q'); %%here the classifier is the trained model.
            imgShow(class);
             
        end
        
    end
    
    
end