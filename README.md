# create_atari-portfolio_roms

--------------------------------------------------------------------------------

In the TECHNICAL-INFO.md you can find the background about how the script works.

With this information you can do all the steps manually, if you want.

Use the script on your own risk !

--------------------------------------------------------------------------------

Paste your .zip game files into the same directory as the script.


The structure of the zip file has to contain normal dos files.

This is an example of a set files of folidash.zip :

castle.txt  folidash.b    folidash.d  folidash.g    mazecave.txt  reactor.txt

empty.txt   folidash.c    folidash.e  folidash.txt  pacmans.txt   title.txt

folidash.a  folidash.com  folidash.f  makecave.com  pyramid.txt   wait.txt


You will find that some zip files require editing so they will be converted properly for autoboot.


Use the terminal.

- Go to the script directory.

- Be sure the script is executable:

chmod u+x 123-pofo-roms.sh

- Run it with ( It will create .rom files from all .zip files ):

sudo ./123-pofo-roms.sh

- Copy these .rom files to the ~/RetroPie/roms/pofo directory or your specific mame rom directory

- Now you can run the games with mame

Good luck !
