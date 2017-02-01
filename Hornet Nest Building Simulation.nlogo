globals [ ruleset ]
turtles-own [ close-to ]
patches-own [ tmp-val ] ; used for the upkeep of numbered-close-to

; Sets board up
to setup
  clear-all
  ; seed: 1
  if seed-num = 1 [
    set ruleset
    (list
      (list (list 1 0 0 0 0 0 0 0) 2)
      (list (list 1 2 0 0 0 0 0 0) 2)
      (list (list 1 0 0 0 0 0 0 2) 2)
      (list (list 2 0 0 0 0 0 2 1) 2)
      (list (list 0 0 0 0 2 1 2 0) 2)
      (list (list 2 0 0 0 0 0 1 2) 2)
      (list (list 0 0 0 0 2 2 1 0) 2)
      (list (list 2 0 0 0 0 0 2 1) 2)
      (list (list 1 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 2 2 2) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 2 2) 2)
      (list (list 1 2 2 0 0 0 2 2) 2)
      (list (list 2 2 2 2 0 2 2 2) 2)
      (list (list 2 0 0 0 0 2 2 1) 2)
      (list (list 2 2 0 0 0 0 2 1) 2)
      (list (list 2 2 0 0 0 2 2 1) 2))
  ]
  ; seed: 2
  if seed-num = 2 [
    set ruleset
    (list
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 0) 2)
      (list (list 2 0 0 0 0 0 0 2) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 2 2) 2))
  ]

  ; seed: 3
  if seed-num = 3 [
    set ruleset
    (list
      (list (list 0 0 0 0 0 0 1 0) 2)
      (list (list 2 0 0 0 0 0 0 1) 2)
      (list (list 0 0 0 0 2 1 0 0) 2)
      (list (list 0 0 0 0 0 2 2 2) 2)
      (list (list 0 0 0 0 2 2 2 0) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 0 0 0 2 2 2 0 0) 2)
      (list (list 2 0 0 0 0 0 0 1) 2)
      (list (list 2 0 0 0 0 2 2 2) 2)
      (list (list 2 2 2 2 0 0 0 0) 2)
      (list (list 2 2 2 0 0 0 2 2) 2)
      (list (list 2 0 0 0 2 2 2 2) 2)
      (list (list 0 0 2 2 2 2 2 0) 2)
      (list (list 2 2 2 0 0 0 0 0) 2)
      (list (list 0 0 2 2 2 0 0 0) 2)
      (list (list 0 0 0 2 2 2 2 2) 2))
  ]

  if seed-num = 4 [
    set ruleset
    (list
      (list (list 0 0 0 2 0 0 0 2) 2)
      (list (list 2 0 0 0 2 0 0 0) 2)
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 0 0 0 2 0 0 0 0) 2)
      (list (list 1 0 0 0 0 0 0 0) 1)
      (list (list 0 1 0 0 0 0 0 0) 1)
      (list (list 0 0 1 0 0 0 0 0) 1)
      (list (list 0 0 0 1 0 0 0 0) 1))
  ]

  if seed-num = 5 [
    set ruleset
    (list
      (list (list 0 1 0 0 0 0 0 0) 1)
      (list (list 0 2 0 0 0 0 0 0) 2)
      (list (list 0 2 0 0 0 1 0 0) 2)
      (list (list 0 0 0 0 0 0 0 1) 1)
      (list (list 0 0 0 0 0 0 0 2) 2)
      (list (list 0 1 0 1 0 0 0 0) 1)
      (list (list 0 2 0 2 0 0 0 0) 2)
      (list (list 0 1 0 1 0 1 0 1) 0)
      (list (list 0 2 0 2 0 2 0 2) 0))
  ]
  setup-patches
  setup-hornets ; spawning all the hornets at random places
  reset-ticks
end

; Moves hornets and checks if they have anything to build
to go
  move-hornets
  check-build
  tick
end

; Sets patches to be either blue or red.
; Red materials are material 1
; Blue materials are material 2
to setup-patches
  ; Eventually, set it to a random material color for various material types
  ask patches
  [
    set pcolor black
    if random 100 < material-ratio [
      set pcolor one-of [blue red]]
  ]
  ; Makes a new material at a random interval specified by the user. (can be material a or b)

end

; Spawns hornets as yellow bugs
to setup-hornets
  create-turtles number-of-hornets
  ask turtles [
    set shape "bug"
    setxy random-xcor random-ycor
    set color yellow
  ]
end


; Simple random move function
to move-hornets
  ask turtles [
    right random 360
    fd 1
  ]
end

; Checks to see what the patch the hornets are standing on will become
; Uses the rulesets defined above as the rules, along with the convert-ruleset-to-symmetric-ruleset reporter to make sure directionality doesnt matter.
to check-build
  ask turtles [
    ; Sets the close-to relationship variable by firstly, getting a sorted square of patches around the hornet
    ; Then the convert-to-numbers takes each patch and turns it into a number
    ; format-converter then takes the order and changes it to be in line with the TA's specifications

    ; 0 1 2        7 0 1
    ; 3 X 4  --->  6 X 2
    ; 5 6 7        5 4 5

    set close-to (format-converter (map convert-to-numbers (sort neighbors)))
    foreach (convert-ruleset-to-symmetric ruleset) [ [ rule ] ->
      ; Takes in the ruleset that is symmetric, and compares all the hornet's positions to the rules.
      ; If a rule is found that is satisfiable, then change the pcolor under the hornets to "build a nest"
      if close-to = (first rule ) [
        if (last rule) = 0 [
          set pcolor black
        ]
        if (last rule) = 1 [
          set pcolor red
        ]
        if (last rule) = 2 [
          set pcolor blue
        ]
      ]
    ]
  ]
