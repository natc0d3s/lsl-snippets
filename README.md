## lsl-snippets
<p><br></p>


### linkset disassembler  

helper script to disassemble / assemble linksets for easier work on single links with backup function  

[linkset_disassembler.lsl](https://github.com/natc0d3s/lsl-snippets/blob/main/linkset%20disassembler/linkset_disassembler.lsl)

<p><br></p>


### primitive parameter to llSetLinkPrimitiveParamsFast()  


helper functions to read primitive parameters from a linkset and print them as copy-able output for easy re-import or backup


example  
```
-----------------------------------------
        output of parameters
-----------------------------------------
llSetLinkPrimitiveParamsFast(0,[
        27,"Object Name",
        28,"Description",
        21,0, 0, 0.000000, 0.000000, 0.000000, 0.000000, <0.000000, 0.000000, 0.000000>
        ]);
```
[get_primitive_parameters_as_copy_able_output.lsl](https://github.com/natc0d3s/lsl-snippets/blob/main/primitive%20parameter%20to%20llSetLinkPrimitiveParamsFast()/get_primitive_parameters_as_copy_able_output.lsl)


