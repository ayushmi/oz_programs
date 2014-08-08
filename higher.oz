% Functions are "First Class Values"
%Functions as variables

local X Double in
   fun {Double Y} 2*Y end
   X = Double
   {Browse {X 2}}
end

%Function can be passed as arguments

local Accumulate Product Addition in
   fun {Product X Y}
      X*Y
   end
   fun {Addition X Y}
      X+Y
   end
   fun {Accumulate L BinOp Identity}
      case L
      of nil then Identity
      [] X|Xr then {BinOp X {Accumulate Xr BinOp Identity }}
      end
   end
   {Browse {Accumulate [1 2 3] Product 1}}
   {Browse {Accumulate [1 2 3 4] Addition 0}}
end

% Return a Function as a value
declare
fun {AddX X}
   %Anonymous Function
   fun {$ Y} X+Y end
end

declare
F = {AddX 5}
{Browse {F 10}}

% Map: Input- a unary function and a list
%Apply unary function on the list
declare
fun {Map Xs UnaryFunction}
   case Xs
   of nil then nil
   [] X|Xr then {UnaryFunction X}|{Map Xr UnaryFunction}
   end
end
%Square the elements of list using Map
{Browse {Map [1 2 3] fun {$ X} X*X end}}

%FoldL: Input- a left associative binary function, an Identity and a list
declare
fun {FoldL Xs BinaryFunction Partial}
   case Xs
   of nil then Partial
   [] X|Xr then {FoldL Xr BinaryFunction {BinaryFunction Partial X}}
   end
end
%Sum of squares of list using Map and FoldL
{Browse {FoldL {Map [1 2 3] fun {$ X} X*X end} fun {$ X Y} X+Y end 0}}

%FoldR: a right associative binary function, an Identity and a list
declare
fun {FoldR Xs BinaryFunction Identity}
   case Xs
   of nil then Identity
   [] X|Xr then {BinaryFunction X {FoldR Xr BinaryFunction Identity}}
   end
end
%Sum of squares of list using Map and FoldR
{Browse {FoldL {Map [1 2 3 4] fun {$ X} X*X end} fun {$ X Y} X+Y end 0}}

%Performing Map using FoldL
declare
fun {MapUsingFold Xs F}
   {FoldR Xs fun {$ X Y} {F X}|Y end nil}
end
%Performing Square of elements of a list using Map as defined above
{Browse {MapUsingFold [3 2 1] fun {$ X} X*X end}}

