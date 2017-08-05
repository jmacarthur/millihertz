# Mechanical computing cookbook

This is a document describing some approaches to mechanical computing.

## Zuse-style sliding plate 

This is a 2-input OR gate. The inputs are made by sliding plates 'A' and 'B' up or down, '1' being up and '0' being down.

```bob

                   ^
                   |
       ^           v
       |      +----------+
       v      | +-----.  |
  +----------+| |      ) | +------------+
  | +-----.  || |  +--'  | | .--------. |
  | |O     ) || |O |     | |(     O    )|
  | |  +--'  || +--+  B  | | '--------'C|
  | |  |     |+----------+ +------------+
  | +--+  A  |                          ^    ^
  +----------+                          0    1 

  .---------------------------------.
 (   O           O                O  ) Drive bar
  '---------------------------------'
 <---
 ------->
     <---   
```

The 'drive bar' at the bottom has three pegs in it which fit into the points marked 'O' on the moving plates. Cycling the gate requires pushing the rod at the bottom left, then fully right, then back to the centre again. Moving left resets the output to zero. On moving fully right, the output plate C will be pushed if either plate A or B are in the up position. When a plate is in the down position, the peg moves inside the channel without moving the plate. 'A' will push B if B is not being driven, so if either of them move, C will move to '1'. The input plates cannot move vertically while the drive bar is fully right, so the bar must be returned to the centre position before the inputs are updated.

Inversion of the inputs can be easily achieved by turning the input plates upside down; turning both would give you a NAND gate.

## Decoders

A decoder, represented by the circuit symbol below, takes n binary inputs and turns on exactly 1 of 2^n outputs. A 3-to-8 decoder take 3 inputs and lights exactly one of 8 outputs. It's similar to a demultiplexer but with the data input always set to '1'.

```bob
    +  
    |\ 
    | \
    | |--- 0
    | |--- 1
A --|D|--- 2
B --|E|--- 3
C --|C|--- 4
    | |--- 5
    | |--- 6
    | |--- 7
    | /
    |/
    +  
```

A decoder can be made using a set of rods, coded such that a gap opens in exactly one place.

```bob
       0       1       2       3       4       5       6       7
       |       |       |       |       |       |       |       |         
       _       _       _       _____       _       _       _
 A  __| |_____| |_____| |_____|     |_____| |_____| |_____| |_______

       _       _____       _           _       _____       _
 B  __| |_____|     |_____| |_________| |_____|     |_____| |_______

       _____           _____           _____           _____
 C  __|     |_________|     |_________|     |_________|     |_______
    
```

The three input rods A, B and C are shown vertically in the above diagram but would be laid out side-by-side in the decoder, with eight rods laid over the top. The arrangement of bumps on the input rods allows only one rod to fall into a gap at a time; in this case, it's output 7.

Input 'A' blocks rods 0, 1, 2, and 3 in the diagram above, but if it is moved to the right by half the separation distance of the output rods, then it will instead block 4, 5, 6 and 7. Now, instead of rod 7 falling, rod 3 will fall.

Similarly, Input 'B' allows 2,3, 6 and 7 to fall, and if pushed right, will allow 0, 1, 4 and 5 to fall. Input 'C' allows odd-numbered outputs when pushed left, and even-numbered outputs when pushed right.

This can be extended to cope with any number of inputs, but the length of each input rod will be proportional to the 2^n, so 4 or 5 inputs is likely to be the practical limit. The output rods are only driven by gravity, so an amplifier of some sort will probably be necessary.

With the square edged bumps shown above, all output rods must be lifted by another means before the input can be changed. If the bumps are given sloping edges, as below, then it may be possible to do away with that lifting mechanism.

```bob
       _       _       _       _____       _       _       _      
 A  __/ \_____/ \_____/ \_____/     \_____/ \_____/ \_____/ \_______

       _       _____       _           _       _____       _
 B  __/ \_____/     \_____/ \_________/ \_____/     \_____/ \_______

       _____           _____           _____           _____
 C  __/     \_________/     \_________/     \_________/     \_______
```

However, this will require more force from the inputs and may make the input rods longer.

## Array logic

Once a decoder has been constructed, it can be used to make array logic. The diagram below shows the decoder on the left, shown end-on so we are looking in the direction the input rods move in.

```bob
                                     _  _  _
                                    |X||Y||Z|
                                    |_||_||_|
                                  ___^_____^_
                                 |   x  y  z |
    ____________________         |  _________|
   |____________________|        | |       _
   | Decoder output 0   |  ______|o|      |L|
   |____________________| <________|      |2|  
     |A| |B| |C| |D| |L|                  |_|
     |_| |_| |_| |_| |_|

```

'L' is the lifting gear for the input, which lifts all the decoder outputs at once. There are four inputs on this machine, so there will be 16 decoder outputs; decoder 0 output is visible with the other 15 behind it.

The S-shaped part on the right is pivoted at 'o'. The bar L2 will lift all of these up at the start of cycle. All of these will then rotate clockwise - with the large part on the right dropping - except for one, which is blocked by the single decoder rod which has fallen into the gap. Being the only S-shaped part which remains in place, it is the only one which can support the output rods X, Y and Z.

This particular S-shaped piece has bumps on top in the 'x' and 'z' positions, so output rods X and Z will be held up, and Y will drop. X, Y and Z are long bars - roughly the same length as the input rods - and run down the whole length of the machine.

There are 16 S-shaped pieces stacked beside each other, and each can have a different pattern of bumps on top. This pattern of bumps determines the logical function of the machine. These might be made specifically for one function, or you might keep a stock of S-shaped pieces with different bumps to assemble any logic function with.

The outputs X, Y and Z are unpowered, as before, so we may need an amplifier.

### Amplifier for logic arrays

The output rods running the length of the array can be constructed like this:


```svgbob

   <---
   ------->
       <---
   _________________________________________________________
  |____   _______________   ____________   _______________  |
       | |       ___     | |            | |       ___     | |
       |_| _____|   |    |_|            |_| _____|   |    |_|
   _______|         |______________________|         |_________________
  |                                          OUTPUT Y               | o|
  |_________________________________________________________________|__|
     _   _   _   _   _   _   _  |s|  _   _   _   _   _   _   _   _
    |s| |s| |s| |s| |s| |s| |s| |_| |s| |s| |s| |s| |s| |s| |s| |s| 
    |_| |_| |_| |_| |_| |_| |_|     |_| |_| |_| |_| |_| |_| |_| |_|

```

In this diagram , we are looking at a single output rod with 16 S-shaped pieces below it, one of which is up - but this one has no 'bump' for this output rod, so the rod is down.

The rake-shaped part on top moves left, returning the output rod to the left (whether it is up or down. The rake-shaped part then moves to the right, and it will catch the output rod and push it right only if the rod is held up; in the above diagram, the output rod is down so it remains in the '0' position.

There are two L-shaped drive tabs on top of the output rod. This is because the output rod may not be lifted perfectly vertically; if one of hte S-shaped pieces at each end is up, only one end of the output rod may be lifted.


## Interconnects
