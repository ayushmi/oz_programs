%====================================
% Factorial Using Simple Recursion
%====================================

declare
fun {Factorial N}
   if N==0 then 1
   else N*{Factorial N-1}
   end
end

{Browse {Factorial 5}}

%====================================
% Factorial Using Tail Recursion:
%   In this function no stack
%   ocerhead because of tail
%   recursion.
%====================================

declare
fun {IterFactorial N}
   local Fact in
      fun {Fact SoFar N}
	 if N==0 then SoFar
	 else {Fact N*SoFar N-1}
	 end
      end
      {Fact 1 5}
   end
end

{Browse {IterFactorial 5}}

