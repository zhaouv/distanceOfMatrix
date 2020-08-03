
function multiply!(a::Array{Int,1}, b::Array{Int,1}, mod::Int, r::Array{Int,1})
    x1::Int = (a[1] + a[4]) * (b[1] + b[4])
    x2::Int = (a[3] + a[4]) * b[1]
    x3::Int = a[1] * (b[2] - b[4])
    x4::Int = a[4] * (b[3] - b[1])
    x5::Int = (a[1] + a[2]) * b[4]
    x6::Int = (a[3] - a[1]) * (b[1] + b[2])
    x7::Int = (a[2] - a[4]) * (b[3] + b[4])
    r[1] = (x1 + x4 - x5 + x7)%mod
    r[2] = (x3 + x5)%mod
    r[3] = (x2 + x4)%mod
    r[4] = (x1 + x3 - x2 + x6)%mod
end

function process(mod::Int) 
    println(mod)
    m=[[1, 1, 0, 1], [1, 0, 1, 1]]
    wlength::Int = 0
    while true
        wlength+=1
        x = Int[0 for i in 1:wlength]
        ce = [Int[0 for j in 1:4] for i in 1:wlength]
        result = false
        function backtrack(t::Int, mod::Int, wlength::Int) 
            if result
                return 
            end
            if t >= wlength 
                e = ce[t]
                if ((e[1] == 1 && e[2] == 0 && e[3] == 0 && e[4] == 1) || (e[1] == mod - 1 && e[2] == 0 && e[3] == 0 && e[4] == mod - 1)) 
                    result = true
                end
            else 
                for i in [0,1]
                    x[t+1] = i;
                    mi = m[i+1]
                    if t==0
                        ce[t+1] = mi
                    else
                        multiply!(mi, ce[t], mod, ce[t+1])
                    end
                    backtrack(t + 1, mod, wlength);
                    if result
                        return 
                    end
                end
            end

        end

        backtrack(0, mod, wlength)

        if result
            if wlength < mod
                println("length: ",wlength)
                println(x)
                print("[")
                for ii in 1:wlength
                    print("[[",ce[ii][1],",",ce[ii][2],"],[")
                    print(ce[ii][3],",",ce[ii][4],"]]")
                    print(ii==wlength ? "" : ",\n")
                end
                println("]")
            end
        end
        if result
            break
        end
    end
end

if abspath(PROGRAM_FILE) == @__FILE__
    # @time run(`run.exe 400 401`)
    # process(20) # warm up
    # @time process(400)
    for i in 400:404
        process(i)
    end
end

