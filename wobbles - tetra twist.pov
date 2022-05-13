// PoVRay 3.7 Scene File "wobbles - tetra twist.pov"
// author:  @galacticfurball (Discatte)
// date:    05/11/2022
//-------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {perspective angle 75               // front view
                            location  <1.0 , 1.5 ,-1.0>*0.75
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.25 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ----------------------------------------------------------------------
light_source{< 3000,3000,-3000> color White}
// sky ----------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <0.6,0.7,1.0>]
                                   [0.35 rgb <0.1,0.0,0.8>]
                                   [0.65 rgb <0.1,0.0,0.8>]
                                   [1.00 rgb <0.6,0.7,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// ground -------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ 
              //pigment{ checker color rgb<1,1,1>*1.2 color rgb<0.25,0.15,0.1>*0}
              pigment { color rgb<0,1,1>*0.75 }
              //normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
              } // end of texture
     } // end of plane
//---------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//---------------------------------------------------------------------------


// tetrahedron macro height is 4
//
// .2041241452; base of 1
// .25; height of 1
#declare tetra_height = 4;
#declare tetra_base_to_height = sqrt(2/3);
#declare tetra_radius = sqrt(1/3);
#declare tetra_height_to_radi = tetra_base_to_height/tetra_radius;
#declare tetra_height_to_base = 1/tetra_base_to_height;
#declare tetra_scale = 1/(tetra_height);

#declare tetra_object = object{ Tetrahedron  
        material{   //-----------------------------------------------------------
           texture{ pigment{ rgbf <0.88, 0.98,  0.00, 0.5> }
                  }
        }
        scale <1,1,1>*tetra_scale  rotate<0,0,0> translate<0,tetra_scale,0>
      }

#declare box_offset = -(tetra_height_to_radi/2);
#declare box_scale  = tetra_height_to_radi;

#declare division_count = 10;
#declare division_size  = 1/division_count;

#declare division_angle = 66/division_count;
#declare angle_offset = (clock) * 360;

#declare box_object = box { <0,0,0>,< box_scale, division_size, box_scale>   

      texture { pigment{ color rgbf<1.00, 0.00, 1.00,0.5>*1.1}  
                finish { phong 1 reflection{ 0.00 metallic 0.00} } 
              }

      scale <1,1,1> rotate<0,0,0> translate<box_offset,0,box_offset> 
    }

#declare II=division_count;
#while (II>=0) 

#local sin_offset    = ((pi*2)/36)*II;
#local sin_wiggle    = sin(clock*pi*2+sin_offset);
#local tslice_angle  = sin_wiggle*45;
#local bslice_offset = division_size*II;

intersection {
    object { tetra_object  rotate<0,tslice_angle, 0> }
    object { box_object translate<0,bslice_offset,0> }
}
 #declare II=II-1;
#end