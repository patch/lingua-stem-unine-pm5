package com.dlj.ir.analysis.ma;

import java.util.Map;
import java.util.WeakHashMap;
/**
 * Marathi light stemmer- removes number, gender and case suffixes from nouns and adjectives 
 * Done by Ljiljana Dolamic(University of Neuchatel, www.unine.ch/info/clef/)
 *         
 * @author Ljiljana Dolamic. Email: ljiljana.dolamic@unine.ch
 */
public class MarathiStemmerLight {

	/**
	 * A cache of words and their stems
	 */
	static private Map<String, String> cache = new WeakHashMap<String, String>();

	/**
	 * A buffer of the current word being stemmed
	 */
	private StringBuilder sb = new StringBuilder();

	/**
	 * Default constructor
	 */
	public MarathiStemmerLight() {
	}

	public String stem(String word) {
		String result = cache.get(word);

		if (result != null)
			return result;

		// 
		sb.delete(0, sb.length());

		// 
		sb.append(word);

		/* remove the case endings from nouns and adjectives */
		remove_case(sb);
		
		remove_No_Gender(sb);
			
		

		result = sb.toString();
		cache.put(word, result);

		return result;
	}
	private void remove_case(StringBuilder word) {
		int len = word.length() - 1;		
		if (len > 5) {
			if (word.substring(len-3, len+1).equals("शया")) {
				word.delete(len - 3, len + 1);
				return;
			}		
		} /* end if len > 5 */
		if (len > 4) {
			if (word.substring(len-2, len+1).equals("शे")) {
				word.delete(len - 2, len + 1);
				return;
			}
			if (word.substring(len-2, len+1).equals("शी")) {
				word.delete(len - 2, len + 1);
				return;
			}
			if (word.substring(len-2, len+1).equals("चा")) {
				word.delete(len - 2, len + 1);
				return;
			}
			if (word.substring(len-2, len+1).equals("ची")) {
				word.delete(len - 2, len + 1);
				return;
			}
			if (word.substring(len-2, len+1).equals("चे")) {
				word.delete(len - 2, len + 1);
				return;
			}
			if (word.substring(len-2, len+1).equals("हून")) {
				word.delete(len - 2, len + 1);
				return;
			}
		} /* end if len > 4 */
		if (len > 3) {
			if (word.substring( len-1, len+1).equals("नो")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring( len-1, len+1).equals("तो")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring( len-1, len+1).equals("ने")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring( len-1, len+1).equals("नी")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ही")) {
				word.delete(len -1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ते")) {
				word.delete(len -1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("या")) {
				word.delete(len -1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ला")) {
				word.delete(len -1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ना")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ऊण")) {
				word.delete(len - 1, len + 1);
				return;
			}
		} /* end if len > 3 */		
		if (len > 2) {
			if (word.substring(len, len+1).equals(" े")) {
				word.delete(len , len + 1);
				return;
			}
			if (word.substring(len, len+1).equals(" ी")) {
				word.delete(len , len + 1);
				return;
			}
			if (word.substring(len, len+1).equals("स")) {
				word.delete(len, len + 1);
				return;
			}
			if (word.substring(len, len+1).equals("ल")) {
				word.delete(len , len + 1);
				return;
			}
			if (word.substring(len, len+1).equals(" ा")) {
				word.delete(len , len + 1);
				return;
			}
			if (word.substring(len, len+1).equals("त")) {
				word.delete(len , len + 1);
				return;
			}
			if (word.substring(len, len+1).equals("म")) {
				word.delete(len , len + 1);
				return;
			}
		} /* end if len > 2 */
		return;
	}

	private void remove_No_Gender(StringBuilder word) {
		int len = word.length() - 1;				
		if (len > 5) {
			if (word.substring(len-3, len+1).equals(" ुरडा")) {
				word.delete(len - 3, len + 1);
				return;
			}			
		} /* end if len > 5 */
		if (len > 4) {
			if (word.substring( len- 2, len+1).equals("ढा")) {
				word.delete(len-2 , len + 1);
				return;
			}			
		} /* end if len > 4 */
		if (len > 3) {
			if (word.substring( len-1, len+1).equals("रु")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring( len-1, len+1).equals("डे")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring( len- 1, len+1).equals("ती")) {
				word.delete(len-1 , len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ान")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals(" ीण")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("डा")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("डी")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("गा")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ला")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ळा")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("या")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("वा")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ये")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("वे")) {
				word.delete(len - 1, len + 1);
				return;
			}
			if (word.substring(len-1, len+1).equals("ती")) {
				word.delete(len - 1, len + 1);
				return;
			}			
		} /* end if len > 4 */		
		if (len > 2) {
			if (word.substring(len, len+1).equals("अ")||
					word.substring(len, len+1).equals(" े")||
					word.substring(len, len+1).equals("ि ")||
					word.substring(len, len+1).equals(" ु")||
					word.substring(len, len+1).equals(" ौ")||
					word.substring(len, len+1).equals(" ै")) {
				word.delete(len, len + 1);
				return;
			}
			if (word.substring(len, len+1).equals(" ा")||
					word.substring(len, len+1).equals(" ी")||
					word.substring(len, len+1).equals(" ू")||
					word.substring(len, len+1).equals("त")) {
				word.delete(len , len + 1);
				return;
			}			
		} /* end if len > 2 */
		return;		
	}
}
