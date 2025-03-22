function A = trapezioComposto(a,b,f,n)
   if (n == 0)
       A = 0;
   else
       h = (b-a)/n;
       area = ((f(a)+f(a+h))*h)/2;
       A = area + trapezioComposto(a+h,b,f,n-1);
   end
end
