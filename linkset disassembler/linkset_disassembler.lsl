
vector distance = <0,0,0.25>; // base parameter
vector s_distance = <0,0,2.5>; // single prim base parameter
vector vertical = <0,0,0.25>; // parameter for vertical preset
vector horizontal = <-0.25,0,0.1>; // parameter for horizontal preset
integer rightleft = 0; // parameter for right left

vector color = <0.000, 1.000, 0.000>;
vector color2 = <1.000, 0.000, 0.502>; // for root prim

/////////////////////////////////////////////////////////

integer debug = 0;

integer inspect;
integer inspect_link;
list positions;
vector position; // foar link
integer links;
integer link;
integer dlink;


integer GetPrimCount() {
    if(llGetAttached())
        return GetPrimCount();;
    return llGetObjectPrimCount(llGetKey());
}

back_up(){

    llOwnerSay("---------------------------------------------------------------------");
    llOwnerSay("backup to restore state: " + llGetTimestamp());
    llOwnerSay("---------------------------------------------------------------------");
    llOwnerSay("\t");
    
    
    integer m = GetPrimCount();
    integer x = 1;

    llOwnerSay("default{state_entry(){");

    do
    {        
        llOwnerSay("llSetLinkPrimitiveParamsFast(" + (string)x + ",[" + (string)PRIM_POS_LOCAL + "," + llList2String(llGetLinkPrimitiveParams(x, [PRIM_POS_LOCAL]),0) + "]);");

    }
    while (++x <= m);

    
    llOwnerSay("}}");



}



info(integer b){

    links = GetPrimCount();
    list info;
    integer x = 1;

    do
    {

        if(b)   {
            
            info = llGetLinkPrimitiveParams(x, [PRIM_NAME, PRIM_DESC]);
            if(x > 1)llSetLinkPrimitiveParamsFast(x, [PRIM_TEXT, (string)x + "\n" + llList2String(info, 0) + "\n" + llList2String(info, 1), color, 1] );
            else llSetLinkPrimitiveParamsFast(x, [PRIM_TEXT, (string)x + "\n" + llList2String(info, 0) + "\n" + llList2String(info, 1), color2, 1] );
        }

        else llSetLinkPrimitiveParamsFast(x, [PRIM_TEXT, "", color2, 1] );
        
    }
    while (++x <= links);

}


assemble(){

    llOwnerSay("assembling ...");

        integer x = 2;
        integer z;
        do
        {
            llSetLinkPrimitiveParamsFast(x, [PRIM_POS_LOCAL, llList2Vector(positions, z)] );
            ++z;
        }
        while (++x <= links);

}

disassemble(){

    analyse(); 

    llOwnerSay("disassembling ...");

    integer x = 2;
    integer z;
    integer v;
    float u;
    

    do
    {
        if(rightleft){    
            if(v) u = 1;
            else u = -1;
            v = !v;
        }

        llSetLinkPrimitiveParamsFast(x, [PRIM_POS_LOCAL, <0,u,0> + <distance.x*(z+1),distance.y*(z+1),distance.z*(z+1)>] );
        
        ++z;

    }
    while (++x <= links);



}


analyse(){

        positions = [];
        
        llOwnerSay("Analysing object ...");
        
        links = GetPrimCount();

        llOwnerSay("Number of prims: " + (string)links);
        
        integer x = 2;
        list info;
        do
        {
            info = llGetLinkPrimitiveParams(x, [PRIM_POS_LOCAL]);
            positions += llList2Vector(info, 0);
        }
        while (++x <= links);

        if(debug)llOwnerSay(llList2CSV(positions));
        llOwnerSay("link positions saved: " + (string)llGetListLength(positions));

}


assemble_link(){

    llOwnerSay("assembling link...");
    llSetLinkPrimitiveParamsFast(link, [PRIM_POS_LOCAL, position] );
     

}

disassemble_link(){

    analyse_link(); 

    llOwnerSay("disassembling link...");

    llSetLinkPrimitiveParamsFast(link, [PRIM_POS_LOCAL, <0,0,0> + s_distance] );




}


analyse_link(){
   
        llOwnerSay("Analysing link ...");
        position =  llList2Vector(llGetLinkPrimitiveParams(link, [PRIM_POS_LOCAL]), 0);
        llOwnerSay("link positions saved ...");

}

default
{
    state_entry()
    {
       back_up();

       llOwnerSay("\t");
       llOwnerSay("touch & hold root prim >= 0.5 sec. to disassemble / assemble the whole linkset");
       llOwnerSay("touch & hold link >= 0.5 sec. to disassemble / assemble link");
       llOwnerSay("voice commands on chan 0: text, notext, horizontal, vertical, backup");
       
       llListen(0, "", llGetOwner(), "");

    }

    touch_start(integer total_number)
    {
        llResetTime();
        dlink = llDetectedLinkNumber(0);
        

    }


    touch_end( integer num_detected )
    {
        
        if(llGetTime() <= 0.5 | llDetectedKey(0) != llGetOwner()) return;
        
        if(dlink == 1){


            if(inspect_link == 1){

                assemble_link();
                inspect_link = 0;
                
            }

            if(inspect){
                
                assemble();
                inspect = 0;
            }
            else {
                
                
                disassemble();
                inspect = 1;

            }

        }
      

        else {

            if(inspect_link) assemble_link();

            else {
                
                link = dlink;
                disassemble_link();

            }

            inspect_link = !inspect_link;

        }

    }

    listen( integer channel, string name, key id, string msg )
    {
        
        if(msg == "text")info(1);

        else if(msg == "notext")info(0);
        
        
        else if(msg == "horizontal"){

            distance = horizontal;
            rightleft = 1;
            if(inspect) {

                assemble();
                disassemble();

            }
        }

        else if(msg == "vertical"){

            distance = vertical;
            rightleft = 0;
            if(inspect) {

                assemble();
                disassemble();

            }
        }

        else if(msg == "backup") back_up();

    }

}
