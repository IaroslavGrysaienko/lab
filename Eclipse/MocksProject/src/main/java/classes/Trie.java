package classes;

public interface Trie {
        // ƒобавл€ет в Trie пару слово - term, и его вес - weight.
        // ¬ качестве веса используйте длину слова
        public void add(Tuple tuple);

        // есть ли слово в Trie
        public boolean contains(String word);

        // удал€ет слово из Trie
        public boolean delete(String word);

        // итератор по всем словам, обход в ширину
        public Iterable<String> words();

        // итератор по всем словам, начинающимс€ с pref, обход в ширину
        public Iterable<String> wordsWithPrefix(String pref);

        // к-во слов в Trie
        public int size();

}
