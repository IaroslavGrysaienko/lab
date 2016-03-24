package classes;

import java.util.LinkedList;
import java.util.Queue;

public class RWayTrie implements Trie {
	/**
	 * Quantity of stored characters
	 */
	private static final int R = 26; // ASCII
	/**
	 * Root node of stored
	 */
	private Node root;

	/**
	 * Constructor, initialises root node
	 */
	public RWayTrie() {
		root = new Node();
	}

	private static class Node {
		private Object value;
		private Node[] next = new Node[R];

	}

	/**
	 * Gets stored value by key
	 * 
	 * @param key
	 *            to find stored value
	 * 
	 * @return stored value
	 */
	private Object get(String key) {
		if (key == null) {
			throw new NullPointerException("Trying to get access null key");
		}
		Node node = get(root, key, 0);
		if (node == null)
			return null;
		return node.value;
	}

	/**
	 * 
	 * @param node
	 * @param key
	 * @param index
	 * @return
	 */
	private Node get(Node node, String key, int index) {
		if (node == null) {
			return null;
		}
		if (index == key.length()) {
			return node;
		}
		char c = key.charAt(index);
		int intIndex = (int) c - 97;
		return get(node.next[intIndex], key, index + 1);
	}

	/**
	 * Retrieves all words of the vocabylary
	 */
	public Iterable<String> words() {
		return wordsWithPrefix("");
	}

	/**
	 * Retrieves words from the vocabulary by prefix
	 * 
	 * @param pref
	 */
	public Iterable<String> wordsWithPrefix(String pref) {
		Queue<String> q = new LinkedList<String>();
		collect(get(root, pref, 0), pref, q);
		return q;
	}

	private void collect(Node node, String pref, Queue<String> q) {
		if (node == null) {
			return;
		}
		if (node.value != null) {
			q.add(pref);
		}
		for (char c = 0; c < R; c++) {
			collect(node.next[c], pref + (char)(c + 97), q);
		}
	}

	/**
	 * Retrieves size of the vocabulary
	 */
	public int size() {
		return size(root);
	}

	private int size(Node node) {
		if (node == null) {
			return 0;
		}
		int nodeCounter = 0;
		if (node.value != null) {
			nodeCounter++;
		}
		for (char c = 0; c < R; c++) {
			nodeCounter += size(node.next[c]);
		}
		return nodeCounter;
	}

	/**
	 * Add tuple to the vocabulary
	 */
	public void add(Tuple tuple) {
		root = add(root, tuple.getTerm(), tuple.getWeight(), 0);

	}

	private Node add(Node node, String key, Object value, int index) {
		if (node == null) {
			node = new Node();
		}
		if (index == key.length()) {
			node.value = value;
			return node;
		}
		char c = key.charAt(index);
		int intIndex = (int) c - 97;
		node.next[intIndex] = add(node.next[intIndex], key, value, index + 1);
		return node;
	}

	/**
	 * Checks whether vocabulary contains word
	 */
	public boolean contains(String word) {
		return get(word) != null;

	}

	public boolean delete(String word) {
		int initialSize = size();
		root = delete(root, word, 0);
		int sizeAfterDeletion = size();
		return (initialSize - sizeAfterDeletion) == 1;
	}

	private Node delete(Node node, String word, int index) {
		if (node == null) {
			return null;
		}
		if (index == word.length()) {
			node.value = null;
		} else {
			char c = word.charAt(index);
			int intIndex = (int) c - 97;
			node.next[intIndex] = delete(node.next[intIndex], word, index + 1);
		}

		if (node.value != null) {
			return node;
		}
		for (char c = 0; c < R; c++) {
			if (node.next[c] != null)
				return node;
		}
		return null;
	}
}
