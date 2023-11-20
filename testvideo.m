load ('vaporvideo.mat','vaporvideo')
vaporvideo.LabelDefinitions
vaporvideo = selectLabelsByName(vaporvideo,'vapor');
trainingData = objectDetectorTrainingData(vaporvideo);
summary(trainingData)
acfDetector = trainACFObjectDetector(trainingData,'NegativeSamplesFactor',2);

I = imread('video51_021.png');
bboxes = detect(acfDetector,I);
annotation = acfDetector.ModelName;
I = insertObjectAnnotation(I,'rectangle',bboxes,annotation);

figure 
imshow(I)