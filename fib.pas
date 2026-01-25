program fib;

var
  F1, F2, F3: integer;
  I: integer;

begin
  F1 := 0;
  F2 := 1;
  writeln(F1:10);
  writeln(F2:10);
  for I := 3 to 20 do
  begin
    F3 := F1 + F2;
    writeln(F3:10);
    F1 := F2;
    F2 := F3;
  end;
end.
