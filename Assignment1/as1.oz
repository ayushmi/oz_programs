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


declare
fun {FeedCountOne Word Feed}
   {FoldR fun {$ X Y} X+Y end {Map fun {$ Word2} if Word==Word2 then 1 else 0 end end Feed} 0}
end

declare
fun {FeedCountTwo Word FeedList}
   Word|{FoldR fun {$ X Y} X+Y end {Map fun {$ Feed} {FeedCountOne Word Feed} end FeedList} 0}|nil
end

declare
fun {FeedCount Keyword FeedList}
   {FoldR fun {$ X Y} X|Y end {Map fun {$ Word} {FeedCountTwo Word FeedList} end Keyword} nil}
end


{Browse {FeedCount [planetOfTheApes kick] [[planetOfTheApes is boring]
                               [kick is terrible]
                               [dabangg rocks]]}}


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
declare
fun lazy {IntsFrom N}
   N|{IntsFrom N+1}
end

declare
fun lazy {FilterMultipleOf X Ys F}
   case Ys
   of nil then nil
   [] Y|Yr then
      if {F X Y} then Y|{FilterMultipleOf X Yr F}
      else {FilterMultipleOf X Yr F}
      end
   end
end

declare
fun lazy {Seive Xs}
   case Xs
   of nil then nil
   [] X|Xr then X|{Seive {FilterMultipleOf X Xr fun {$ X Y} Y mod X \=0 end}}
   end
end

{Browse {Take {Seive {IntsFrom 2}} 10}}


%==========================
% 6. Lazy Evaluation
%==========================

%ExpSeries
declare
fun lazy {ExpSeries X}
   local ExpSeriesHelper in
      fun lazy {ExpSeriesHelper Xn X N}
	 Xn|{ExpSeriesHelper (Xn*X)/{IntToFloat N} X N+1}
      end
      {ExpSeriesHelper 1.0 X 1}
   end
end
{Browse {Take {ExpSeries 2.0} 10}}


%Abs- helper for Approximant
declare
fun {Abs X1}
   if X1>=0.0 then X1
   else 0.0-X1
   end
end
{Browse {Abs 0.0-1.0}}


% Approximant
declare
fun  {Apprximant Epsilon Xs}
   local ApprximantHelper in
      fun  {ApprximantHelper Xs SoFar}
	 case Xs
	 of X1|X2|Xr then
	    if {Or {Abs X2-X1}>=Epsilon X1==X2}   then {ApprximantHelper X2|Xr SoFar+X2}
	    else SoFar
	    end
	 end
      end
      if {Or {Abs Xs.2.1-Xs.1}>=Epsilon Xs.2.1==Xs.1} then {ApprximantHelper Xs Xs.1}
      else 0.0
      end
   end   
end
{Browse {Apprximant 0.374 {ExpSeries 0.5}}}
{Browse {Apprximant 0.376 {ExpSeries 0.5}}}
{Browse {Apprximant 0.0001 {ExpSeries 1.0}}}

%==========================
% 7. Threads
%==========================
declare
fun lazy {GenerateRandomBits}
   {OS.rand} mod 2|{GenerateRandomBits}
end

declare
fun lazy {CalculateSum RBits Count Sum}
   if Count==0 then Sum
   else
      case RBits
      of nil then Sum
      [] Bit|RBitsRest then {CalculateSum RBitsRest Count-1 Sum+Bit}
      end
   end
end

declare
fun {AvgCount Count}
   local RBits Sum in
      thread
	 RBits = {GenerateRandomBits}
      end
      thread
	  Sum = {CalculateSum RBits Count 0}
      end
      {IntToFloat Sum}/{IntToFloat Count}
   end
end

{Browse {AvgCount 10}-0.0}
%==========================
% END of Assignment
%==========================

