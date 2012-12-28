/**
 * Takes gedcom files on command line and at least parses them.
 *
 * This class should morph into a cmd-line utility that can be run to ingest
 * a gedcom into a git-ged repository, but initially I just need to get my
 * feet wet with Dallan's parser to see how it works.
 *
 * @author John Sumsion
 */
public class SampleIngester {

  public static void main(String[] args) {
    for (String arg : args) {
      System.out.println("parsing: " + arg);
    }
  }
}
