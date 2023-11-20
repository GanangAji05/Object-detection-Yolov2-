%Creado por: Cesar Pachon
load ('VaporandLiquid.mat')
%load('DataSetTrain.mat')
Dataset = VaporandLiquid;

% imageSize = [224 224 3];

inputLayer = imageInputLayer([128 128 3],'Name','input','Normalization','none');
filterSize = [3 3];

middleLayers = [
    convolution2dLayer(filterSize, 16, 'Padding', 1,'Name','conv_1',...
    'WeightsInitializer','narrow-normal')
    batchNormalizationLayer('Name','BN1')
    reluLayer('Name','relu_1')
    maxPooling2dLayer(2, 'Stride',2,'Name','maxpool1')
    convolution2dLayer(filterSize, 32, 'Padding', 1,'Name', 'conv_2',...
    'WeightsInitializer','narrow-normal')
    batchNormalizationLayer('Name','BN2')
    reluLayer('Name','relu_2')
    maxPooling2dLayer(2, 'Stride',2,'Name','maxpool2')
    convolution2dLayer(filterSize, 64, 'Padding', 1,'Name','conv_3',...
    'WeightsInitializer','narrow-normal')
    batchNormalizationLayer('Name','BN3')
    reluLayer('Name','relu_3')
    maxPooling2dLayer(2, 'Stride',2,'Name','maxpool3')
    convolution2dLayer(filterSize, 128, 'Padding', 1,'Name','conv_4',...
    'WeightsInitializer','narrow-normal')
    batchNormalizationLayer('Name','BN4')
    reluLayer('Name','relu_4')
    ];

lgraph = layerGraph([inputLayer; middleLayers]);

numClasses = 5;
% baseNetwork = resnet50;
% featureLayer = 'activation_40_relu';
Anchors = [ 43 59
    18 22
    23 29
    84 109];

lgraph = yolov2Layers([128 128 3],numClasses,Anchors,lgraph,'relu_4');
%outFilters = (5 + numClasses).*anchorBoxes;
%yolov2ConvLayer = convolution2dLayer(3,outFilters,'Name','yolov2ConvUpdated',...
   %'Padding', 'same',...
    %'WeightsInitializer',@(sz)randn(sz)*0.01);
%yolov2ConvLayer.Bias = zeros(1,1,outFilters);

%  options = trainingOptions('sgdm', ...
%         'MiniBatchSize', 2, ....
%         'InitialLearnRate',1e-3, ...
%         'MaxEpochs',30,...
%         'CheckpointPath', tempdir, ...
%         'Shuffle','every-epoch'); 

options = trainingOptions('sgdm', ...
        'InitialLearnRate',0.001, ...
        'Verbose',true,'MiniBatchSize',16,'MaxEpochs',80,...
        'Shuffle','every-epoch','VerboseFrequency',50, ...
        'DispatchInBackground',true,...
        'ExecutionEnvironment','auto');
      
    
 [detectorYolov2,info] = trainYOLOv2ObjectDetector(Dataset,lgraph,options);
    
    save('detectorYOLOv2VaporLiquid')
