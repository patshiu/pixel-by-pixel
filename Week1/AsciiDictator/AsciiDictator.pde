
String keys = " .'`^\",:;Il!i><~+_-?][}{1)(|\\/tfjrxnuvczXYUJCLOQ0Zmwqpdbkhao*#MW&8%B@$"; //70 levels of brightness

void setup(){
	String[] lines = loadStrings("poop_square_ratio.txt");
	println("there are " + lines.length + " lines");
	// for(String l : lines){
	// 	println(l);
	// }	

	for(int j = 0; j < lines.length; j++){
		String l = lines[j];
		for(int i = 0; i < l.length(); i++){
			if( (i + 1) % 10 == 0){
				print(toSpeech(l.charAt(i)) + "\n\t End of section " + (i+1)/10 + " of line " + (j+1) + "\n");
				
				if( (i+1) == 140 && (j+1)< lines.length){
					println("\tPrepare to proceed to following row, row number " + (j+2) );
				}
			} else {
				print(toSpeech(l.charAt(i)) + ",");
			}
			
		}	
	}
	
}

void draw(){
	noLoop();
	exit();
}

String toSpeech(char c){
	switch(c){

	case ' ': 
		return "nil";

	case '.': 
		return "Period";

	case ',': 
		return "Comma";

	case ':': 
		return "Colon";

	case '\'': 
		return "Single Quote";

	case '`': 
		return "BackTick";

	case '!': 
		return "Exclamation ";

	case '_': 
		return "Underscore";

	case ';': 
		return "Semicolon";

	case '1': 
		return "Digit 1 ";

	case '-': 
		return "Minus";

	case 'I': 
		return "Big I";

	case '\"': 
		return "Double Quotation";

	case 'i': 
		return "Small I";

	case '/': 
		return "Forward Slash";

	case '(': 
			return "Open Round Bracket";

	case '|': 
		return "Vertical ";

	case '^': 
		return "Cap Sign";

	case '~': 
		return "Tilde Sign";

	case ')': 
		return "Close Round Bracket";

	case '\\': 
		return "Back slash";

	case 'l': 
		return "Small L";

	case 'r': 
		return "Small R";

	case '?': 
		return "Question Mark";

	case '2': 
		return "Digit 2";

	case 'c': 
		return "Small C";

	case '7': 
		return "Digit 7 ";

	case 'v': 
		return "Small V";

	case 'L': 
		return "Big L";

	case 'j': 
		return "Small J";

	case '=': 
		return "Equals Sign";

	case '<': 
		return "Backward Angle Quote";

	case '+': 
		return "Plus Sign";

	case 'u': 
		return "Small U";

	case 'T': 
		return "Big T";

	case ']': 
		return "Close Square Bracket";

	case 'o': 
		return "Small O";

	case '>': 
		return "Forward Angle Quote";

	case 's': 
		return "Small S";

	case 'C': 
		return "Big C";

	case 'V': 
		return "Big V";

	case '6': 
		return "Digit 6";

	case '0': 
		return "Digit 0";

	case 'x': 
		return "Small X";

	case 'Y': 
		return "Big Y";

	case 'p': 
		return "Small P";

	case 'O': 
		return "Big O";

	case 'U': 
		return "Big U";

	case 'z': 
		return "Small Z";

	case '[': 
		return "Open Square Bracket";

	case 'a': 
		return "Small A";

	case 'X': 
		return "Big X";

	case 't': 
		return "Small T";

	case 'n': 
		return "Small N";

	case '4': 
		return "Digit 4";

	case '}': 
		return "Close Curly Bracket";

	case 'J': 
		return "Big J";

	case 'K': 
		return "Big K";

	case '5': 
		return "Digit 5";

	case 'S': 
		return "Big S";

	case '9': 
		return "Digit 9";

	case 'f': 
		return "Small F";

	case 'q': 
		return "Small Q";

	case 'h': 
		return "Small H";

	case 'k': 
		return "Small K";

	case '3': 
		return "Digit 3";

	case '{': 
		return "Open Curly Bracket";

	case 'P': 
		return "Big P";

	case 'b': 
		return "Small B";

	case 'e': 
		return "Small E";

	case '8': 
		return "Digit 8";

	case 'g': 
		return "small g";

	case 'D': 
		return "Big D";

	case 'Z': 
		return "Big Z";

	case 'H': 
		return "Big H";

	case 'A': 
		return "Big A";

	case 'w': 
		return "Small W";

	case 'N': 
		return "Big N";

	case 'd': 
		return "Small D";

	case 'M': 
		return "Big M";

	case 'y': 
		return "Small Y";

	case '%': 
		return "Percentage";

	case '$': 
		return "Dollar";

	case 'E': 
		return "Big E";

	case 'W': 
		return "Big W";

	case '*': 
		return "Asterisk";

	case '&': 
		return "Ampersand";

	case 'R': 
		return "Big R";

	case 'm': 
		return "Small M";

	case 'G': 
		return "Big G";

	case 'B': 
		return "Big B";

	case 'Q': 
		return "Big Q";

	case '#': 
		return "Pound Sign";

	case '@': 
		return "At Symbol";

	case 'F': 
		return "Big F";

		default: 
			return "error";
	}

}