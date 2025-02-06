
function multiply!(a::Array{Int,1}, b::Array{Int,2}, mod::Int, t::Int)
    x1::Int = (a[1] + a[4]) * (b[t,1] + b[t,4])
    x2::Int = (a[3] + a[4]) * b[t,1]
    x3::Int = a[1] * (b[t,2] - b[t,4])
    x4::Int = a[4] * (b[t,3] - b[t,1])
    x5::Int = (a[1] + a[2]) * b[t,4]
    x6::Int = (a[3] - a[1]) * (b[t,1] + b[t,2])
    x7::Int = (a[2] - a[4]) * (b[t,3] + b[t,4])
    b[t+1,1] = (x1 + x4 - x5 + x7)%mod
    b[t+1,2] = (x3 + x5)%mod
    b[t+1,3] = (x2 + x4)%mod
    b[t+1,4] = (x1 + x3 - x2 + x6)%mod
    return
end
# const m=[Int[1, 1, 0, 1], Int[1, 0, 1, 1]]
# const m1=Int[1, 1, 0, 1]
# const m2=Int[1, 0, 1, 1]
function backtrack!(t::Int, mod::Int, wlength::Int,x::Array{Int,1},ce::Array{Int,2},result::Array{Bool,1},m1::Array{Int,1},m2::Array{Int,1}) 
    if result[1]
        # println("give up branch") # work, print $length times
        return 
    end
    if t >= wlength 
        if ((ce[t,1] == 1 && ce[t,2] == 0 && ce[t,3] == 0 && ce[t,4] == 1) || (ce[t,1] == mod - 1 && ce[t,2] == 0 && ce[t,3] == 0 && ce[t,4] == mod - 1)) 
            result[1] = true
        end
    else 
        for i in 0:1
            x[t+1] = i;
            # mi = m[i+1]
            mi = i==0 ? m1 : m2
            if t==0
                ce[1,1] = mi[1]
                ce[1,2] = mi[2]
                ce[1,3] = mi[3]
                ce[1,4] = mi[4]
            else
                multiply!(mi, ce, mod, t)
            end
            backtrack!(t + 1, mod, wlength,x,ce,result,m1,m2);
            if result[1]
                # println("give up branch") # work, print $length times
                return 
            end
        end
    end
    return
end
function process(mod::Int) 
    println(mod)
    
    wlength::Int = 0

    while true
        wlength+=1
        x = zeros(Int,wlength)
        # ce = Array{Int,1}[Int[0 for j in 1:4] for i in 1:wlength]
        ce = zeros(Int,wlength,4)
        result = [false]
        
        backtrack!(Int(0), mod, wlength,x,ce,result,Int[1, 1, 0, 1],Int[1, 0, 1, 1])

        if result[1]
            if wlength < mod
                println("length: ",wlength)
                println(x)
                print("[")
                for ii in 1:wlength
                    print("[[",ce[ii,1],",",ce[ii,2],"],[")
                    print(ce[ii,3],",",ce[ii,4],"]]")
                    print(ii==wlength ? "" : ",\n")
                end
                println("]")
            end
        end
        if result[1]
            break
        end
    end
end

# using Profile
using BenchmarkTools
if abspath(PROGRAM_FILE) == @__FILE__
    if size(ARGS,1) == 0
        for i in 400:404
            process(i)
        end
    elseif ARGS[1] == "test"
        # --track-allocation=<setting>
        # none（默认值，不测量内存分配）、user（测量除 Julia core 代码之外的所有代码的内存分配）或 all（测量 Julia 代码中每一行的内存分配）

        # process(20) # warm up
        # @time run(`./run 400 401`)
        # @time run(`./run2 400 401`)
        # @time run(`node distanceOfMatrix.js 400 401`)
        # @time process(400)
        # @time process(400)
        # @allocated process(400)
        # @profile process(400)
        # Profile.print(format=:flat)
        # @btime process(400)
        @btime run(`./run 400 401`)
        # @btime run(`./run2 400 401`)
        # @btime run(`node distanceOfMatrix_1DArray.js 400 401`)
    elseif ARGS[1] == "time"
        t2 = @elapsed run(`node distanceOfMatrix_1DArray.js 400 401`)
        # t2 = @elapsed run(`node distanceOfMatrix.js 400 401`)
        t1 = @elapsed run(`./run 400 401`)
        process(20) # warm up
        t3 = @elapsed process(400)
        println("c $t1 seconds")
        println("js $t2 seconds")
        println("julia $t3 seconds")
    end
end

