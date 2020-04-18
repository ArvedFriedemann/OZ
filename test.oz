local Max X Y Z in
   proc {Max X Y Z}
      or  Z = X ((X >= Y) = true)
      []  Z = Y ((X <  Y) = true)
      end
   end
   Y=6
   Z=5
   {Max X Y Z} {Browse foo(a:X b:Y c:Z)}
end
