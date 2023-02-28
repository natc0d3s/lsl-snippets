
/* functions to get primitive parameters as copy-able output >> llSetLinkPrimitiveParamsFast */
/* foar more informations check https://wiki.secondlife.com/wiki/LlGetPrimitiveParams */


integer GetPrimCount() {
    if(llGetAttached())
        return llGetNumberOfPrims();
    return llGetObjectPrimCount(llGetKey());
}


get_param_w_faces(list l){

    integer pl = llGetListLength(l);
    integer pc = GetPrimCount();
    integer y = 1;
    if(pc == 1) pc = 0 & y = 0;
    
    llOwnerSay("-----------------------------------------");
    llOwnerSay("    output of parameters with faces");
    llOwnerSay("-----------------------------------------");
    llOwnerSay("\t");

    do
    {
        integer faces = llGetLinkNumberOfSides(pc);

        integer z;

        llOwnerSay("llSetLinkPrimitiveParamsFast(" + (string)y + ",[");

        do
        {
            integer x;

            do
            {

                list pi = llGetLinkPrimitiveParams(pc,[llList2Integer(l,z),x]);
                
                integer pr;
                if(llList2Key(pi, 0)) pr = 1;
                if(llList2Key(pi, 0) == NULL_KEY || pr == 1){ // adding double quotes

                    string tx = llList2String(pi, 0); 
                    pi = llListReplaceList(pi, ["\"" + tx + "\""], 0, 0);

                }

                if(x == faces -1 & z == pl -1) llOwnerSay("\t\t" + llList2String(l,z) + "," + (string)x  + "," + 
                   llList2CSV(pi));

                else llOwnerSay("\t\t" + llList2String(l,z) + "," + (string)x  + "," + 
                   llList2CSV(pi) + ",");

            }
            while (++x < faces);       

        }
        while(++z < pl);

        llOwnerSay("\t\t]);");

     }
    while (++y <= pc);
   
}


get_param(list l){

    integer pl = llGetListLength(l);
    integer pc = GetPrimCount();
    integer y = 1;
    if(pc == 1) pc = 0 & y = 0;
    
    llOwnerSay("-----------------------------------------");
    llOwnerSay("        output of parameters");
    llOwnerSay("-----------------------------------------");
    llOwnerSay("\t");

    do
    {
         llOwnerSay("llSetLinkPrimitiveParamsFast(" + (string)y + ",[");
         integer z;

        do
        {
                
                
                integer pr = llList2Integer(l,z); 

                list pi = llGetLinkPrimitiveParams(pc,[pr]);
                
                list e = [PRIM_NAME, PRIM_DESC]; // PRIM_PROJECTOR // write only !!! >> can't be queried !!!

                if(llListFindList(e, [pr]) != -1){ // adding double quotes

                    string tx = llList2String(pi, 0); 
                    pi = llListReplaceList(pi, ["\"" + tx + "\""], 0, 0);

                } 

                if(z == pl -1) llOwnerSay("\t\t" +  llList2String(l, z)  + "," + llList2CSV(pi));

                else llOwnerSay("\t\t" +  llList2String(l, z)  + "," + llList2CSV(pi) + ",");


        }
        while(++z < pl);

        llOwnerSay("\t\t]);");

     }
    while (++y <= pc);
   
}



default
{
    state_entry()
    {
        get_param([
            PRIM_NAME,
            PRIM_DESC,
            PRIM_TYPE,
            PRIM_FLEXIBLE 
        // PRIM_PROJECTOR // write only !!! >> can't be queried !!!
            ]);


       get_param_w_faces([
            PRIM_TEXTURE,
            PRIM_COLOR,
            PRIM_NORMAL,
            PRIM_SPECULAR
        //  PRIM_ALPHA_MODE,
        //  PRIM_BUMP_SHINY,
        //  PRIM_GLOW,
        //  PRIM_FULLBRIGHT,
        //  PRIM_TEXGEN,
        //  PRIM_BUMP_SHINY
            ]);

    }

/*
    changed( integer change )
    {
        if(change & CHANGED_LINK) llResetScript();
    }
*/ 
}
