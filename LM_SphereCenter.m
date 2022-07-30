function center = LM_SphereCenter(m,R,xdata,ydata,zdata)
  stepTol = 1e-8;
  funcTol = 1e-10;
  maxIteration = 500;
  %display : 'Display','iter','PlotFcns',@optimplotfunccount;
  options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','OptimalityTolerance',1e-12,'StepTolerance',stepTol, ...
  'MaxIter' , maxIteration,'TolFun', funcTol,'Display','iter','PlotFcns',{@optimplotfval,@optimplotresnorm});

   %options = optimoptions('lsqnonlin','Algorithm','levenberg-marquardt','OptimalityTolerance',1e-10,'StepTolerance',stepTol, 'MaxIter' , maxIteration,'TolFun', funcTol);
  lb = [];
  ub = [];
  
  fun = @(X) power((sqrt(power(xdata - X(1),2) + power(ydata - X(2),2) + power(zdata - X(3),2)) - R),2); 

  X0 = [m(1) m(2) m(3)];
  [center]= lsqnonlin(fun,X0,lb,ub,options);
  
  % exitflag
  %output

end