using System;

class Program
{
    static int[,] M = new int[,] {
        { 1, 1, 0, 1 },
        { 1, 0, 1, 1 }
    };

    static int[] M0 = new int[] { 1, 1, 0, 1 };
    static int[] M1 = new int[] { 1, 0, 1, 1 };

    static void Multiply(int[] a, int[,] ce, int modulus, int t)
    {
        int x1 = (a[0] + a[3]) * (ce[t - 1, 0] + ce[t - 1, 3]);
        int x2 = (a[2] + a[3]) * ce[t - 1, 0];
        int x3 = a[0] * (ce[t - 1, 1] - ce[t - 1, 3]);
        int x4 = a[3] * (ce[t - 1, 2] - ce[t - 1, 0]);
        int x5 = (a[0] + a[1]) * ce[t - 1, 3];
        int x6 = (a[2] - a[0]) * (ce[t - 1, 0] + ce[t - 1, 1]);
        int x7 = (a[1] - a[3]) * (ce[t - 1, 2] + ce[t - 1, 3]);
        ce[t, 0] = (x1 + x4 - x5 + x7) % modulus;
        ce[t, 1] = (x3 + x5) % modulus;
        ce[t, 2] = (x2 + x4) % modulus;
        ce[t, 3] = (x1 + x3 - x2 + x6) % modulus;
    }

    static bool Backtrack(int t, int modulus, int wlength, int[] x, int[,] ce)
    {
        if (t >= wlength)
        {
            if ((ce[t - 1, 0] == 1 && ce[t - 1, 1] == 0 && ce[t - 1, 2] == 0 && ce[t - 1, 3] == 1) ||
                (ce[t - 1, 0] == modulus - 1 && ce[t - 1, 1] == 0 && ce[t - 1, 2] == 0 && ce[t - 1, 3] == modulus - 1))
            {
                return true;
            }
        }
        else
        {
            for (int i = 0; i < 2; i++)
            {
                x[t] = i;
                int[] mi;
                if (i==0){
                    mi=M0;
                }else{
                    mi=M1;
                }
                if (t == 0)
                {
                    for (int j = 0; j < 4; j++)
                    {
                        ce[t, j] = mi[j];
                    }
                }
                else
                {
                    Multiply(mi, ce, modulus, t);
                }
                if (Backtrack(t + 1, modulus, wlength, x, ce))
                {
                    return true;
                }
            }
        }
        return false;
    }

    static void Process(int modulus)
    {
        Console.WriteLine($"\n{modulus}");

        int wlength = 0;
        while (true)
        {
            wlength += 1;

            int[] x = new int[100];
            int[,] ce = new int[100, 4];

            bool result = Backtrack(0, modulus, wlength, x, ce);

            if (result)
            {
                if (wlength < modulus)
                {
                    Console.WriteLine($"length: {wlength}");
                    int[] slicedArray1 = new int[wlength];
                    Array.Copy(x, 0, slicedArray1, 0, wlength);
                    Console.WriteLine("["+string.Join(",",slicedArray1)+"]");
                    for (int i = 0; i < wlength; i++)
                    {
                        Console.WriteLine($"[{ce[i, 0]},{ce[i, 1]},{ce[i, 2]},{ce[i, 3]}]");
                    }
                }
            }

            if (result)
            {
                break;
            }
        }
    }

    static void Main(string[] args)
    {
        int start, end;

        if (args.Length >= 3)
        {
            start = int.Parse(args[1]);
            end = int.Parse(args[2]);
        }
        else
        {
            start = 400;
            end = 401;
        }

        for (int i = start; i < end; i++)
        {
            Process(i);
        }
    }
}
