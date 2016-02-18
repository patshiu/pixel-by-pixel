String imagesDir01 = "/Users/patshiu/Dropbox/ITP/2016 Spring/Pixel_x_Pixel/Week1/HandwritingDarkness/data/01";
String imagesDir02 = "/Users/patshiu/Dropbox/ITP/2016 Spring/Pixel_x_Pixel/Week1/HandwritingDarkness/data/02";
String imagesDir03 = "/Users/patshiu/Dropbox/ITP/2016 Spring/Pixel_x_Pixel/Week1/HandwritingDarkness/data/03";
String imagesDir04 = "/Users/patshiu/Dropbox/ITP/2016 Spring/Pixel_x_Pixel/Week1/HandwritingDarkness/data/04";



void setup(){

	FloatDict brightnessData = new FloatDict();
	PImage test = loadImage("data/01/035.jpg");
	ArrayList<File> filesList01 = filesToArrayList(imagesDir01);
	ArrayList<File> filesList02 = filesToArrayList(imagesDir02);
	ArrayList<File> filesList03 = filesToArrayList(imagesDir03);
	ArrayList<File> filesList04 = filesToArrayList(imagesDir04);

	for(int i = 0; i < filesList01.size(); i++){

		PImage img01 = loadImage(filesList01.get(i).getAbsolutePath());
		PImage img02 = loadImage(filesList02.get(i).getAbsolutePath());
		PImage img03 = loadImage(filesList03.get(i).getAbsolutePath());
		PImage img04 = loadImage(filesList04.get(i).getAbsolutePath()); 

		float aggregateBrightness =  ( getDarkness(img01) + getDarkness(img02) + getDarkness(img03) + getDarkness(img04) ) * 0.25; 
		brightnessData.set( filesList01.get(i).getName().substring(0,3) , aggregateBrightness); 
	}

	//SORT ACCORDING TO BRIGHTNESS
	brightnessData.sortValuesReverse();

	//println(brightnessData);
	for(String k : brightnessData.keys()){
		println(char(Integer.parseInt(k)) + ": \t" + brightnessData.get(k));
	}

	brightnessData.sortValues();
	println("\n\n String for use in AsciiConverter");
	for(String k : brightnessData.keys()){		
		print(char(Integer.parseInt(k)));
	}

}

void draw(){
	exit();
}

float getDarkness(PImage img){
	int darkPixels = 0; 
	PGraphics pg = createGraphics(img.width, img.height);
	pg.beginDraw(); 
	pg.imageMode(CENTER);
	pg.image(img,width*0.5, height*0.5);
	pg.loadPixels();
	for(color c : pg.pixels){
		if( brightness(c) < 55){
			darkPixels++;
		}
	}
	float darkness = (darkPixels * 1.0) / pg.pixels.length;
	return darkness; 
}


ArrayList filesToArrayList(String imagesDirectory) {
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