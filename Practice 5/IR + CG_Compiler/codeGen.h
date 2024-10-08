enum code_ops 
{
    START, 
    HALT, 
    LD_INT, 
    LD_VAR, 
    STORE, 
    SCAN_INT_VALUE, 
    PRINT_INT_VALUE, 
    ADD,
    SUB,
    MUL,
    GT_OP,
    GTE_OP,
    LT_OP,
    LTE_OP,
    IF_START,
    ELSE_START,
    ELSE_END,
    WHILE_LABEL,
    WHILE_START,
    WHILE_END
};

char *op_name[] = {"start", "halt", "ld_int", "ld_var", "store", "scan_int_value", "print_int_value", "add", "sub", "mul", "gt", "gte", "lt", "lte","if_start", "else_start", "else_end", "while_label", "while_start", "while_end"};

struct instruction
{
    enum code_ops op;
    int arg;
};

struct instruction code[999];
extern int address;
int code_offset = 0;

