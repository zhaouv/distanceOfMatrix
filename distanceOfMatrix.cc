#include <iostream>
#include <stdlib.h>

#define fout cout

using namespace std;

int multiply(int *a, int *b, int mod, int * r) {
    int x1 = (a[0] + a[3]) * (b[0] + b[3]);
    int x2 = (a[2] + a[3]) * b[0];
    int x3 = a[0] * (b[1] - b[3]);
    int x4 = a[3] * (b[2] - b[0]);
    int x5 = (a[0] + a[1]) * b[3];
    int x6 = (a[2] - a[0]) * (b[0] + b[1]);
    int x7 = (a[1] - a[3]) * (b[2] + b[3]);
    r[0] = (x1 + x4 - x5 + x7)%mod;
    r[1] = (x3 + x5)%mod;
    r[2] = (x2 + x4)%mod;
    r[3] = (x1 + x3 - x2 + x6)%mod;
    return 0;
}

int mt[] = {1, 1, 0, 1};
int mts[] = {1, 0, 1, 1};
int **m;

int init(){
    m=new int*[2];
    m[0]=mt;
    m[1]=mts;
    return 0;
}

int * x;
int ** ce;
bool result = false;

void backtrack(int t, int mod, int wlength) {
    if (result) return;
    if (t >= wlength) {
        int * e = ce[t - 1];
        if ((e[0] == 1 && e[1] == 0 && e[2] == 0 && e[3] == 1) || (e[0] == mod - 1 && e[1] == 0 && e[2] == 0 && e[3] == mod - 1)) {
            result = true;
        }
    } else {
        for (int i = 0; i <= 1; i++) {
            x[t] = i;
            int * mi = m[i];
            if(t==0){
                ce[t] = mi;
            }else{
                multiply(mi, ce[t - 1], mod, ce[t]);
            }
            backtrack(t + 1, mod, wlength);
            if (result) return;
        }
    }
}

void process(int mod) {
    fout << endl << mod << endl;

    int wlength = 0;
    while (1) {
        ++wlength;

        x = new int[wlength];
        ce = new int *[wlength];
        for(int ii=1;ii<wlength;ii++){
            ce[ii]=new int[4];
        }
        result = false;

        backtrack(0, mod, wlength);

        if (result) {
            if (wlength < mod) {
                fout << "length: " << wlength<< endl;
                fout << "[";
                for(int ii=0;ii<wlength;ii++){
                    fout << x[ii] << (ii==wlength-1?"":",");
                }
                fout << "]" << endl;
                fout << "[" ;
                for(int ii=0;ii<wlength;ii++){
                    fout << "[[" << ce[ii][0] << "," << ce[ii][1] << "],[";
                    fout << ce[ii][2] << "," << ce[ii][3] << "]]" << (ii==wlength-1?"":",\n");
                }
                fout << "]" << endl;
            }
        }
        delete x;
        for(int ii=1;ii<wlength;ii++){
            delete ce[ii];
        }
        delete ce;
        if (result) break;
    }
}

int main(int argc, char **argv){
    int start=400,end=405;
    if(argc>=3){
        start=atoi(argv[1]);
        end=atoi(argv[2]);
    }
    init();
    for(int i=start;i<end;i++){
        process(i);
    }
    delete m;
    return 0;
}





