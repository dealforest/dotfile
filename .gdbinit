define pv
if $argc == 0
po [[UIWindow keyWindow] recursiveDescription]
end
if $argc == 1
po [$arg0 recursiveDescription]
end
if $argc == 2
po [$arg0 $arg1 recursiveDescription]
end
if $argc == 3
po [$arg0 $arg1 $arg2 recursiveDescription]
end
if $argc == 4
po [$arg0 $arg1 $arg2 $arg3 recursiveDescription]
end
if $argc == 5
po [$arg0 $arg1 $arg2 $arg3 $arg4 recursiveDescription]
end
if $argc == 6
po [$arg0 $arg1 $arg2 $arg3 $arg4 $arg5 recursiveDescription]
end
if $argc == 7
po [$arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 recursiveDescription]
end
if $argc == 8
po [$arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 recursiveDescription]
end
if $argc == 9
po [$arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 recursiveDescription]
end
if $argc == 10
po [$arg0 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 recursiveDescription]
end
end

document pv
print-view
pv        ... print window
pv <view> ... print view
end
