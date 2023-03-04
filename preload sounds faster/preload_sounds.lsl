
// this is faster than  llPreloadSound() because script won't put to sleep for 1 sec on each call
// this way you populate sound cache on your PC the same way - just way faster
// imagine you would like to preload like 100 sounds this would sleep your script for 100 seconds with llPreloadSound() !!! plus it's buggy !!!

preload_sounds(list i){

    integer ll = llGetListLength(i);
    integer x;
    do
    {
        llPlaySound(llList2Key(i, x), 0); // playying sound at sound level 0
        llSleep(0.1); // sleep theoretically not necessary 
    }
    while (++x < ll);

}



default
{
    state_entry()
    {
        // preloading list of sound UUIDs

        preload_sounds(["1d4dd97b-4af6-6319-12fa-e5f342708877", "24ac4e75-e0cc-aa3b-4df7-0df968298069", "5bea646a-f6d5-22d5-1c42-42e1dec83aac"]); 


        // preloading by reading sounds from your prim inventory

        integer count_sounds = llGetInventoryNumber(INVENTORY_SOUND);
        list sounds;
        integer x;
        do // creating list with sound names from inventory
        {
            sounds += llGetInventoryName(INVENTORY_SOUND, x);
        }
        while (++x < count_sounds);

        preload_sounds (sounds);


    }


}
