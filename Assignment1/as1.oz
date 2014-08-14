%==========================
% 1. Programming with Lists
%==========================

% Take
declare
fun {Take Xs N}
   if N==0 then nil
   else
      case Xs
      of nil then nil
      [] X|Xr then X|{Take Xr N-1}
      end
   end
end

{Browse {Take [1 2 3 4 5 6] 0}}
{Browse {Take [1 2 3 4 5 6] 5}}
{Browse {Take [1 2 3 4 5 6] 10}}

% Drop
declare
fun {Drop Xs N}
   if N==0 then Xs
   else
      case Xs
      of nil then nil
      [] X|Xr then {Drop Xr N-1}
      end
   end
end

{Browse {Drop [1 2 3 4 5 6] 3}}
{Browse {Drop [1 2 3 4 5 6] 0}}
{Browse {Drop [1 2 3 4 5 6] 10}}
{Browse {Drop [1 2 3 4 5 6] 1}}

% Cross Product
declare
fun {CrossProduct Xs Ys}
   local CrossProductHelper in
      fun {CrossProductHelper Y Xs}
	 case Xs
	 of nil then nil
	 [] X|Xr then [Y X]|{CrossProductHelper Y Xr}
	 end
      end
      case Xs
      of nil then nil
      [] X|Xr then {Append {CrossProductHelper X Ys} {CrossProduct Xr Ys}}
      end
   end
end

{Browse {CrossProduct nil [1 2 3]}}
{Browse {CrossProduct [1 2 3] nil}}
{Browse {CrossProduct [4 5 6] [1 2 3]}}

%==========================
% 2. Higher Order Programming
%==========================

% Filter
declare
fun {Filter F Xs}
   case Xs
   of X|Xr then
      if {F X}==true then X|{Filter F Xr}
      else {Filter F Xr}
      end
   [] nil then nil
   end
end

{Browse {Filter fun {$ X} X > 0 end [0-5 1 0-1 2 0-2 3 0-3 10]}}

% FoldR
declare
fun {FoldR F Xs Partial}
    case Xs
   of nil then Partial
   [] X|Xr then {F X {FoldR F Xr Partial}}
   end
end

{Browse {FoldR fun {$ X Y} X+Y end [1 2 3 4] 0}}

% Map using FoldR

declare
fun {Map F Xs}
   {FoldR fun {$ X Y} {F X}|Y end Xs nil}
end

{Browse {Map fun {$ X} X*X end [1 2 3]}}
{Browse {Map fun {$ X} 1 end [1 2 3]}}

%==========================
% 3. Movie Feed
%==========================


%==========================
% 4. Tail Recursion
%==========================

declare
fun {IFib N}
   local Fib in
      fun {Fib N Fn1 Fn2}
	 if N == 0 then Fn1
	 elseif N == 1 then Fn2
	 else
	    {Fib N-1 Fn2 Fn1+Fn2}
	 end
      end
      {Fib N 0 1}
   end
end

{Browse {Map IFib [0 1 2 3 4 5 6 7 8 9 10]}}

%==========================
% 5. Lazy Evaluation
%==========================

% Sieve of Eratosthenes

%==========================
% 6. Lazy Evaluation
%==========================

% ExpSeries

% Approximant

%==========================
% 7. Threads
%==========================

declare
fun {AvgCount Count}
   local RBits Average in
      thread
	 RBits = {OS.rand} mod 2|RBits
      end
      thread
	 Average = {FoldR fun {$ X Y} X+Y end {Take RBits Count} 0}
      end
      Average div Count
   end
end

{Browse {AvgCount 10}}

%==========================
% END of Assignment
%==========================

