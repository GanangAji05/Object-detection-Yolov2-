data = load('vaporvideo.mat');
gTruth = data.vaporvideo;
vehicleDetector = load('yolov2VehicleDetector.mat');
lgraph = vehicleDetector.lgraph;
[imds,bxds] = objectDetectorTrainingData(gTruth);
cds = combine(imds,bxds);
options = trainingOptions('sgdm', ...
       'InitialLearnRate', 0.001, ...
       'Verbose',true, ...
       'MiniBatchSize',16, ...
       'MaxEpochs',30, ...
       'Shuffle','every-epoch', ...
       'VerboseFrequency',10); 
[detector,info] = trainYOLOv2ObjectDetector(cds,lgraph,options);