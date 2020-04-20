
declare Form Eval in

proc {Form F}
  or X E in F = bind(X E)
  [] X   in F = var(X)
  [] X Y in F = eq(X Y) {Form X} {Form Y}
  [] X Y in F = and(X Y) {Form X} {Form Y}
  [] X Y in F = orf(X Y) {Form X} {Form Y}
  end
end

%TODO: make some method that forces equal variables to have the same assignment
proc {Assignable F Ff}
  or X E Ee A in F = bind(X E) {Assignable E Ee} Ff=bind(X,Ee) {Enforce X A Ee}
  [] X A in F = var(X) Ff=var(X,A)
  [] X Y Xx Yy in F = eq(X Y) {Assignable X Xx} {Assignable Y Yy} Ff=eq(Xx Yy)
  [] X Y Xx Yy in F = and(X Y) {Assignable X Xx} {Assignable Y Yy} Ff=and(Xx Yy)
  [] X Y Xx Yy in F = orf(X Y) {Assignable X Xx} {Assignable Y Yy} Ff=orf(Xx Yy)
  end
end

proc {Enforce X A F}
  or Xx E  in F = bind(Xx E) (X==Xx=true)%don't do anything if variable is bound again
  [] Xx E  in F = bind(Xx E) (X==Xx=false) {Enforce X A E}
  [] Xx    in F = var(Xx A)  (X==Xx=true)
  [] Xx Aa in F = var(Xx Aa) (X==Xx=false)
  [] V W in F = eq(V W) {Enforce X A V} {Enforce X A W}
  [] V W in F = and(V W) {Enforce X A V} {Enforce X A W}
  [] V W in F = orf(V W) {Enforce X A V} {Enforce X A W}
  end
end


proc {Eval F} %this needs assigneable formula
  local Xor in
    or X E in F = bind(X E) {Eval E}
    [] X A in F = var(X A) {Eval A}    %variables need to have a space for their assignment
    [] X Y A1 A2 in F = eq(var(X A1) var(Y A2)) A1=A2 Xor=0
    [] X A Y in F = eq(var(X A) Y) A=Y Xor=1
    [] X Y in F = and(X Y) {Eval X} {Eval Y}
    [] X Y in F = orf(X Y) {Eval X}
    [] X Y in F = orf(X Y) {Eval Y}
    end
  end
end



local F X Y Z in
  thread {Form F} end
  F = var(X)
  {Browse F}
end
