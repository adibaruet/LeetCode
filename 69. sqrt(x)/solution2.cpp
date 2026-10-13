
class Solution {
public:
    int mySqrt(int x) {
        int i = 0;

        while (1LL * i * i <= x) {
            i++;
        }

        return i - 1;
    }
};
