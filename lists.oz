%==================================
% Record in oz
%==================================

declare
AnExampleRecord = l(1:a 2:b)

{Browse AnExampleRecord}
{Browse AnExampleRecord.1}
{Browse AnExampleRecord.2}

declare
AnotherExampleRecord = l2(1:a 2:b 3:c)

{Browse AnotherExampleRecord}

% Width gives the number of attributes in an example record.
{Browse {Width AnotherExampleRecord}}

%==================================
% Lists Basics:
%  List is nil or list is a
%  record with arbitrary first
%  value and second value as list.
%==================================

declare
AnExampleList = [a b c]

{Browse AnExampleList.2.2.1}

%Length gives the length of the list
{Browse {Length AnExampleList}}

%Width measure the number of attributes in a record.
{Browse {Width AnExampleList}}

% A list with one element which is nil.
{Browse '|'(nil nil)}

%==================================
% Pattern Matching in Lists 
%==================================

% Length of a List
declare
fun {Length2 Xs}
   local Len in
      fun {Len Xs SoFar}
	 declare C
	 if SoFar == K then C=1 else C=0
	 case Xs
	 of nil then SoFar
	 [] X|Xr then {Len Xr 1+SoFar}
	 end
      end
      {Len Xs 0}
   end
end

{Browse {Length2 [1 2 3 4]}}

% kth element of a list for fixed k
declare
fun {FindK Xs K}
   case Xs
   of nil then nil
   else
      if K==0 then Xs.1 else {FindK Xs.2 K-1} end
   end
end

{Browse {FindK [1 2 3 4 5] 2}}

% Concatenation of two lists
declare
fun {ConcatList Xs Ys}
   case Xs
   of nil then Ys
   [] X|Xr then X|{ConcatList Xr Ys}
   end
end

{Browse {ConcatList [1 2 3] [5 6 7]}}


% Cross Product of a single element with a list
declare
fun {CrossProduct1 E Xs}
   case Xs
   of nil then nil
   [] X|Xr then [E X]|{CrossProduct1 E Xr}
   end
end

% Cross Product of two lists
declare
fun {CrossProduct Xs Ys}
   case Xs
   of nil then nil
   [] X|Xr then {ConcatList {CrossProduct1 X Ys} {CrossProduct Xr Ys}}
   end
end

{Browse {CrossProduct [1 2 3] [4 5 6]}}

% Reverse a list in O(n^2) time
declare
fun {ReverseSlow Xs}
   case Xs
   of nil then nil
   [] X|Xr then {Append {ReverseSlow Xr} [X]}
   end
end

{Browse {ReverseSlow [1 2 3]}}

% Reverse in O(n) time
declare
fun {ReverseFast Xs}
   local Reverse in
      fun {Reverse Xs SoFar}
	 case Xs
	 of nil then SoFar
	 [] X|Xr then {Reverse Xr X|SoFar}
	 end
      end
      {Reverse Xs nil}
   end
end

{Browse {ReverseFast [1 2 3 4]}}

% Reverse List without using helper function in exponential time
declare
fun {ReverseVerySlow Xs}
   if {Length Xs} < 2 then Xs
   else
      local Ys = {ReverseVerySlow Xs.2} in
	 Ys.1|{ReverseVerySlow Xs.1|{ReverseVerySlow Ys.2}}
      end
   end
end

{Browse {ReverseVerySlow [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]}}