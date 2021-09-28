a=arduino();
configurePin(a,'D6','DigitalOutput')
pause(1)
writeDigitalPin(a,'D6',1);
pause(5)
writeDigitalPin(a,'D6',0);
clear a