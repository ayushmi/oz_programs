%===========================
% Recursive Data Types
%===========================

declare
T = tree(root:3
	 left:tree(root:1
		   left:nil
		   right:tree(root:2
			      left:nil
			      right:nil))
	 right:tree(root:7
		    left:tree(root:5
			      left:nil
			      right:nil)
		    right:tree(root:8
			       left:nil
			       right: nil) ))

declare
proc {Inorder T}
   case T
   of nil then skip
   else
      {Inorder T.left}
      {Browse T.root}
      {Inorder T.right}
   end
end
{Inorder T}