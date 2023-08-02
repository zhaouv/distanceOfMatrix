#include <iostream>
#include <array>

constexpr std::array<std::array<int, 4>, 2> M = {{
    {1, 1, 0, 1},
    {1, 0, 1, 1},
}};

using matrix = std::array<int, 4>;

constexpr matrix multiply(const matrix& a, const matrix& b, int mod)
{
    const int x1 = (a[0] + a[3]) * (b[0] + b[3]);
    const int x2 = (a[2] + a[3]) * b[0];
    const int x3 = a[0] * (b[1] - b[3]);
    const int x4 = a[3] * (b[2] - b[0]);
    const int x5 = (a[0] + a[1]) * b[3];
    const int x6 = (a[2] - a[0]) * (b[0] + b[1]);
    const int x7 = (a[1] - a[3]) * (b[2] + b[3]);
    const int c11 = (x1 + x4 - x5 + x7) % mod;
    const int c12 = (x3 + x5) % mod;
    const int c21 = (x2 + x4) % mod;
    const int c22 = (x1 + x3 - x2 + x6) % mod;
    return matrix {c11, c12, c21, c22};
}

bool backtrack(int t, int mod, int wlength, std::array<matrix, 100>& ce, std::array<int, 100>& x)
{
    if (t >= wlength)
    {
        const auto& e = ce[t - 1];
        if ((e[0] == 1 && e[1] == 0 && e[2] == 0 && e[3] == 1) || (e[0] == mod - 1 && e[1] == 0 && e[2] == 0 && e[3] == mod - 1))
        {
            return true;
        }
    }
    else
    {
        for (int i = 0; i <= 1; i++)
        {
            x[t] = i;
            if (t == 0)
            {
                ce[t] = M[i];
            }
            else
            {
                ce[t] = multiply(M[i], ce[t - 1], mod);
            }
            if (backtrack(t + 1, mod, wlength, ce, x)) {
                return true;
            }
        }
    }
    return false;
}

void process(int mod)
{
    std::cout << "\n"
              << mod << "\n";

    int wlength = 0;
    while (true)
    {
        ++wlength;

        std::array<int, 100> x;
        std::array<matrix, 100> ce;

        auto result = backtrack(0, mod, wlength, ce, x);

        if (result)
        {
            if (wlength < mod)
            {
                std::cout << "length: " << wlength << "\n";
                std::cout << "[";
                for (int ii = 0; ii < wlength; ii++)
                {
                    std::cout << x[ii] << (ii == wlength - 1 ? "" : ",");
                }
                std::cout << "]"
                          << "\n";
                std::cout << "[";
                for (int ii = 0; ii < wlength; ii++)
                {
                    std::cout << "[[" << ce[ii][0] << "," << ce[ii][1] << "],[";
                    std::cout << ce[ii][2] << "," << ce[ii][3] << "]]" << (ii == wlength - 1 ? "" : ",\n");
                }
                std::cout << "]"
                          << "\n";
            }
            break;
        }
    }
}

int main(int argc, char **argv)
{
    int start = 400, end = 405;
    if (argc >= 3)
    {
        start = atoi(argv[1]);
        end = atoi(argv[2]);
    }
    for (int i = start; i < end; i++)
    {
        process(i);
    }
    return 0;
}
