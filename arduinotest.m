clc ;
close all;
clear;

% motor1Pin1 = 25; 
% motor1Pin2 = 26; 
% enable1Pin = 14; 
delay = 10;

port = 'COM3';
board = 'ESP32-WROOM-DevKitV1';

a = arduino(port,board);

while true
%     %Turn off
%     a.writeDigitalPin(ledPin,0);
%     pause(delay/2);
%     
%     %Turn on
%     a.writeDigitalPin(ledPin,1);
%     pause(delay/2);

%     writePWMVoltage(a,"D14",);
      %Forward
      writeDigitalPin(a,"D0",1);
      writeDigitalPin(a,"D2",0);
      pause(delay/2);
      %Backward
      writeDigitalPin(a,"D4",0);
      writeDigitalPin(a,"D5",1);
      pause(delay/2);
      
end