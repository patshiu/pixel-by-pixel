class Histogram {
  float avgBrightness, maxLum, minLum, avgContrast, percentageDark, percentageBright;
  int totalPixels, brightPixels, darkPixels;
  float[] pixelPerBrightness;
  float[] graphData;
  PGraphics graph;

  Histogram() {
    graph = createGraphics(255,100);
  }



  void chart(color[] pixels){
    totalPixels = 0;
    brightPixels = 0;
    darkPixels = 0;
    pixelPerBrightness = new float[256];
    graphData = new float[256];
    maxLum = 0;
    minLum = 255;
    for(color c : pixels){
      totalPixels++;
      colorMode(HSB, 255);
      int lum = floor(brightness(c));
      maxLum = max(maxLum, lum);
      minLum = min(minLum, lum);
      if(lum > 255*0.75){
        brightPixels++;
      } else if(lum < 255*0.25){
        darkPixels++;
      }
      pixelPerBrightness[lum]++;
    }

    //Analzy data
    avgContrast = (maxLum - minLum) / (maxLum + minLum);
    percentageBright = (brightPixels*1.0)/totalPixels;
    percentageDark = (darkPixels*1.0)/totalPixels;
    // if(frameCount % 10 == 0){
    //   println("brightPx: " + brightPixels + "\t darkpx: " + darkPixels + "\t totalPixels: " + totalPixels);
    //   println("% bright px: " + percentageBright + "\t %dark px: " + percentageDark);
    // }

    for(int i=0; i < pixelPerBrightness.length; i++){
      float percentOfTotal = pixelPerBrightness[i]/totalPixels;
      graphData[i] = percentOfTotal;
    }

    //Draw chart
    float chartVertScale = 80.0;
    drawAxes();
    graph.beginDraw();
    int i = 0;
    graph.fill(0);
    graph.textSize(10);
    graph.textAlign(LEFT, TOP);
    graph.text("avg contrast: " + avgContrast, 10, 10);
    for(float p : graphData){
      graph.stroke(0);
      if(i < 255 * 0.25){
        graph.stroke(#FF0000);
      }
      if(i > 255 * 0.75){
        graph.stroke(#0000FF);
      }
      graph.strokeWeight(1);
      graph.line(i,graph.height, i, graph.height-(p*chartVertScale*100));
      i++;
    }
    graph.endDraw();
  }

  PImage show(){
    return graph;
  }

  void drawAxes(){
    graph.beginDraw();
      graph.noSmooth();
      graph.background(255);
      graph.strokeWeight(0.5);
      graph.stroke(0);
      graph.line(0,graph.height,graph.width,graph.height);
    graph.endDraw();
  }
}
