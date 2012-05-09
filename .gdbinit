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


# http://d.hatena.ne.jp/kent013/20081007/1223346011

set env NSDebugEnabled=YES
set env NSZombieEnabled=YES
set env NSDeallocateZombies=NO
set env MallocCheckHeapEach=100000
set env MallocCheckHeapStart=100000
set env MallocScribble=YES
set env MallocGuardEdges=YES
set env MallocCheckHeapAbort=1

set env CFZombie 5

define mh
info malloc-history $arg0
end 

document mh
malloc-history
mh <address> ... print malloc history
end

define mhd
shell malloc_history $arg0 $arg1
end 

document mhd
malloc-history detail
mhd <pid> <address> ... print malloc history detail
end
