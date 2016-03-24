package classes;
/**
 * 
 */

/**
 * Represents class for store string and its length
 * 
 * @author Iaroslav_Grytsaienko
 */
public class Tuple {

	private String term;

	private int weight;

	public Tuple(String s) {
		term = s;
		weight = s.length();
	}

	public String getTerm() {
		return term;
	}

	public int getWeight() {
		return weight;
	}

}
