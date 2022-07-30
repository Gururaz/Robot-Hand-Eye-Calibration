function y = objective(X)
y = power((sqrt(power(xdata-X(1),2)+power(ydata-X(2),2)+power(zdata-X(3),2))-R),2);
end