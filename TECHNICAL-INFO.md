backup of :

https://retropie.org.uk/forum/topic/29682/development-of-module-script-generator-for-lr-mess-and-mame-standalone/531

We can add a new "handheld".

I am trying out the Atari Portfolio.

(system = pofo)

This brings back some memories as I still have 2 originals in my storage boxes.


Never knew that mame could emulate this.

So I found the correct bios files and it worked although there is no sound yet.

It seems, in a mame forum, that this computer has been improved upon in mame0233.


Now the trouble was how to add games, this was a difficult one !

Normally you had to connect a dos or an atari-st computer to the portfolio and connect them with a parallel port.

Well, trouble, haha, how on earth can we get games to this computer.

Looked for virtual parallel port things and looked into mame on how to use ports with the outside world.

No real solution here.


I found that you can add a ram card as a slot-device.

Now I could format this ram device and save a file to it.

But where is it saved ?

With mame it is saved here :

/home/pi/RetroPie/roms/mame/nvram/pofo/ccma_ram/ccma_ram

How to load it as a -memc ?

Well, I was thinking, perhaps the ram card file structure is the same as the rom file structure then I can make a .rom file of it.

That worked, and it's off-course read_only as it is loaded as a rom now.


Now I still had to find a way to add games to the .rom file.

After a long search and peeking into the ram/rom file with hexedit if found that it could be some sort of a disk or hd image.

Later I found that it seemed to be a FAT12 image, using this linux tool it will display that it's a FAT12 structure (this is how you install):


sudo apt install disktype

I just didn't believe it at first, but you can just mount the image in linux.


mount the image in /mnt/ if you renamed your rom/ram file to fat12.img 

sudo mount -o loop fat12.img /mnt/

Open the filemanager as "root" to add files to /mnt/

(we can only do this, if we are in a desktop enviroment)

sudo pcmanfm

(If not using a desktop enviroment we can use the command cp or extract zip files to the mount )


Add an autoexec.bat to /mnt/, so the rom will boot automatically from the drive "A:" , containing :

---

@echo off

<filename_to_run>

---

Unmount the image

sudo umount /mnt/

Then rename fat12.img to folidash.rom for use with mame