end

; This reporter simply takes a patch and converts it into a numeric id associated with the color
to-report convert-to-numbers [tmp-patch]
  let tmp 0
  ask tmp-patch [
    if pcolor = red [
      set tmp 1
    ]
    if pcolor = blue [
      set tmp 2
    ]
  ]
  report tmp
end

; Not my own code, written by TA for CPSC 565
; Reports a symetric ruleset from an asymetric set
to-report convert-ruleset-to-symmetric [asymruleset]
  let symruleset (list)
  foreach asymruleset [ [rule] ->
    let asymrule first rule
    let result last rule
    ; Add asymmetric rule
    set symruleset lput rule symruleset
    ; Add the 3 other symmetric rules
    foreach [2 4 6] [ [sym] ->
      set symruleset lput (list (sentence (sublist asymrule sym 8) (sublist asymrule 0 sym)) result) symruleset
    ]
  ]
  report symruleset
end

to-report format-converter [myList]
  let myList2 [ ]
  set myList2 lput (item 1 myList) myList2
  set myList2 lput (item 2 myList) myList2
  set myList2 lput (item 4 myList) myList2
  set myList2 lput (item 7 myList) myList2
  set myList2 lput (item 6 myList) myList2
  set myList2 lput (item 5 myList) myList2
  set myList2 lput (item 3 myList) myList2
  set myList2 lput (item 0 myList) myList2
  report myList2
end
@#$#@#$#@
GRAPHICS-WINDOW
330
59
1001
471
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-25
25
-15
15
0
0
1
ticks
30.0

BUTTON
75
65
139
98
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
156
65
219
98
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
61
113
233
146
number-of-hornets
number-of-hornets
0
50
10.0
1
1
NIL
HORIZONTAL

SLIDER
37
157
252
190
material-ratio
material-ratio
0
100
4.0
1
1
%
HORIZONTAL

CHOOSER
75
201
213
246
seed-num
seed-num
1 2 3 4 5
3

MONITOR
13
261
82
306
Material A
count patches with [pcolor = red]
17
1
11

MONITOR
96
261
163
306
Material B
count patches with [pcolor = blue]
17
1
11

PLOT
48
323
248
473
Material Relations
Time
Materials
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"Unworked Materials" 1.0 0 -16777216 true "" "plot count patches with [pcolor = black]"
"Material A" 1.0 0 -2674135 true "" "plot count patches with [pcolor = red]"
"Material B" 1.0 0 -13345367 true "" "plot count patches with [pcolor = blue]"

MONITOR
181
262
297
307
Unworked Material
count patches with [pcolor = black]
17
1
11

@#$#@#$#@
## WHAT IS IT?

This model, named the hornet model, is meant to model hornet nest building. These hornets build nests by looking at patterns in the enviornment, then placing materials.

## HOW IT WORKS

Initially, this model spawns a set number of hornets. These hornets move randomly across the monitor. Each time they move, they look at the patches, which have been randomly assigned a color from black, blue or red, and check the ruleset given by the controller. If the hornet can pattern match the neighboring patch colors to any specified rules in the active ruleset, then the hornet will change the color of the patch that they are currently on, simulating placing a material, then continue to move.

## HOW TO USE IT

The model is used quite simply. Firstly, set the desired amount of density, as well as a desired amount of hornets to spawn. Once both have been specified, select a ruleset, already coded into the simulation. If the user wishes, they can specify or edit an existing ruleset in the beginning of the code section. The format must be in the form of (list (list 1 2 3 4 5 6 7 8 ) 9), where 1-8 are the neighboring patches in this format:

		8 1 2
		7 X 3
		6 5 4

And 9 is the patch that will be changed under the hornet.

## THINGS TO NOTICE

Pay attention to the change in color density, as well as the interesting patterns that might take shape.

You can also note the various default seeds that were provided. 
1: Note material B ( Blue ) surrounds the material A ( Red ), and builds large masses around them
2: Notice a maze like structure built, without touching the material A, out of material B.
3: Most like a combination of 1 and 2, creating mazes but touching the material A's. 
4: A competing set of lines that dont intersect. Material A and B both try to block each other's paths seemingly. 
5: Similar to 4, but much more checkered. Very few solid lines.

Feel free to create your own seeds and explore your own patterns!


## THINGS TO TRY

Try experimenting with the density slider, as well as the number of hornets slider, and see how quickly the colors change. Aside from this, try creating new rulesets in the code section.

## EXTENDING THE MODEL

Add a potential rule randomizer, or rule creater in UI format. Also add more colors to represent new materials. Potentially change the way hornets see around them, to expand the complexity of the results.

## NETLOGO FEATURES

Uses the sort and neighbor functions to get the neighboring cells. Aside from this, not many non-trivial built-ins were used.

## RELATED MODELS

Used movement features from sheep / wolf predation
Used patch relations from brians brain model

## CREDITS AND REFERENCES

Created by Micheal Friesen, with resource use from CPSC 565 TA for the asymetric conversion of rulesets to symettrical versions.
Large help from the Netlogo Documentation.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
