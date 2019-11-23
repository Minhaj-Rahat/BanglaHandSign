clear all;close all;clc;
%% Load training and test data using imageSet.

traindir = fullfile('data','train');

%% imageSet recursively scans the directory tree containing the images.
trainingSet = imageSet(traindir,   'recursive');

minSetCount = min([trainingSet.Count]); % determine the smallest amount of images in a category

% Use partition method to trim the set.
trainigSet = partition(trainingSet, minSetCount, 'randomize');

%%Choosing cellsize for HOG feature extraction

cellSize = [4 4];

hogFeatureSize = 20736;
%% The trainingSet is an array of imageSet objects: one for each bangla alphabet.
%Loop over the trainingSet and extract HOG features from each image.
trainingFeatures = [];
trainingLabels   = [];

for p = 1:numel(trainingSet)

    numImages = trainingSet(p).Count;
    features  = zeros(numImages, hogFeatureSize, 'single');

    for i = 1:numImages

        img = read(trainingSet(p), i);
        img =double(img);       
        features(i, :) = extractHOGFeatures(img, 'CellSize', cellSize); %extracting HOG feature
        trainingLabels=[trainingLabels;p]; %assigning digits as label
    end


    

    trainingFeatures = [trainingFeatures; features];   
  

end


trainingFeatures=double(trainingFeatures);

classifier = svmtrain(trainingLabels,trainingFeatures,'-q -t 1 -c 16'); %training a SVM model based on the extracted features

