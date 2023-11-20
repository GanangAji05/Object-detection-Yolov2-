trainingData = load('Liquid.mat'); %
trainingData.imageFilename = fullfile( ...
    trainingData.Liquid.imageFilename); %
rng(0);
trainingData2 = struct2table(trainingData);
shuffledIdx = randperm(height(trainingData2));
trainingData2 = trainingData2(shuffledIdx,:);
trainingData3 = trainingData2.Liquid(:,:); %
imds = imageDatastore (trainingData3.imageFilename); 
blds = boxLabelDatastore(trainingData3(:,2:end));
ds = combine(imds, blds);
net = load('yolov2VehicleDetector.mat');
lgraph = net.lgraph;

numClasses= 3;
numAnchorBoxes = 4;
outFilters = (5 + numClasses).*numAnchorBoxes;
yolov2ConvLayer = convolution2dLayer(3,outFilters,'Name','yolov2ConvUpdated',...
    'Padding', 'same',...
    'WeightsInitializer',@(sz)randn(sz)*0.01);
yolov2ConvLayer.Bias = zeros(1,1,outFilters);
lgraph = replaceLayer(lgraph,'yolov2ClassConv',yolov2ConvLayer);

lgraph.Layers
options = trainingOptions('sgdm',... %sgdm rmsprop adam
          'InitialLearnRate',0.0001,... %0.0001
          'Verbose',true,...
          'MiniBatchSize',16,... % 8 16
          'MaxEpochs',200,... %130 200 300
          'Shuffle','never',...
          'VerboseFrequency',30,...
          'CheckpointPath',tempdir);
      
[detectorYOLOv2,info] = trainYOLOv2ObjectDetector(ds,lgraph,options);

figure
plot(info.TrainingLoss)
grid on
xlabel('Number of Iterations')
ylabel('Training Loss')
plot(info.TrainingRMSE)

save('detectorYOLOv2')