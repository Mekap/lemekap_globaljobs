# lemekap_globaljobs

ensure lemekap_globaljobs in your server.cfg <br />
<br />
Global generic scenario playing mods in redm for VORP.CORE 2.0 <br />
This script features Blip, ped  placement, a tool & ingredient(s) check, a basic scenario animation player and random rewards.<br />
Every job is customizable to suit your needs. This script can make any number of jobs as you need. (I've had this run with more than 30 different jobs no problems)<br />
<br />
Take time to read and understand how the config.lua work. Thats the only file you should edit for your server.<br />
The test i've put as a demo is visible in Valentine's graveyard, make sure to remove it once you played around with it.<br />
As stated in the configuration file, if there is an option you want turned off for a particual job, make sure that the IsXRequired is turn to false. You do not have to write empty configurations for turned off features.<br />
<br />
For example, if you do not need a blip for a specific job, just put ["IsBlipRequired"] = false,<br />
You do not have tu setup an empty "BlipHash" or "BlipText" for that job. The main structure of a job (position, animation, prompts) is awlays required.<br />
For testing purposes, i recommend using a "restart lemekap_globaljobs" in your server's console so you can setup properly what you need.<br />
<br />
Do not change the name of the folder. If you share this project, just put a link to my github's project (https://github.com/Mekap/lemekap_globaljobs/).
If you got this project without passing by my github, feel free to report it to me.

For the French community, you can join my discord server here for my other projects (redm or otherwise) https://discord.gg/AK9bxE7Tv7. 
Always happy to see other fellow french devs ! See you around.
