%======================
% Lazy Evaluation
%======================

declare
fun lazy {IntsFrom N}
   N|{IntsFrom N+1}
end

{Browse {IntsFrom 10}}
{Browse {IntsFrom 10}.2.2.1}

%=====================
% Lazy Append
%=====================

declare
fun lazy {LAppend Xs Ys}
   case Xs
   of X|Xr then X|{LAppend Xr Ys}
   [] nil then Ys
   end
end

{Browse {LAppend [1 2 3] [4 5 6]}}
{Browse {LAppend [1 2 3] [4 5 6]}.2.2.2.1}

%=====================
% Hamming's Problem
%=====================

% Function to merge two Lists
declare
fun lazy {Merge Xs Ys}
   case Xs#Ys
   of  (X|Xr)#(Y|Yr) then
      if X<Y then X|{Merge Xr Ys}
      elseif X>Y then Y|{Merge Xs Yr}
      else X|{Merge Xr Yr}
      end
   end
end

%Function to compute times
declare
fun lazy {Times N Xs}
   case Xs
   of nil then nil
   [] X|Xr then N*X|{Times N Xr}
   end
end

%Hammings List
declare H
H = 1|{Merge {Times 2 H} {Merge {Times 3 H} {Times 5 H}}}

{Browse H}
{Browse {List.take H 11}}

%=====================
% Lazy Quick Sort
%=====================

% Partition Function
declare
proc {Partition Xs Pivot Left Right}
   case Xs
   of X|Xr then
      if X<Pivot
      then L in
	 Left = X|L
	 {Partition Xr Pivot L Right}
      else R in
	 Right=X|R
	 {Partition Xr Pivot Left R}
      end
   [] nil then Left=nil Right=nil
   end
end

declare
fun lazy {QuickSort Xs}
   case Xs
   of X|Xr then Left Right in
      {Partition Xr X Left Right}
      {LAppend {QuickSort Left} X|{QuickSort Right}}
   [] nil then nil
   end
end

{Browse {QuickSort [5 3 7 6 4 9 2]}}
{Browse {List.take {QuickSort [5 3 7 6 4 9 2]} 7}}

