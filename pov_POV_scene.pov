//wrap the file with the version
#local Temp_version = version;
#version 3.7;
//==================================================
//POV-Ray Main scene file
//==================================================
//This file has been created by PoseRay v3.13.29.645
//3D model to POV-Ray/Moray Converter.
//Author: FlyerX
//Email: flyerx_2000@yahoo.com
//Web: https://sites.google.com/site/poseray/
//==================================================
//Files needed to run the POV-Ray scene:
//pov_POV_main.ini (initialization file - open this to render)
//pov_POV_scene.pov (scene setup of cameras, lights and geometry)
//pov_POV_geom.inc (geometry)
//pov_POV_mat.inc (materials)
// 
//==================================================
//Model Statistics:
//Number of triangular faces..... 238180
//Number of vertices............. 119752
//Number of normals.............. 116729
//Number of UV coordinates....... 123646
//Number of lines................ 0
//Number of materials............ 4
//Number of groups/meshes........ 1
//Number of subdivision faces.... 0
//UV boundaries........ from u,v=(0,0)
//                        to u,v=(1,1)
//Bounding Box....... from x,y,z=(-19.28689,-3.165614,-9.28344)
//                      to x,y,z=(7.607992,0.762298,24.902895)
//                 size dx,dy,dz=(26.894882,3.927912,34.186335)
//                  center x,y,z=(-5.839449,-1.201658,7.8097275)
//                       diagonal 43.6745769436396
//Surface area................... 893.2420955073
//             Smallest face area 1.89355499423977E-5
//              Largest face area 39.3229180809653
//Memory allocated for geometry: 21 MBytes
// 
//==================================================
//IMPORTANT:
//This file was designed to run with the following command line options: 
// +W320 +H240 +FN +AM1 +A0.3 +r3 +Q9 +C -UA +MV3.7
//if you are not using an INI file copy and paste the text above to the command line box before rendering
 
 
global_settings {
  //This setting is for alpha transparency to work properly.
  //Increase by a small amount if transparent areas appear dark.
   max_trace_level 20
   adc_bailout 0.01
   assumed_gamma 1
 
}
#include "pov_POV_geom.inc" //Geometry
#include "colors.inc"
#include "textures.inc"
#include "shapes.inc"
#include "metals.inc"
#include "glass.inc"
#include "woods.inc"
 
//CAMERA PoseRayCAMERA
camera {
        //perspective
        //up <0,1,0>
        right -x*image_width/image_height
        location <0,35,20>
        look_at <0,0,0>
        angle 73 // horizontal FOV angle
        //rotate <0,0,0> //roll
        //rotate <-30,0,0> //pitch
        //rotate <0,45,0> //yaw
        translate <-5,0,5>
        }
 
//PoseRay default Light attached to the camera
/*light_source {
              <0,2.22044604925031E-16,87.3491538872791> //light position
              color rgb<188/255,218/255,216/255>
              parallel
              point_at <0,2.22044604925031E-16,0>
              rotate <0,0,0> //roll
              rotate <-25,0,0> //elevation
              rotate <0,45,0> //rotation
             } */

#declare Dist=100.0;
light_source {<0,70,-10> color White      
    spotlight
    point_at <0,0,0>
    radius 1
    tightness 20
    falloff 100
     fade_distance Dist fade_power 0.3
     translate <-5,0,5>}
     
#declare Fast = no;
#declare Floor =
plane
{ y, 0
  #if(Fast)
    pigment { color rgb <1, 1, 1> }
  #else
    texture
    { average texture_map
      { #declare S = seed(0);
        #local ReflColor = .8*<1, .9, .7> + .2*<1,1,1>;
        #declare Ind = 0;                                                                                                                                                                                                   
        #while(Ind < 20)
          [1 pigment { color White }
             normal { bumps .05 translate <rand(S),rand(S),rand(S)>*100 scale .001 }
             finish { reflection 0.25 ambient 0.05 phong 0.8 phong_size 200}
          ]                                                 
          #declare Ind = Ind+1;
        #end
      }
    }
  #end
} 

#declare T_Glass = texture {
   pigment { color red 1.0 green 1.0 blue 1.0 filter 0.95 }
   finish {
      ambient 0.0
      diffuse 0.0
      reflection 0.1
      phong 0.8
      phong_size 200
   }
}

 
#declare Spoon = object{spoon_
                        texture{T_Silver_4E pigment { White }
                                finish {
                                ambient 0.1
                                diffuse 0.1
                                phong 1
                                phong_size 200
                                roughness .001
                                reflection {
                                    0.25
                                    metallic
                                }
     }}
                        translate<3,3.1,10>
                        rotate<0,-30,0>}
                       
#declare Plate = object{plate_
                 texture{pigment{color rgb<1,1,1>}
                         finish {diffuse 1 specular 1}}
                 translate<-5,3,10>} 
#declare Frame = object{frame_
                        texture{pigment{color rgb<0,0,0>}
                                finish{phong 0.5 phong_size 10}}}
#declare Lens = object{lens_ texture { pigment{transmit 1}
                                       finish {ambient 0.5
                                               specular 1
                                               phong_size 400}}
                             interior{ior 1.5}
                      }

#declare Glasses = union{object{Frame}
                         //object{Lens}
                         translate<-5,3,-28>}

union{
    object{Spoon}
    object{Plate}
    object{Glasses}
    object{Floor}
    //rotate<28,40,0>    
    //translate<13,10,15>
    
}
 
//restore the version used outside this file
#version Temp_version;
//==================================================