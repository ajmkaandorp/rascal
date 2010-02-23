module viz::Figure::Core

import Integer;
import List;
import Set;
import IO;

/*
 * Declarations and library functions for Rascal Visualization
 */
 
 /*
  * Colors and color management
  */

alias Color = int;

@doc{Gray color (0-255)}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java gray(int gray);

@doc{Gray color (0-255) with transparency}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java gray(int gray, real alpha);

@doc{Gray color as percentage (0.0-1.0)}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java gray(real perc);

@doc{Gray color with transparency}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java gray(real perc, real alpha);

@doc{Named color}
@reflect{Needs calling context when generating an exception}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java color(str colorName);

@doc{Named color with transparency}
@reflect{Needs calling context when generating an exception}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java color(str colorName, real alpha);

@doc{RGB color}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java rgb(int r, int g, int b);

@doc{RGB color with transparency}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public Color java rgb(int r, int g, int b, real alpha);

@doc{Interpolate two colors (in RGB space)}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public list[Color] java interpolateColor(Color from, Color to, real percentage);

@doc{Create a list of interpolated colors}
@javaClass{org.rascalmpl.library.viz.Figure.FigureLibrary}
public list[Color] java colorSteps(Color from, Color to, int steps);

@doc{Create a colorscale}
public Color(int) colorScale(list[int] values, Color from, Color to){
   mn = min(values);
   range = max(values) - mn;
   sc = colorSteps(from, to, 10);
   return Color(int v) { return sc[(9 * (v - mn)) / range]; };
}

@doc{Create a fixed color palette}
private list[str] p12 = [ "navy", "violet", "yellow", "aqua", 
                          "red", "darkviolet", "maroon", "green",
                          "teal", "blue", "olive", "lime"];

@doc{Return named color from fixed palette}
public str palette(int n){
  try 
  	return p12[n];
  catch:
    return "black";
}

/*
 * FProperty -- visual properties of visual elements
 */
 
 public FProperty left(){
   return hanchor(0.0);
 }
 
 public FProperty hcenter(){
   return hanchor(0.5);
 }
 
 public FProperty right(){
   return hanchor(1.0);
 }
 
 public FProperty top(){
   return vanchor(0.0);
 }
 
 public FProperty vcenter(){
   return vanchor(0.5);
 }
 
 public FProperty bottom(){
   return vanchor(1.0);
 }
 
 public FProperty center(){
   return anchor(0.5, 0.5);
 }
 
 alias FProperties = list[FProperty];

data FProperty =
/* sizes */
     width(real width)                  // sets width of element
   | width(int iwidth)
   | height(real height)                // sets height of element
   | height(int iheight)
   | size(real size)					// sets width and height to same value
   | size(int isize)
   | size(real hor, real vert)          // sets width and height to separate values
   | size(int ihor, int ivert)
   | gap(real amount)                   // sets hor and vert gap between elements in composition to same value
   | gap(int iamount)
   | gap(real hor, real vert) 			// sets hor and vert gap between elements in composition to separate values
   | gap(int ihor, int ivert)
   
/* alignment */
   | anchor(real h, real v)				// horizontal (0=left; 1=right) & vertical anchor (0=top,1=bottom)
   | hanchor(real h)
   | vanchor(real v)
   
/* line and border properties */
   | lineWidth(int lineWidth)			// line width
   | lineColor(Color lineColor)		    // line color
   | lineColor(str colorName)           // named line color
   
   | fillColor(Color fillColor)			// fill color of shapes and text
   | fillColor(str colorName)           // named fill color
   
/* wedge properties */
   | fromAngle(real angle)
   | fromAngle(int iangle)
   | toAngle(real angle)
   | toAngle(int iangle)
   | innerRadius(real radius)
   | innerRadius(int iradius)

   
/* font and text properties */
   | font(str fontName)             	// named font
   | fontSize(int isize)                // font size
   | fontColor(Color textColor)         // font color
   | fontColor(str colorName)
   | textAngle(real angle)              // text rotation
   | textAngle(int iangle) 
   
/* interaction properties */
   | mouseOver(FProperties props)       // switch to new properties when mouse is over element
   | mouseOver(FProperties props, Figure inner)
                                        // display new inner element when mouse is over current element
   
/* other properties */
   | id(str name)                       // name of elem (used in edges and various layouts)
   | connected()                        // shapes consist of connected points
   | closed()    						// closed shapes
   | curved()                           // use curves instead of straight lines
   ;

/*
 * Vertex and Edge: auxiliary data types
 */

data Vertex = 
     vertex(real x, real y)             	// vertex in a shape
   | vertex(int ix, int iy) 
   | vertex(int ix, real y)  
   | vertex(real x, int iy)           
   | vertex(real x, real y, Figure marker)  // vertex with marker
   | vertex(int ix, int iy, Figure marker)
   | vertex(int ix, real y, Figure marker)
   | vertex(real x, int iy, Figure marker)
   ;
   
data Edge =
     edge(str from, str to) 			 	// edge between between two elements in complex shapes like tree or graph
   | edge(FProperties, str from, str to) 	// 
   ;

/*
 * Figure: a visual element, the principal visualization datatype
 */
 
 alias Figures = list[Figure];
 
data Figure = 
/* atomic primitives */

     text(FProperties props, str s)		  		// text label
   | text(str s)			              		// text label
   
/* primitives/containers */

   | box(FProperties props)			          	// rectangular box
   | box(FProperties props, Figure inner)       // rectangular box with inner element
   
   | ellipse(FProperties props)			      	// ellipse
   | ellipse(FProperties props, Figure inner)   // ellipse with inner element
   
   | wedge(FProperties props)			      	// wedge
   | wedge(FProperties props, Figure inner)     // wedge with inner element
   
   | space(FProperties props)			      	// invisible box (used for spacing)
   | space(FProperties props, Figure inner)     // invisible box with visible inner element
 
/* composition */
   
   | use(Figure elem)                            // use another elem
   | use(FProperties props, Figure elem)
 
   | hcat(Figures elems)                         // horizontal concatenation
   | hcat(FProperties props, Figures elems)
   
   | vcat(Figures elems)                         // vertical concatenation
   | vcat(FProperties props, Figures elems)
   
   | align(Figures elems)                        // horizontal and vertical composition
   | align(FProperties props, Figures elems)
   
   | overlay(Figures elems)                      // overlay (stacked) composition
   | overlay(FProperties props, Figures elems)
   
   | shape(list[Vertex] points)                  // shape of to be connected vertices
   | shape(FProperties props,list[Vertex] points)
   
   | grid(Figures elems)                         // placement on fixed grid
   | grid(FProperties props, Figures elems)
   
   | pack(Figures elems)                         // composition by 2D packing
   | pack(FProperties props, Figures elems)
   
   | pie(Figures elems)                          // composition as pie chart
   | pie(FProperties props, Figures elems)
   
   | graph(Figures nodes, list[Edge] edges)      // composition of nodes and edges as graph
   | graph(FProperties, Figures nodes, list[Edge] edges)
   
                								// composition of nodes and edges as tree
   | tree(Figures nodes, list[Edge] edges, str root) 
   | tree(FProperties, Figures nodes, list[Edge] edges, str root)
   
/* transformation */

   | rotate(real angle, Figure elem)			// Rotate element around its anchor point
   | scale(real perc, Figure)					// Scale element (same for h and v)
   | scale(real xperc, real yperc, Figure elem)	// Scale element (different for h and v)
   ;
   
/*
 * Wishlist:
 * - arrows
 * - textures
 * - boxes with round corners
 * - dashed/dotted lines
 * - ngons
 * - svg/png/pdf export
 */

