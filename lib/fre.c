#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LENGTH 100

// Action table
int actionTable[32][2] = {
    {5, 4}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0},
    {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {6, -2}, {0, 0}, {0, 0}, {0, 0}, {-4, -4},
    {-4, -4}, {-4, -4}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {0, 0}, {8, -2},
    {0, 0}, {10, 2}, {0, 0}, {0, 0}
};

// Goto table
int gotoTable[12][3] = {
    {1, 2, 0}, {0, 0, 0}, {3, 2, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 5}, {0, 0, 0},
    {0, 0, 7}, {0, 0, 0}, {0, 0, 0}, {0, 0, 8}, {0, 0, 0}
};
//The action table and goto table are defined as 2D arrays actionTable and gotoTable, respectively. These tables represent the transitions and actions to be taken based on the current state and input symbol.
char stack[MAX_LENGTH];
char input[MAX_LENGTH];

void shift(int state) {
    sprintf(stack, "%s %d", stack, state);
}

void reduce(int production) {
    int length = 0;
    switch (production) {
        case 1:
            length = 3;
            break;
        case 2:
        case 4:
        case 6:
            length = 1;
            break;
        case 3:
            length = 3;
            break;
        case 5:
            length = 5;
            break;
    }
    int i;
    for (i = 0; i < length; i++) {
        int stackLength = strlen(stack);
        int j = stackLength - 1;
        while (j >= 0 && stack[j] != ' ') {
            stack[j] = '\0';
            j--;
        }
    }
    int nonTerminalIndex = 0;
    switch (production) {
        case 1:
        case 2:
            nonTerminalIndex = 0;
            break;
        case 3:
        case 4:
            nonTerminalIndex = 1;
            break;
        case 5:
        case 6:
            nonTerminalIndex = 2;
            break;
    }
    int newState = gotoTable[atoi(&stack[strlen(stack) - 1])][nonTerminalIndex];
    sprintf(stack, "%s %d", stack, newState);
}

int main() {
    strcpy(input, "id * ( id + id ) $");
    strcpy(stack, "0");

    printf("Stack\t\tInput\t\tAction\n");
    printf("----------------------------------------\n");

    while (1) {
        //The actionKey is formed by concatenating the current state and input symbol.
        int state = atoi(&stack[strlen(stack) - 1]);
        char currentInput[3];
        strncpy(currentInput, &input[0], 2);
        currentInput[2] = '\0';
        char actionKey[5];
        sprintf(actionKey, "%d%s", state, currentInput);
//actionValue is obtained from the action table based on the actionKey. If the value is positive, it represents a shift operation. The shift function is called, the input symbol is removed from the input array, and the action is printed.
        int actionValue = actionTable[state][0];
        if (actionValue > 0) {
            shift(actionValue);
            memmove(&input[0], &input[3], strlen(input) - 2);
            input[strlen(input) - 2] = '\0';
            printf("%s\t\t%s\t\tShift %s\n", stack, input, currentInput);
        } else if (actionValue < 0) {
            reduce(abs(actionValue));
            printf("%s\t\t%s\t\tReduce by R%d\n", stack, input, abs(actionValue));
        } else {
            printf("%s\t\t%s\t\tAccept\n\nInput string is accepted.\n", stack, input);
            break;
        }
        //If the actionValue is negative, it represents a reduce operation. The reduce function is called, the production number is abs(actionValue), and the action is printed.
//f the actionValue is 0, it indicates an error, and the input string is rejected. The appropriate error message is printed.
        if (actionValue == 0) {
            printf("%s\t\t%s\t\tRejected\nError: Invalid input.\nInput string is rejected.\n", stack, input);
            break;
        }
    }

    return 0;
}
