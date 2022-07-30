function F = myfun(X,xdata,ydata,zdata,R)

  F = power(R - (sqrt(power(xdata - X(1),2) + power(ydata - X(2),2) + power(zdata - X(3),2))),2); 
end