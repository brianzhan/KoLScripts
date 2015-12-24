script "FarmingComplete.ash";
kmail Brian 199610;

/*
IMPORTANT: 
 - If you have EatDrink.ash, and would like to have this script automatically call it, uncomment (remove the //) from lines 9 and 12. Please check the customized setup, including that valueOfAdventure = 2000
 - Hobo monkey is not necessarily the best familiar: however, it is the most cost-effective. If you would like to use your own familiar, keep it in your familiar slot and delete lines 18 though 26 and adjust the familiar equipment as you find necessary
 - You MUST have outfits titled Meat Max and Rollover, created through the browser KoL interface (not through KoLMafia, though relayer browser will work)

//Inspiration is drawn from the KoLMafia barfmountain.ash script, though little of the code is copied from there: By placing greater emphasis on efficiency and taking a more complete setup, this script seeks to create a Barf Mountain farming script with faster execution time, higher meat yield, and less bugs
*/

//import <EatDrink.ash>;

void BeginningSetup() {
	//eatdrink(fullness_limit()-my_fullness(), inebriety_limit()-my_inebriety(), spleen_limit()-my_spleen_use(), false, 2000, 0, 0, 0, false);
	print ("Equipments");
	if (have_familiar[$hobo monkey]) {
		use_familiar($familiar[hobo monkey]);
	}
	else if (have_familiar($leprecheum])) {
		use_familiar($familiar[leprecheum]);
	}
	else {
		abort("Neither hobo monkey nor leprecheum are available: please buy one of them (hobo monkey > leprecheum) and put it into your terranium to proceed");
	}
	if (have_item($item[filthy child leash]) == false) {
		buy(1, $item[filthy child leash]);
	}
	cli_execute("equip filthy child leash");
	cli_execute("outfit Meat Max");
	prompt_user("Have you obtained the Greed Demon name, and would like to use it? (may cause bugs related to KoLMafia");
	if (prompt_user == true) {
		print ("Attempting to Summon Greed Demon");
		if( item_amount( $item[scroll of ancient forbidden unspeakable evil]) < 1) {
			buy( 1, $item[scroll of ancient forbidden unspeakable evil]);
		}
		if (item_amount($item[thin black candle]) < 3) {
			buy (3, $item[thin black candle]);
		}
		cli_execute("summon 2");
	}
	if (have_item($item[The Legendary Beat])) {
		cli_execute("use The Legendary Beat");
	}
	if (have_item($item[BittyCar SoulCar])) {
		cli_execute("use BittyCar SoulCar");
	}	
}

void MaintainBuffs()
{
	int itemsWithTen = (my_adventures() / 10) + 1;
	int itemsWithTwenty = (my_adventures() / 20) + 1;
	if(have_effect($effect[How to Scam Tourists])==0)
	{
		if( item_amount( $item[How to Avoid Scams] ) < 1)
		{
			buy( itemsWithTwenty, $item[How to Avoid Scams], 10000 );
		}
		use( itemsWithTwenty, $item[How to Avoid Scams] );
	}
	if(have_effect($effect[Heavy Petting])==0)
	{
		if( item_amount( $item[Knob Goblin pet-buffing spray] ) < 1)
		{
			buy( itemsWithTen, $item[Knob Goblin pet-buffing spray], 10000 );
		}
		use( itemsWithTen, $item[Knob Goblin pet-buffing spray] );
	}
	if(have_effect($effect[Wasabi Sinuses])==0)
	{
		if(item_amount($item[Knob Goblin nasal spray]) < 1)
		{
			buy(itemsWithTen, $item[Knob Goblin nasal spray]);
		}
		use( itemsWithTen, $item[Knob Goblin nasal spray] );
	}
	if(have_effect($effect[Empathy])==0) {
		chat_private("Buffy", "empathy");
		print("waiting for Buffy to buff empathy",'blue');
		wait(30);
	}
	if (have_effect($effect[Polka of Plenty])==0)
	{
		chat_private("Buffy", "plenty");
		print('waiting for Buffy to buff with polka of plenty','blue');
		wait(30);
	}
	if (have_skill($skill[Disco Leer])) {
		if(have_effect($effect[Disco Leer]) == 0)
		{
			print('casting Disco Leer','blue');
			int requiredMP = mp_cost($skill[Disco Leer]) * itemsWithTen;
			if (requiredMP > my_mp()) {
				restore_mp(requiredMP);
			}
			use_skill( itemsWithTen , to_skill($effect[Disco Leer]) );
		}
	}
	if (have_skill($skill[Disco Leer])) {
		if(have_effect($effect[Disco Leer]) == 0)
		{
			print('casting Disco Leer','blue');
			int requiredMP = mp_cost($skill[Disco Leer]) * itemsWithTen;
			if (requiredMP > my_mp()) {
				restore_mp(requiredMP);
			}
			use_skill( itemsWithTen , to_skill($effect[Disco Leer]) );
		}
	}	
}

void Nightcap() {
	print("Nightcap beginning");
	chat_private("Buffy", "ode");
	print("Ideally, manually ensure Buffy buffed with ode to booze");
	wait(10);
	if( item_amount( $item[bucket of wine]) < 1) {
		buy( 1, $item[bucket of wine]);
	}
	drink( 1, $item[bucket of wine]);
	cli_execute("outfit Rollover");
	if (item_amount($item[solid shifting time weirdness]) > 0) {
		cli_execute("equip solid shifting time weirdness");
	}
}

boolean mainLoop()
{
	while((my_adventures() > 1) && (my_inebriety() <= inebriety_limit()) ) {
		if ( (have_effect($effect[How to Scam Tourists])==0) || (have_effect($effect[Heavy Petting])==0) || (have_effect($effect[Wasabi Sinuses])==0) || (have_effect($effect[Empathy])==0) || (have_effect($effect[Polka of Plenty]) == 0)) 
		{
			maintainBuffs();
		}
		if (have_skill($skill[Smooth Movements])) {
			if (have_effect($effect[Disco Leer])) == 0) {
				maintainBuffs();
			}
		}
		if (have_skill($skill[The Ballad of Richie Thingfinder])) {
			if (have_effect($effect[The Ballad of Richie Thingfinder])) == 0) {
				maintainBuffs();
			}
		}
		if (have_skill($skill[Chorale of Championship])) {
			if (have_effect($effect[Chorale of Championship])) == 0) {
				maintainBuffs();
			}
		}	
		if (have_skill($skill[Leash of Linguini])) {
			if (have_effect($effect[Chorale of Championship])) == 0) {
				maintainBuffs();
			}
		}	
		boolean retval = adv1($location[Barf Mountain], 1,'');
	}
	return true;	
}

void main()
{
	print("Farming Barf Mountain begins");
	BeginningSetup();
	print("Setting up regular buffs");
	MaintainBuffs();
	print("Ensuring pre-/post-adventure settings empty",'blue');
	set_property("afterAdventureScript", "");
	set_property("betweenAdventureScript", "");
	set_property("betweenBattleScript", "");
	cli_execute("ccs BarfMountain");
	set_property("choiceAdventure1073", "1");
	if( (my_adventures() > 1) && (my_inebriety() <= inebriety_limit())) {
		print("About to enter the main loop for burning turns at Barf Mountain","blue");
		mainLoop();
	} 
	else {
		print("Overdrank or no adventures left: terminating","red");
	}
	Nightcap();
}