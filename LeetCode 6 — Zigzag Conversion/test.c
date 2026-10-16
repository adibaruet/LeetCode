
#include <string.h>
#include <stdlib.h>

char* convert(char* s, int numRows) {
    int n = strlen(s);

    if (numRows == 1 || numRows >= n) {
        return s;
    }

    char *result = malloc((n + 1) * sizeof(char));
    int index = 0;

    for (int row = 0; row < numRows; row++) {
        int pos = row;
        int down = 2 * (numRows - 1 - row);
        int up = 2 * row;
        int goingDown = 1;

        while (pos < n) {
            result[index++] = s[pos];

            if (row == 0) {
                pos += down;
            } else if (row == numRows - 1) {
                pos += up;
            } else {
                pos += goingDown ? down : up;
                goingDown = !goingDown;
            }
        }
    }

    result[index] = '\0';
    return result;
}
