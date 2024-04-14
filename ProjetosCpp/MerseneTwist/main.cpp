#include <iostream>
#include <random>
using namespace std;

int main()
{
    random_device rd;
    mt19937 mt(rd());
    uniform_int_distribution<int> dist(0, 99);

    for (int i = 0; i < 10; i++)
        cout << dist(mt) << " ";

    cout << endl;

    return 0;
}
