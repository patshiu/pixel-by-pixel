String imagesDirectory = "/Users/patshiu/Dropbox/ITP/2016 Spring/Pixel_x_Pixel/Week1/AsciiConverter/data"; 
final int IMAGE_WIDTH = 140;
final int IMAGE_HEIGHT = 140; //3 Image pixels to on character
final int BRIGHTNESS_VALUES = 70 -1;

void setup(){
	size(140,140,P2D);
	background(255);
	imageMode(CENTER);
	colorMode(HSB, BRIGHTNESS_VALUES);//Break brightness down into 16 levels	
	ArrayList<File> filesList = filesToArrayList();

	for(File f: filesList){
		println("\n\n");
		//println(f.getName() + "path: " + f.getAbsolutePath());
		PImage img = loadImage(f.getAbsolutePath());
		image(img, width/2, height/2);
		loadPixels();
		//The equivalent statement to get(x, y) using pixels[] is pixels[y*width+x]
		for(int i = 0; i < pixels.length; i++){
			color c = pixels[i];
			float b = brightness(c);
			print(asciify(BRIGHTNESS_VALUES-b));
			if( (i+1) % IMAGE_WIDTH == 0){
				print("\r\n");
			}

			//Print b value for debugging
			// if(i % (IMAGE_WIDTH - 1) == 0 ){ //you have reached end of one line
			// 	print( b + "\r\n");
			// } else {
			// 	print( b );
			// }
		}
	}
}

void draw(){

}


void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
  }
}

void asciiConvert(PImage img){

}

String asciify(float b){ 
	//String keys = " .,:;i1tfLCG08W@"; //16 levels of brightness
	//String keys = "$@B%8&WM#*oahkbdpqwmZ0QOLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'. "; //70 levels of brightness
	//String keys = " .'`^\",:;Il!i><~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLOQ0Zmwqpdbkhao*#MW&8%B@$"; //70 levels of brightness
	//String keys = " .,:'`!_;1-I\"i/(|^~)\\lr?2c7vLj=<+uT]o>sCV60xYpOUz[aXtn4}JFK5S9fqhk3{Pbe8gDZHAwNdMy%$EW*&RmGBQ#@"; //CUSTOM: My Handwriting 95 levels
	String keys = " .,:'`!_;1-I\"i/(|^~)\\lr?2c7j=<+u]o>CV0xz[an4}JFKS9fk{P8ZHANM%$*&RGBQ#@"; //CUSTOM: My Handwriting 70 levels
	//String keys = " .:-=+*#%@"; //10 levels
	String[] sym = keys.split("");
	int x = min((int)b, sym.length - 1);
	return sym[x];
}

void printAscii(float[] brightnessData){
	for (int i = 0; i < brightnessData.length; i++){
		print(asciify(brightnessData[i]));
	}
	print("\r\n");
}

ArrayList filesToArrayList() {
	ArrayList<File> filesList = new ArrayList();
	String folderPath = imagesDirectory; 

	if(folderPath != null){
		File folder = new File(folderPath);
		File[] files = folder.listFiles();
		for (int i = 0; i < files.length; i++){
			String fileName = files[i].getName();
			if( fileName.equals(".DS_Store")){
				//skip
			} else {
				filesList.add(files[i]);
			}
		}
	}
	return(filesList);
}