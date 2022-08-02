clc,clear
%cam = webcam('HP HD Camera');
detector=yolov4ObjectDetector("csp-darknet53-coco")
a=843252.4645;
b=0.465731406;
c=8.78426E-14;
d=-0.304288297;
f = figure;
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
%while ishandle(f)
inputSize = [224 224 3];
I=imread("IndoorObject1.jpeg"); 
img = imresize(I,inputSize(1:2));
% %img = snapshot(cam);
    [bbox,score,label] = detect(detector,img);
    bbox
    label
% bbox=[ 15.68         61.84         20.72         14.52;
%         184.49        126.25         13.62         24.80;
%          57.49         31.32         19.43         44.79;
%           1.00         74.10        112.30        142.41];
bbox 
%%
%defaultString=[];
  for i = 1:size(bbox, 1)
        areaBbox(i) = bbox(i,4)*bbox(i,3)
        areaImg = size(img,1)*size(img,2);
        bbox
        
        

        label(i)
        if label(i)=="person" | label(i)=="book" | label(i)=="pottedplant"
                aBbox(i) = 5.587*areaBbox(i)   
                %uzaklik(i)=d+(a-d)/(1+(oran(i)*5.587/c)^b);
        
          
        else if label(i)=="mouse" | label(i)=="cup"| label(i)=="cell phone"
                aBbox(i) = 23*areaBbox(i)
                %uzaklik(i)=d+(a-d)/(1+(oran(i)*22.857/c)^b);
                %areaImg(i) = size(img,1)*size(img,2)*1000;
        else if  label(i)=="bottle" 
                aBbox(i) = 8*areaBbox(i)

        else if label(i)=="refrigerator" 
                aBbox(i) = 0.42*areaBbox(i)
                %uzaklik(i)=d+(a-d)/(1+(oran(i)*0.117/c)^b);
                %areaImg(i) = size(img,1)*size(img,2)*1;

        else if label=="chair"
                aBbox(i) = 0.63*areaBbox(i)
                %uzaklik(i)=d+(a-d)/(1+(oran(i)*0.147/c)^b);
                %areaImg(i) = size(img,1)*size(img,2)*0.147;
        
        else if label=="laptop" | label=="handbag" | label=="backpack" | label(i)=="microwave" 
                aBbox(i) = 2.011*areaBbox(i)
                %uzaklik(i)=d+(a-d)/(1+(oran(i)*2.011/c)^b);
                %areaImg(i) = size(img,1)*size(img,2)*1.5;
        end
        end
        end
        end
        end
        end
        
        oran(i) = aBbox(i)/areaImg
        uzaklik(i)=100*(d+(a-d)/(1+(oran(i)/c)^b))
          %dist = 21.1/oran;
        uzaklik(i)=uint8(uzaklik(i))
        %format bank
        %uzak(i)=uint8(uzaklik(i))
        str=string(label(i))
        strU=string(uzaklik(i))
        defaultString(i)= strcat(str,' at ',{', '}, strU,' cm')
       

%         %Speak(obj, defaultString);
      annotation = sprintf('%s%.2f %s  %.2fcm', '%',  score(i)*100, label(i), uzaklik(i));
       img = insertObjectAnnotation(img, 'rectangle', bbox(i,:), annotation);
end
defaultString
%img = insertObjectAnnotation(img, 'rectangle', bbox);    
image(img)
drawnow
for i = 1:size(bbox, 1) 
Speak(obj, defaultString(i)); 
end
%end
%clear cam