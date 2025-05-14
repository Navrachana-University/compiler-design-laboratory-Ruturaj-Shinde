  Project Title:   Hindi-style Custom Compiler with TAC and Assembly Code Generation

  Description:  

This project is a custom compiler that accepts a programming language using Hindi-style keywords such as:

  `dikhana` for `print`
  `yeh` for `if`
  `yato` for `else`
  `woh` for `else if`

It is similar in structure to C-style syntax but uses Hindi terms to make it more relatable and readable for users familiar with Hindi.

  Features:  

1. Parses Hindi-style code line-by-line (e.g., `x = 2 + 3   4;`)

2. Generates:

     Three-Address Code (TAC) for intermediate representation
     Assembly-level pseudo-code
     High-level output

3. Supports:

     Variable assignments
     Arithmetic expressions (`+`, ` `)
     Print statements
     Conditional statements using `yeh`, `yato`, and `woh`
     (Planned: Loop constructs using `ke_liye`)

  Tools Used:  

  Flex (Lexical Analyzer)
  Bison (Parser Generator)
  C Language (for compiler logic)

  Objective:  

The goal is to create a compiler that helps users understand how parsing, intermediate code generation, and assembly translation work, all through a simplified, Hindi-style syntax that is easier for native speakers to relate to.

---

Let me know if you need this formatted for a document or a project report.



Roll No.
22000988
22000998

flex scanner.l
bison -d parser.y
gcc lex.yy.c parser.tab.c -o mycompiler.exe
