%==========================
% Programming with Lists
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
% Higher Order Programming
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