%clear all;close all;clc
%load the trained model
load model.mat
testDir=fullfile('data','test');
testSet     = imageSet(testDir, 'recursive');

%Cell size for HOG feature exxtraction
cellSize = [4 4];

hogFeatureSize = 20736;
%% The testDataSet is an array of 10 imageSet objects: one for each  bangla alphabet.
%Loop over the testDataSet and extract HOG features from each image. A

testFeatures = [];
testLabels=[];

for digit = 1:numel(testSet)

    numImages = testSet(digit).Count;
    features  = zeros(numImages, hogFeatureSize, 'single');

    for i = 1:numImages

        img = read(testSet(digit), i);

        % Apply pre-processing steps
        lvl = graythresh(img);
        img = im2bw(img, lvl);
        img = imresize(double(img),[100,100]);
        img =double(img);

        features(i, :) = (extractHOGFeatures(img, 'CellSize', cellSize)); %extracting HOG features from test data
        testLabels=[testLabels;digit]; %assigning digits as label
    end

    testFeatures = [testFeatures; features];      

end
testFeatures=double(testFeatures);
      
predictedLabels=svmpredict(testLabels,testFeatures,classifier); %here the classifier is the trained model.



